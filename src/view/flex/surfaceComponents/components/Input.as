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
	import interfaces.ILookup;
	import interfaces.ISurface;

	import spark.components.TextInput;
	
	import utils.MxmlCodeUtils;
	
	import view.flex.propertyEditors.InputPropertyEditor;
	import view.flex.surfaceComponents.skins.InputSkin;
	import view.interfaces.IFlexSurfaceComponent;

	public class Input extends spark.components.TextInput implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "TextInput";
		public static const ELEMENT_NAME:String = "input";
		private static const DOMINO_ELEMENT_NAME:String = "field";

		public function Input()
		{
			super();

            this.setStyle("skinClass", InputSkin);
            this.setStyle("color", "#6A6A6A");
            this.setStyle("fontSize", 12);

			this.editable = false;
			this.selectable = false;
			this.text = "Text Input|";
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
                "textChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return InputPropertyEditor;
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
			this.text = xml.@text;
		}

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

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

		public function toDominoCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, DOMINO_ELEMENT_NAME) + "/>");
          

            setDominoCommonXMLAttributes(xml);

            return xml;
        }

		private function setDominoCommonXMLAttributes(xml:XML):void
		{
			/**
			 * full dxl field Attributes please access follow url
			 * https://www.ibm.com/support/knowledgecenter/en/SSVRGU_9.0.1/basic/H_FIELD_ELEMENT_XML.html
			 * we only implement a basic attibutes setting in here
			 */
		  	xml.@type = 'text';
            xml.@kind = 'editable';
			xml.@allowmultivalues='false';
            xml.@width = this.width;
            xml.@height = this.height;
            // xml.@text = this.text;
		}

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
            xml.@text = this.text;
		}
    }
}
