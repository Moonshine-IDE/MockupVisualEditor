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

	import spark.components.Label;

    import view.interfaces.IFlexSurfaceComponent;

	import view.flex.propertyEditors.HyperlinkPropertyEditor;

	public class Hyperlink extends Label implements IFlexSurfaceComponent
	{
		public static const ELEMENT_NAME:String = "hyperlink";

		public function Hyperlink()
		{
			this.text = "Hyperlink";
			this.width = 60;
			this.height = 15;
			this.minWidth = 10;
			this.minHeight = 10;
		}

		public function get propertyEditorClass():Class
		{
			return HyperlinkPropertyEditor;
		}

		private var _url:String = "http://www.example.com/";

		[Bindable("urlChange")]
		public function get url():String
		{
			return this._url;
		}

		public function set url(value:String):void
		{
			if(this._url === value)
			{
				return;
			}
			this._url = value;
			this.dispatchEvent(new Event("urlChange"));
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
			xml.@x = this.x;
			xml.@y = this.y;
			xml.@width = this.width;
			xml.@height = this.height;
			xml.@text = this.text;
			xml.@url = this.url;
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			this.text = xml.@text;
			this.url = xml.@url;
		}

        public function toCode():XML
        {
            return null;
        }

        public function get propertiesChangedEvents():Array
        {
            return null;
        }
    }
}
