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
package view.flex.surfaceComponents.components
{
    import flash.events.Event;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import spark.components.RadioButton;
    
    import utils.MxmlCodeUtils;
    
    import view.flex.propertyEditors.RadioButtonPropertyEditor;
    import view.flex.surfaceComponents.skins.RadioButtonSkin;
    import view.interfaces.IFlexSurfaceComponent;

	public class RadioButton extends spark.components.RadioButton implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "RadioButton";
		public static const ELEMENT_NAME:String = "radiobutton";

		public function RadioButton()
		{
            super();

            this.setStyle("skinClass", RadioButtonSkin);
            this.setStyle("color", "#6A6A6A");
            this.setStyle("fontSize", 12);

			this.label = "Radio Button";
			this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "contentChange",
                "selectedChanged",
                "groupNameChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return RadioButtonPropertyEditor;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
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

        override public function set selected(value:Boolean):void
        {
            if (super.selected != value)
            {
                dispatchEvent(new Event("selectedChanged"));
            }

            super.selected = value;
        }

        override public function set groupName(value:String):void
        {
            if (super.groupName != value)
            {
                dispatchEvent(new Event("groupNameChanged"));
            }

            super.groupName = value;
        }

        override protected function buttonReleased():void
		{
			//we don't want the selection to change on the editing surface
		}

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
            xml.@text = this.label;
            setCommonXMLAttributes(xml);

            return xml;
        }

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
            this.x = xml.@x;
            this.y = xml.@y;
            this.width = xml.@width;
            this.height = xml.@height;
            this.label = xml.@text;
            this.selected = xml.@selected == "true";
            this.groupName = xml.@groupName;
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            xml.@label = this.label;
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
            xml.@selected = this.selected;
            xml.@groupName = this.groupName;
		}
    }
}
