////////////////////////////////////////////////////////////////////////////////
// Copyright 2022 Prominic.NET, Inc.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software 
// distributed under the License is distributed on an "AS IS" BASIS, 
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and 
// limitations under the License
// 
// Author: Prominic.NET, Inc.
// No warranty of merchantability or fitness of any kind. 
// Use this software at your own risk.
////////////////////////////////////////////////////////////////////////////////
package view.domino.surfaceComponents.components
{
    import data.OrganizerItem;

    import flash.events.Event;

    import interfaces.IRoyaleComponentConverter;

    import mx.collections.ArrayList;

    import mx.controls.DateChooser;

    import mx.controls.DateField;
    import mx.states.State;

    import spark.formatters.DateTimeFormatter;

    import utils.XMLCodeUtils;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.domino.propertyEditors.CalendarPropertyEditor;
    import view.primeFaces.supportClasses.Container;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;
    import interfaces.components.ICalendar;
    import components.primeFaces.Calendar;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="modes", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="setCurrentState", kind="method")]
    [Exclude(name="createChildren", kind="method")]
    [Exclude(name="updateDisplayList", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of Calendar in HTML</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;Calendar
     * <b>Attributes</b>
     * selectedDate=""
     * width="120"
     * height="120"
     * mode="popup"
     * minDate=""
     * maxDate=""
     * pattern="MM/dd/yyyy"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:calendar
     * <b>Attributes</b>
     * value=""
     * style="width:120px;height:120px;"
     * mode="popup"
     * minDate=""
     * maxDate""
     * pattern="MM/dd/yyyy"/&gt;
     * </pre>
     */
    public class DominoCalendar extends Container implements IGetChildrenSurfaceComponent, IHistorySurfaceComponent, IRoyaleComponentConverter
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "calendar";
        public static const ELEMENT_NAME:String = "Calendar";

		private var component:ICalendar;
		
        private var dateTimeFormatter:DateTimeFormatter;

        private var dateChooser:DateChooser;
        private var dateField:DateField;

        public function DominoCalendar()
        {
            super();
			
			component = new components.primeFaces.Calendar();
			
            this.width = 120;
            this.minWidth = 20;
            this.minHeight = 20;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "modeChanged",
                "selectedDateChanged",
                "minDateChanged",
                "maxDateChanged",
                "patternChanged"
            ];

            dateTimeFormatter = new DateTimeFormatter();
            initializeStates();

            this.setStyle("borderVisible", false);
        }

        private var _cdataXML:XML;

        public function get cdataXML():XML
        {
            return _cdataXML;
        }

        private var _cdataInformation:String;

        public function get cdataInformation():String
        {
            return _cdataInformation;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:80%;"/&gt;</listing>
         */
        override public function get percentWidth():Number
        {
            return super.percentWidth;
        }

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:120px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="height:80%;"/&gt;</listing>
         */
        override public function get percentHeight():Number
        {
            return super.percentHeight;
        }

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div height="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="height:120px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        override public function set height(value:Number):void
        {
            super.height = value;
        }

        private var _selectedDate:Date;
        private var selectedDateChanged:Boolean;

        [Bindable("selectedDateChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @default null
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Calendar selectedDate=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:calendar value=""/&gt;</listing>
         */
        public function get selectedDate():Date
        {
            return _selectedDate;
        }

        public function set selectedDate(value:Date):void
        {
            if (_selectedDate == value) return;
            _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "selectedDate", _minDate, value);

            _selectedDate = value;

            this.selectedDateChanged = true;
            this.invalidateProperties();
            dispatchEvent(new Event("selectedDateChanged"));
        }

        private var _mode:String = "popup";

        [Bindable("modeChanged")]
        /**
         * <p>PrimeFaces: <strong>mode</strong></p>
         *
         * @default "popup"
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Calendar mode="popup"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:calendar mode="popup"/&gt;</listing>
         */
        public function get mode():String
        {
            return _mode;
        }

        public function set mode(value:String):void
        {
            if (_mode == value) return;
            _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "mode", _mode, value);

            _mode = value;

            currentState = value;
            dispatchEvent(new Event("modeChanged"));
        }

        private var minMaxDateChanged:Boolean;

        private var _minDate:Date;

        [Bindable("minDateChanged")]
        /**
         * <p>PrimeFaces: <strong>minDate</strong></p>
         *
         * @default null
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Calendar minDate=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:calendar minDate=""/&gt;</listing>
         */
        public function get minDate():Date
        {
            return _minDate;
        }

        public function set minDate(value:Date):void
        {
            if (_minDate == value) return;
            _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "minDate", _minDate, value);

            _minDate = value;
            this.minMaxDateChanged = true;
            this.invalidateProperties();
            dispatchEvent(new Event("minDateChanged"));
        }

        private var _maxDate:Date;

        [Bindable("maxDateChanged")]
        /**
         * <p>PrimeFaces: <strong>maxDate</strong></p>
         *
         * @default null
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Calendar maxDate=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:calendar maxDate=""/&gt;</listing>
         */
        public function get maxDate():Date
        {
            return _maxDate;
        }

        public function set maxDate(value:Date):void
        {
            if (_maxDate == value) return;
            _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "maxDate", _maxDate, value);

            _maxDate = value;
            this.minMaxDateChanged = true;
            this.invalidateProperties();
            dispatchEvent(new Event("maxDateChanged"));
        }

        private var _pattern:String = "MM/dd/yyyy";
        private var patternChanged:Boolean;

        [Bindable("patternChanged")]
        /**
         * <p>PrimeFaces: <strong>pattern</strong></p>
         *
         *  @default "MM/dd/yyyy"
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Calendar pattern=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:calendar pattern=""/&gt;</listing>
         */
        public function get pattern():String
        {
            return _pattern;
        }

        public function set pattern(value:String):void
        {
            if (_pattern == value) return;

            if (!value)
            {
                value = "MM/dd/yyyy";
            }

            _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "pattern", _pattern, value);

            _pattern = value;
            patternChanged = true;
            this.invalidateProperties();
            dispatchEvent(new Event("patternChanged"));
        }

        private var _modes:ArrayList = new ArrayList([
            {label: "popup"}, {label: "inline"}
        ]);

        public function get modes():ArrayList
        {
            return _modes;
        }

        public function get propertyEditorClass():Class
        {
            return CalendarPropertyEditor;
        }
		
		private var _isUpdating:Boolean;
		public function get isUpdating():Boolean
		{
			return _isUpdating;
		}
		
		public function set isUpdating(value:Boolean):void
		{
			_isUpdating = value;
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
		
		private var _propertyChangeFieldReference:PropertyChangeReference;
		public function get propertyChangeFieldReference():PropertyChangeReference
		{
			return _propertyChangeFieldReference;
		}
		
		public function set propertyChangeFieldReference(value:PropertyChangeReference):void
		{
			_propertyChangeFieldReference = value;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
        {
            _propertyChangeFieldReference = new PropertyChangeReference(this, fieldName, oldValue, newValue);
        }

        public function restorePropertyOnChangeReference(nameField:String, value:*, eventType:String=null):void
		{
			this[nameField.toString()] = value;
		}

        override protected function createChildren():void
        {
            super.createChildren();

            if (!dateChooser)
            {
                dateChooser = new DateChooser();
                dateChooser.percentHeight = dateChooser.percentWidth = 100;

                addElement(dateChooser);
            }

            if (!dateField)
            {
                dateField = new DateField();
                dateField.percentHeight = dateChooser.percentWidth = 100;

                addElement(dateField);
            }

            currentState = this.mode;
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (selectedDateChanged || patternChanged)
            {
                if (mode == "popup")
                {
                    this.dateField.formatString = this.pattern.toUpperCase();
                    this.dateField.selectedDate = this.selectedDate;
                }
                else if (mode == "inline")
                {
                    this.dateChooser.selectedDate = this.selectedDate;
                }
                selectedDateChanged = false;
                patternChanged = false;
            }

            if (minMaxDateChanged)
            {
                var disabledRanges:Array = [{rangeEnd: this.minDate}, {rangeStart: this.maxDate}];

                if (mode == "popup")
                {
                    this.dateField.disabledRanges = disabledRanges;
                }
                else if (mode == "inline")
                {
                    this.dateChooser.disabledRanges = disabledRanges;
                }

                minMaxDateChanged = false;
            }
        }

        override public function setCurrentState(stateName:String, playTransition:Boolean = true):void
        {
            super.setCurrentState(stateName, playTransition);

            if (dateChooser)
            {
                dateChooser.visible = dateChooser.includeInLayout = stateName == "inline";
                dateChooser.width = 170;
                dateChooser.height = 175;
            }

            if (dateField)
            {
                dateField.visible = dateField.includeInLayout = stateName == "popup";
                dateField.width = 120;
                dateField.height = Number.NaN;
            }
        }

        public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return new OrganizerItem(this, ELEMENT_NAME);
		}

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            xml.@mode = this.mode;
            xml.@pattern = this.pattern;

            this.dateTimeFormatter.dateTimePattern = this.pattern;
            if (this.minDate)
            {
                xml.@minDate = dateTimeFormatter.format(this.minDate);
            }

            if (this.maxDate)
            {
                xml.@maxDate = dateTimeFormatter.format(this.maxDate);
            }

            if (this.selectedDate)
            {
                xml.@selectedDate = dateTimeFormatter.format(this.selectedDate);
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

			this.component.fromXML(xml, callback);

            this.pattern = component.pattern;

            var upperPattern:String = this.pattern.toUpperCase();
            this.selectedDate = DateField.stringToDate(component.selectedDate, upperPattern);
            this.minDate = DateField.stringToDate(component.minDate, upperPattern);
            this.maxDate = DateField.stringToDate(component.maxDate, upperPattern);

            this.mode = component.mode;
        }

        public function toCode():XML
        {
            component.mode = this.mode;
            component.pattern = this.pattern;

            this.dateTimeFormatter.dateTimePattern = this.pattern;
            if (this.minDate)
            {
                component.minDate = dateTimeFormatter.format(this.minDate);
            }

            if (this.maxDate)
            {
                component.maxDate = dateTimeFormatter.format(this.maxDate);
            }

            var formattedDate:String = dateTimeFormatter.format(this.selectedDate);
            if (formattedDate)
            {
                component.selectedDate = formattedDate;
            }

			component.isSelected = this.isSelected;
			(component as components.primeFaces.Calendar).width = this.width;
			(component as components.primeFaces.Calendar).height = this.width;
			(component as components.primeFaces.Calendar).percentWidth = this.percentWidth;
			(component as components.primeFaces.Calendar).percentHeight = this.percentHeight;

            return component.toCode();
        }

        public	function toRoyaleConvertCode():XML
		{
			return new XML("");
		}

        private function initializeStates():void
        {
            var state:State = new State({name: "popup"});
            this.states.push(state);

            state = new State({name: "inline"});
            this.states.push(state);
        }
    }
}
