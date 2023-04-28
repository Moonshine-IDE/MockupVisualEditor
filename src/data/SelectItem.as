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
package data
{
	[Bindable] public class SelectItem
	{
		public var itemLabel:String;
		public var itemValue:String;
		public var itemVar:String;
		public var value:String;
		public var isSelected:Boolean;
		
		public function SelectItem()
		{
		}
		
		public function isItemChanged(comparedTo:Object):Boolean
		{
			if (comparedTo.hasOwnProperty("itemLabel") && comparedTo.itemLabel != this.itemLabel) return true;
			if (comparedTo.hasOwnProperty("itemValue") && comparedTo.itemValue != this.itemValue) return true;
			if (comparedTo.hasOwnProperty("itemVar") && comparedTo.itemVar != this.itemVar) return true;
			if (comparedTo.hasOwnProperty("value") && comparedTo.value != this.value) return true;
			if (comparedTo.hasOwnProperty("isSelected") && comparedTo.isSelected != this.isSelected) return true;
			
			return false;
		}
		
		public function updateItemWith(value:SelectItem):void
		{
			this.itemLabel = value.itemLabel;
			this.itemValue = value.itemValue;
			this.itemVar = value.itemVar;
			this.value = value.value;
			this.isSelected = value.isSelected;
		}
	}
}
