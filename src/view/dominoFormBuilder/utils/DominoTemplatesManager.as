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
package view.dominoFormBuilder.utils
{
	import flash.filesystem.File;
	
	import utils.MoonshineBridgeUtils;

	public class DominoTemplatesManager
	{
		public static function getFormTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("form.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getFormParTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("form-par.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getTableTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("table.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getTableRowTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("table-row.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getTableCellTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("table-cell.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getFieldTemplate(type:String, multivalue:Boolean, editable:String):String
		{
			var fileName:String = "field_"+ type.toLowerCase() +"_";
			fileName += (multivalue ? "m" : "s") +"_";
			switch(editable)
			{
				case "Editable":
					fileName += "e";
					break;
				case "Computed":
					fileName += "c";
					break;
				case "Compute on compose":
					fileName += "cwc";
					break;
				case "Compute for display":
					fileName += "cfd";
					break;
			}
			
			// since we have file-access problem within library project
			// we'll request the file available in main application sandbox
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile(fileName +".dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getViewTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("view.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getViewColumn():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("view-column.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		private static function readAndReturnAsString(path:File):String
		{
			return MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.read(path);
		}
	}
}