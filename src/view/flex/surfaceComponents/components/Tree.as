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
package view.flex.surfaceComponents.components
{
	import interfaces.ILookup;
	import interfaces.ISurface;

	import mx.collections.IList;
	import mx.controls.Tree;
	import mx.events.FlexEvent;
	
	import utils.MxmlCodeUtils;
	
	import view.interfaces.IFlexSurfaceComponent;

	public class Tree extends mx.controls.Tree implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "Tree";
		public static const ELEMENT_NAME:String = "tree";

		public function Tree()
		{
			this.mouseChildren = false;
			var data:Array =
			[
				{
					label: "A",
					children:
					[
						{ label: "A-1" },
						{ label: "A-2" }
					]
				},
				{
					label: "B",
					children:
					[
						{ label: "B-1" }
					]
				}
			];
			this.dataProvider = data;
			this.width = 120;
			this.height = 120;
			this.minWidth = 20;
			this.minHeight = 20;
			this.addEventListener(FlexEvent.CREATION_COMPLETE, tree_creationCompleteHandler);

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return null;
		}
		
		private var _isSelected:Boolean;
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			setCommonXMLAttributes(xml);

			return xml;
		}

		public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
		}

		private function tree_creationCompleteHandler(event:FlexEvent):void
		{
			var dataProvider:IList = IList(this.dataProvider);
			var childCount:int = dataProvider.length;
			for(var i:int = 0; i < childCount; i++)
			{
				var item:Object = dataProvider.getItemAt(i);
				this.expandItem(item, true);
			}
		}

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");
            var mxNamespace:Namespace = new Namespace("mx", "library://ns.adobe.com/flex/mx");
            xml.addNamespace(mxNamespace);
            xml.setNamespace(mxNamespace);

            setCommonXMLAttributes(xml);

            return xml;
        }

		public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
		public function toRora():XML
        {
            return null;
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
		}
    }
}
