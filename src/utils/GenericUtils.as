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
package utils
{
	import flash.display.InteractiveObject;

	import view.interfaces.IHistorySurfaceComponent;
	import view.interfaces.ISurfaceComponent;
	import view.suportClasses.PropertyChangeReference;
	import 	mx.collections.SortField;
	import 	mx.collections.Sort;
	import mx.collections.ArrayCollection;

	public class GenericUtils
	{
		public static function getWidth(value:InteractiveObject):String
		{
			if (value.hasOwnProperty("percentWidth") && !isNaN(value["percentWidth"])) return value["percentWidth"]+"%";
			return value.width.toString();
		}
		
		public static function applyPercentageWidthHeight(selectedItem:ISurfaceComponent, width:String, height:String, isWidth:Boolean):void
		{
			var pattern:RegExp = new RegExp(/(%)/g);
			var newValue:String = isWidth ? width.replace(pattern, "") : height.replace(pattern, "");
			var historyComponent:IHistorySurfaceComponent = selectedItem as IHistorySurfaceComponent;
			
			if (historyComponent) historyComponent.propertyChangeFieldReference = new PropertyChangeReference(historyComponent);
			
			if (isWidth)
			{
				if (historyComponent)
				{
					historyComponent.propertyChangeFieldReference.fieldLastValue = [{field:"width", value:selectedItem.width}, {field:"percentWidth", value:selectedItem.percentWidth}];
					historyComponent.propertyChangeFieldReference.fieldNewValue = [{field:"width", value:NaN}, {field:"percentWidth", value:Number(newValue)}];
				}
				
				selectedItem.percentWidth = Number(newValue);
				selectedItem.width = Number.NaN;
			}
			else
			{
				if (historyComponent)	
				{
					historyComponent.propertyChangeFieldReference.fieldLastValue = [{field:"height", value:selectedItem.height}, {field:"percentHeight", value:selectedItem.percentHeight}];
					historyComponent.propertyChangeFieldReference.fieldNewValue = [{field:"height", value:NaN}, {field:"percentHeight", value:Number(newValue)}];
				}
				
				selectedItem.percentHeight = Number(newValue);
				selectedItem.height = Number.NaN;
			}
		}
		
		public static function applyMinAndMaxWidth(selectedItem:ISurfaceComponent, newWidth:Number):String
		{
			var minWidth:Number = selectedItem.minWidth;
			var maxWidth:Number = selectedItem.maxWidth;
			var historyComponent:IHistorySurfaceComponent = selectedItem as IHistorySurfaceComponent;
			
			if (newWidth < minWidth)
			{
				newWidth = minWidth;
			}
			else if (newWidth > maxWidth)
			{
				newWidth = maxWidth;
			}
			
			if (historyComponent)	
			{
				historyComponent.propertyChangeFieldReference = new PropertyChangeReference(historyComponent);
				historyComponent.propertyChangeFieldReference.fieldLastValue = [{field:"width", value:selectedItem.width}, {field:"percentWidth", value:selectedItem.percentWidth}];
				historyComponent.propertyChangeFieldReference.fieldNewValue = [{field:"width", value:newWidth}, {field:"percentWidth", value:NaN}];
			}
			
			selectedItem.percentWidth = Number.NaN;
			selectedItem.width = newWidth;
			//the text might not have updated if the width property is the same
			//but the old text value is different
			return selectedItem.width.toString();
		}
		
		public static function applyMinAndMaxHeight(selectedItem:ISurfaceComponent, newHeight:Number):String
		{
			var minHeight:Number = selectedItem.minHeight;
			var maxHeight:Number = selectedItem.maxHeight;
			var historyComponent:IHistorySurfaceComponent = selectedItem as IHistorySurfaceComponent;
			
			if (newHeight < minHeight)
			{
				newHeight = minHeight;
			}
			else if (newHeight > maxHeight)
			{
				newHeight = maxHeight;
			}
			
			if (historyComponent)	
			{
				historyComponent.propertyChangeFieldReference = new PropertyChangeReference(historyComponent);
				historyComponent.propertyChangeFieldReference.fieldLastValue = [{field:"height", value:selectedItem.height}, {field:"percentHeight", value:selectedItem.percentHeight}];
				historyComponent.propertyChangeFieldReference.fieldNewValue = [{field:"height", value:newHeight}, {field:"percentHeight", value:NaN}];
			}
			
			selectedItem.percentHeight = Number.NaN;
			selectedItem.height = newHeight;
			//the text might not have updated if the height property is the same
			//but the old text value is different
			return selectedItem.height.toString();
		}

		public static function getRandomId(prefix:String):String
		{
			var v:Number = 1 + Math.random() * (100 - 1);

			return prefix + String(Math.round(v));
		}

		public static function arrayCollectionSort(ar:ArrayCollection, fieldName:String, isNumeric:Boolean):ArrayCollection 
		{
			var dataSortField:SortField = new SortField();
			dataSortField.name = fieldName;
			dataSortField.numeric = isNumeric;
			var numericDataSort:Sort = new Sort();
			numericDataSort.fields = [dataSortField];
			ar.sort = numericDataSort;
			ar.refresh();
			return ar;
		}
	}
}