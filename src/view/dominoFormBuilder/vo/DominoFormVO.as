////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) STARTcloud, Inc. 2015-2022. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the Server Side Public License, version 1,
//  as published by MongoDB, Inc.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  Server Side Public License for more details.
//
//  You should have received a copy of the Server Side Public License
//  along with this program. If not, see
//
//  http://www.mongodb.com/licensing/server-side-public-license
//
//  As a special exception, the copyright holders give permission to link the
//  code of portions of this program with the OpenSSL library under certain
//  conditions as described in each individual source file and distribute
//  linked combinations including the program with the OpenSSL library. You
//  must comply with the Server Side Public License in all respects for
//  all of the code used other than as permitted herein. If you modify file(s)
//  with this exception, you may extend this exception to your version of the
//  file(s), but you are not obligated to do so. If you do not wish to do so,
//  delete this exception statement from your version. If you delete this
//  exception statement from all source files in the program, then also delete
//  it in the license file.
//
////////////////////////////////////////////////////////////////////////////////
package view.dominoFormBuilder.vo
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import view.dominoFormBuilder.utils.DominoTemplatesManager;
	
	[Bindable] 
	public class DominoFormVO extends EventDispatcher
	{
		public static const ELEMENT_NAME:String = "form";
		
		public var formName:String;
		public var viewName:String;
		public var hasWebAccess:Boolean;
		public var fields:ArrayCollection = new ArrayCollection();
		public var dxlGeneratedOn:Date;
		public var pageContent:XML;
		
		/**
		 * CONSTRUCTOR
		 */
		public function DominoFormVO()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC API
		//
		//--------------------------------------------------------------------------
		
		public function fromXML(value:XML, callback:Function=null):void
		{
			this.formName = value.form.@name;
			this.hasWebAccess = (value.form.@hasWebAccess == "true") ? true : false;
			this.viewName = value.form.viewName;
			if ("@dxlGeneratedOn" in value.form)
			{
				this.dxlGeneratedOn = new Date(Date.parse(
					String(value.form.@dxlGeneratedOn)
				));
			}
			
			for each (var field:XML in value.form.fields.field)
			{
				var tmpField:DominoFormFieldVO = new DominoFormFieldVO();
				tmpField.fromXML(field);
				fields.addItem(tmpField);
			}
			
			if (callback != null)
			{
				callback();
			}
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			xml.@hasWebAccess = hasWebAccess.toString();
			xml.@name = formName;
			
			var tempXML:XML = <viewName/>;
			tempXML.appendChild(new XML("\<![CDATA[" + viewName + "]]\>"));
			xml.appendChild(tempXML);
			
			tempXML = <fields/>;
			for each (var field:DominoFormFieldVO in fields)
			{
				tempXML.appendChild(field.toXML());
			}
			xml.appendChild(tempXML);
			
			if (!dxlGeneratedOn) dxlGeneratedOn = new Date();
			xml.@dxlGeneratedOn = dxlGeneratedOn.toUTCString();
			return xml;
		}
		
		//--------------------------------------------------------------------------
		//
		//  DXL/XML
		//
		//--------------------------------------------------------------------------
		
		public function toCode():String
		{
			var table:String = DominoTemplatesManager.getTableTemplate();
			
			// generate rows/columns
			var tmpRows:String = "";
			for each (var field:DominoFormFieldVO in fields)
			{
				tmpRows += field.toCode();
			}
			
			table = table.replace(/%rows%/ig, tmpRows);
			return table;
		}
		
		public function toViewColumnsCode():String
		{
			var column:String = DominoTemplatesManager.getViewColumn();
			
			// generate rows/columns
			var tmpColumns:String = "";
			var tmpColumn:String = "";
			for each (var field:DominoFormFieldVO in fields)
			{
				if (field.isIncludeInView)
				{
					tmpColumn = column.replace(/%fieldname%/ig, field.name);
					tmpColumn = tmpColumn.replace(/%sort%/ig, field.sortOption.value);
					tmpColumn = tmpColumn.replace(/%categorized%/ig, field.sortOption.isCategorized.toString());
					tmpColumn = tmpColumn.replace(/%label%/ig, field.label);
					
					tmpColumns += tmpColumn;
				}
			}
			
			return tmpColumns;
		}
	}
}