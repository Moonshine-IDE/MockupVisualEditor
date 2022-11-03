////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2016-present Prominic.NET, Inc.
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
	import view.dominoFormBuilder.utils.DominoTemplatesManager;

	[Bindable] public class DominoFormFieldVO
	{
		public static const ELEMENT_NAME:String = "field";
		
		public var name:String;
		public var label:String = "";
		public var description:String = "";
		public var type:String = FormBuilderFieldType.fieldTypes.getItemAt(0) as String;
		public var editable:String = FormBuilderEditableType.editableTypes.getItemAt(0) as String;
		public var formula:String = "";
		public var sortOption:Object = FormBuilderSortingType.sortTypes.getItemAt(0);
		public var isMultiValue:Boolean;
		public var isIncludeInView:Boolean = true;
		
		public function DominoFormFieldVO()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC API
		//
		//--------------------------------------------------------------------------
		
		public function fromXML(value:XML, callback:Function=null):void
		{
			this.name = value.@name;
			this.type = value.@type;
			this.editable = value.@editable;
			this.isMultiValue = (value.@isMultiValue == "true") ? true : false;
			this.isIncludeInView = (value.@isIncludeInView == "true") ? true : false;
			
			for each (var sortType:Object in FormBuilderSortingType.sortTypes.source)
			{
				if (value.@sortOption == sortType.label)
				{
					this.sortOption = sortType;
					break;
				}
			}
			
			this.label = value.label;
			this.description = value.description;
			this.formula = value.formula;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			
			xml.@name = name;
			xml.@type = type;
			xml.@editable = editable;
			xml.@sortOption = sortOption.label;
			xml.@isMultiValue = isMultiValue.toString();
			xml.@isIncludeInView = isIncludeInView.toString();
			
			var tempXML:XML = <label/>;
			tempXML.appendChild(new XML("\<![CDATA[" + label + "]]\>"));
			xml.appendChild(tempXML);
			
			tempXML = <description/>;
			tempXML.appendChild(new XML("\<![CDATA[" + description + "]]\>"));
			xml.appendChild(tempXML);
			
			tempXML = <formula/>;
			tempXML.appendChild(new XML("\<![CDATA[" + formula + "]]\>"));
			xml.appendChild(tempXML);
			
			return xml;
		}
		
		//--------------------------------------------------------------------------
		//
		//  DXL/XML
		//
		//--------------------------------------------------------------------------
		
		public function toCode():String
		{
			var row:String = DominoTemplatesManager.getTableRowTemplate();
			var cell:String = DominoTemplatesManager.getTableCellTemplate();
			
			// for now until Dmytro provides
			// template of table-row having predefined
			// table-column/cell, we'll generate manual 3
			var tmpAllColumns:String = "";
			var tmpField:String;
			for (var i:int; i < 3; i++)
			{
				tmpAllColumns = cell.replace(/%cellbody%/ig, label);
				
				tmpField = DominoTemplatesManager.getFieldTemplate(type, isMultiValue, editable);
				if (tmpField)
				{
					tmpField = tmpField.replace(/%fieldname%/ig, name);
					tmpField = tmpField.replace(/%computedvalue%/ig, formula);
				}
				tmpAllColumns += cell.replace(/%cellbody%/ig, tmpField ? tmpField : '');
				
				tmpAllColumns += cell.replace(/%cellbody%/ig, description);
			}
			
			row = row.replace(/%cells%/ig, tmpAllColumns);
			return row;
		}
	}
}