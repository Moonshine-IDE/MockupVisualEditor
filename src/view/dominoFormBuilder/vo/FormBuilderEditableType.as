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
	import mx.collections.ArrayList;

	[Bindable] public class FormBuilderEditableType
	{
		public static const EDITABLE:String = "Editable";
		public static const COMPUTED:String = "Computed";
		public static const COMPUTE_ON_COMPOSE:String = "Compute on compose";
		public static const COMPUTE_FOR_DISPLAY:String = "Compute for display";
		
		private static var _editableTypes:ArrayList;
		public static function get editableTypes():ArrayList
		{
			if (!_editableTypes)
			{
				_editableTypes = new ArrayList([
					EDITABLE, COMPUTED, COMPUTE_ON_COMPOSE,
					COMPUTE_FOR_DISPLAY
				]);
			}
			
			return _editableTypes;
		}
		
		private static var _editableTypesRichtext:ArrayList;
		public static function get editableTypesRichtext():ArrayList
		{
			if (!_editableTypesRichtext)
			{
				_editableTypesRichtext = new ArrayList([
					EDITABLE, COMPUTED
				]);
			}
			
			return _editableTypesRichtext;
		}
	}
}