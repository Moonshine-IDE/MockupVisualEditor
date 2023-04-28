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
package utils
{
    import mx.collections.ArrayCollection;
    
    import view.VisualEditor;
    import view.interfaces.IDominoFormBuilderLibraryBridge;
    import view.interfaces.IVisualEditorLibraryBridge;

	public class MoonshineBridgeUtils
	{
		public static var currentFilePath:String;
		public static var moonshineBridge:IVisualEditorLibraryBridge;
		public static var moonshineBridgeFormBuilderInterface:IDominoFormBuilderLibraryBridge;

        private static var _filesList:ArrayCollection;

		public static function get filesList():ArrayCollection
		{
			if (_filesList)
            {
                _filesList.refresh();
            }

			return _filesList;
		}
		
		public static function hasFilesInList():Boolean
		{
			return _filesList && _filesList.length > 0;
		}

		public static function onXHtmlFilesUpdated(value:ArrayCollection):void
		{
			if (_filesList != value)
			{
                _filesList = value;
				if (value)
				{
					value.filterFunction = function(item:Object):Boolean {
						return currentFilePath.indexOf(item.resourcePath) == -1;
                    }
				}
			}
		}
		
		public static function getVisualEditorComponent():VisualEditor
		{
			if(moonshineBridge==null){
				return null;
			}else{
				return moonshineBridge.getVisualEditorComponent();
			}
			
		}

		public static function getRelativeFilePath():String
		{
			return moonshineBridge.getRelativeFilePath();
		}
	}
}