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
    import flash.events.Event;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import spark.components.Panel;
    
    import utils.MxmlCodeUtils;
    
    import view.flex.propertyEditors.WindowPropertyEditor;
    import view.flex.surfaceComponents.skins.WindowSkin;
    import view.interfaces.IFlexSurfaceComponent;
    import view.interfaces.ISurfaceComponent;

	public class Window extends Panel implements IFlexSurfaceComponent
	{
        public static const MXML_ELEMENT_NAME:String = "Panel";
		public static var ELEMENT_NAME:String = "window";

		public function Window()
		{
			super();

            this.setStyle("skinClass", WindowSkin);
            this.setStyle("color", "#6A6A6A");
            this.setStyle("fontSize", 12);

			this.title = "Panel";
			this.width = 200;
			this.height = 200;
			this.minWidth = 20;
			this.minHeight = 20;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"titleChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return WindowPropertyEditor;
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

        override public function set title(value:String):void
        {
			if (super.title != value)
			{
				 dispatchEvent(new Event("titleChanged"));
			}
            super.title = value;
        }

        public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			setCommonXMLAttributes(xml);

			var elementCount:int = this.numElements;
			for(var i:int = 0; i < elementCount; i++)
			{
				var element:ISurfaceComponent = this.getElementAt(i) as ISurfaceComponent;
				if(element === null)
				{
					continue;
				}
				xml.appendChild(element.toXML());
			}
			return xml;
		}

		public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
		{
			var localSurface:ISurface = surface;

			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			this.title = xml.@title;
			var elementsXML:XMLList = xml.elements();
			var childCount:int = elementsXML.length();
			for(var i:int = 0; i < childCount; i++)
			{
				var childXML:XML = elementsXML[i];
				callback(this, lookup, childXML, localSurface);
			}
		}

        public function toCode():XML
        {
			var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");

            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);
			
            setCommonXMLAttributes(xml);

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IFlexSurfaceComponent = this.getElementAt(i) as IFlexSurfaceComponent;
                if(element === null)
                {
                    continue;
                }

                xml.appendChild(element.toCode());
            }

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
            xml.@title = this.title;
		}
    }
}
