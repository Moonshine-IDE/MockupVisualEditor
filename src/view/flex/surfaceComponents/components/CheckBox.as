////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package view.flex.surfaceComponents.components
{
    import flash.events.Event;

    import spark.components.CheckBox;

    import view.flex.surfaceComponents.skins.CheckBoxSkin;

    import view.interfaces.IFlexSurfaceComponent;

	import view.flex.propertyEditors.CheckBoxPropertyEditor;

	public class CheckBox extends spark.components.CheckBox implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "CheckBox";
		public static const ELEMENT_NAME:String = "checkbox";

		public function CheckBox()
		{
            super();

            this.setStyle("skinClass", CheckBoxSkin);
            this.setStyle("color", "#6A6A6A");
            this.setStyle("fontSize", 12);

			this.label = "Check Box";
			this.toolTip = "";
			this.width = 90;
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
				"selectedChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return CheckBoxPropertyEditor;
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

			xml.@text = this.label;
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			this.label = xml.@text;
			this.selected = xml.@selected == "true";
		}

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            setCommonXMLAttributes(xml);

            return xml;
        }

        override public function set selected(value:Boolean):void
        {
			if (super.selected != value)
			{
				dispatchEvent(new Event("selectedChanged"));
			}

            super.selected = value;
        }

        override protected function buttonReleased():void
        {
            //we don't want the selection to change on the editing surface
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
            xml.@selected = this.selected;
		}
    }
}
