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
package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import spark.components.CheckBox;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.primeFaces.propertyEditors.CheckboxPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.CheckboxSkin;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.ISelectBooleanCheckbox;
    import components.primeFaces.SelectBooleanCheckbox;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
	[Exclude(name="buttonReleased", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces selectBooleanCheckbox component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;CheckBox
     * <b>Attributes</b>
     * width="121"
     * height="20"
     * label="Checkbox"
	 * selected="false"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:selectBooleanCheckbox
     * <b>Attributes</b>
     * style="width:121px;height:20px;"
     * label="Checkbox"
	 * value="null"/&gt;
     * </pre>
     */
    public class SelectBooleanCheckbox extends CheckBox implements IGetChildrenSurfaceComponent, IHistorySurfaceComponent, ICDATAInformation
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "selectBooleanCheckbox";
		public static const ELEMENT_NAME:String = "CheckBox";
		
		private var component:ISelectBooleanCheckbox;
		
		public function SelectBooleanCheckbox()
		{
			super();
			
			component = new components.primeFaces.SelectBooleanCheckbox();
			
            this.setStyle("skinClass", CheckboxSkin);

			this.selected = true;
			this.label = "Checkbox";
			this.toolTip = "";
			this.width = 121;
			this.height = 20;
			this.minWidth = 20;
			this.minHeight = 20;
			this.mouseChildren = false;
			
			_propertiesChangedEvents = [
					"widthChanged",
					"heightChanged",
					"explicitMinWidthChanged",
					"explicitMinHeightChanged",
					"contentChange",
					"selectedChanged"
			];
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

        public function get propertyEditorClass():Class
        {
            return CheckboxPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
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
         * <listing version="3.0">&lt;CheckBox percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectBooleanCheckbox style="width:80%;"/&gt;</listing>
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
         * @default "121"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;CheckBox width="121"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectBooleanCheckbox style="width:121px;height:20px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;CheckBox percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectBooleanCheckbox style="height:80%;"/&gt;</listing>
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
         * @default "20"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;CheckBox height="20"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectBooleanCheckbox style="width:121px;height:20px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }


        [Inspectable(category="General", defaultValue="true")]
        [Bindable(event="propertyChange")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
		 * @default null in PrimeFaces
		 *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;CheckBox selected="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectBooleanCheckbox value="null"/&gt;</listing>
         */
        override public function get selected():Boolean
        {
            return super.selected;
        }

        override public function set selected(value:Boolean):void
		{
			if (super.selected != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "selected", super.selected, value);
				
				super.selected = value;
				dispatchEvent(new Event("selectedChanged"));
			}
		}

        [Bindable("contentChange")]
        [Inspectable(category="General", defaultValue="Checkbox")]
        /**
         * <p>PrimeFaces: <strong>label</strong></p>
         *
         * @default "Checkbox"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;CheckBox label="Checkbox"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectBooleanCheckbox label="Checkbox"/&gt;</listing>
         */
        override public function get label():String
        {
            return super.label;
        }

		override public function set label(value:String):void
		{
			if (super.label != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "label", super.label, value);
				
				super.label = value;
			}
		}
		
		override protected function buttonReleased():void
		{
			//we don't want the selection to change on the editing surface
		}

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

			xml.@label = this.label;
			xml.@selected = this.selected;

			return xml;
		}

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

			component.fromXML(xml, callback, localSurface, lookup);
			
            this.label = component.label;
            this.selected = component.selected;
        }

		public function toCode():XML
		{
			component.selected = this.selected;
			component.label = this.label;
			
			component.isSelected = this.isSelected;
			(component as components.primeFaces.SelectBooleanCheckbox).width = this.width;
			(component as components.primeFaces.SelectBooleanCheckbox).height = this.width;
			(component as components.primeFaces.SelectBooleanCheckbox).percentWidth = this.percentWidth;
			(component as components.primeFaces.SelectBooleanCheckbox).percentHeight = this.percentHeight;
			
			return component.toCode();
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
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, null));
		}
	}
}