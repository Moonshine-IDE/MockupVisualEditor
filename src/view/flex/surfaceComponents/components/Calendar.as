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

	import mx.controls.DateChooser;
    import mx.formatters.DateFormatter;
    import mx.utils.ObjectUtil;
    
    import utils.MxmlCodeUtils;
    
    import view.flex.propertyEditors.CalendarPropertyEditor;
    import view.interfaces.IFlexSurfaceComponent;

	public class Calendar extends DateChooser implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "DateChooser";
		public static const ELEMENT_NAME:String = "calendar";

		public function Calendar()
		{
			this.mouseChildren = false;
			this.width = 200;
			this.height = 200;
			this.minWidth = 150;
			this.minHeight = 150;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"selectedDateChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return CalendarPropertyEditor;
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

        override public function set selectedDate(value:Date):void
        {
			if (ObjectUtil.dateCompare(super.selectedDate, value) != 0)
			{
				dispatchEvent(new Event("selectedDateChanged"));
			}

            super.selectedDate = value;
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
			if("@date" in xml)
			{
				this.selectedDate = DateFormatter.parseDateString(xml.@date);
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
            if(this.selectedDate !== null)
            {
                xml.@date = this.selectedDate.toDateString();
            }
		}
    }
}
