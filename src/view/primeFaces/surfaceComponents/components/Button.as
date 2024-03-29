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
package view.primeFaces.surfaceComponents.components
{
    import components.primeFaces.Button;

    import flash.events.Event;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import interfaces.components.IButton;

    import spark.components.Button;
    
    import data.OrganizerItem;

    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.primeFaces.propertyEditors.ButtonPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.ButtonSkin;
    import view.suportClasses.PropertyChangeReference; 

    [Exclude(name="propertyChangeFieldReference", kind="property")]
	[Exclude(name="actionListener", kind="property")]
	[Exclude(name="isCommandButton", kind="property")]
    [Exclude(name="isUpdating", kind="property")]

	[Exclude(name="propertiesChangedEvents", kind="property")]
	[Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="isSelected", kind="property")]
	[Exclude(name="PRIME_FACES_XML_ELEMENT_NAME_COMMAND_BUTTON", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces button component</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;Button
	 * <b>Attributes</b>
	 * width="100"
	 * height="30"
	 * disabled="false"
	 * value="Button"
	 * title=""/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:button
	 * <b>Attributes</b>
	 * style="width:100px;height:30px;"
	 * disabled="false"
	 * value="Button"
	 * title=""/&gt;
     * </pre>
     */
    public class Button extends spark.components.Button implements IGetChildrenSurfaceComponent, IHistorySurfaceComponent
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "button";
		public static const PRIME_FACES_XML_ELEMENT_NAME_COMMAND_BUTTON:String = "commandButton";
		public static const ELEMENT_NAME:String = "Button";

		private var component:IButton;

		public function Button()
		{
			super();

            component = new components.primeFaces.Button();

            this.setStyle("skinClass", ButtonSkin);

			this.label = "Button";
			this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
			
			_propertiesChangedEvents = [
					"widthChanged",
					"heightChanged",
					"explicitMinWidthChanged",
					"explicitMinHeightChanged",
					"enabledChanged",
					"labelChanged",
					"toolTipChanged",
					"isCommandButtonChanged",
					"actionListenerChanged"
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

		private var _isCommandButton:Boolean;
		
		[Bindable("isCommandButtonChanged")]
		public function get isCommandButton():Boolean
		{
			return _isCommandButton;
		}
		
		public function set isCommandButton(value:Boolean):void
		{
			if (_isCommandButton != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "isCommandButton", _isCommandButton, value);
				
				_isCommandButton = value;
				dispatchEvent(new Event("isCommandButtonChanged"));
			}
		}

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Button percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button style="width:80%;"/&gt;</listing>
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
         * @default "100"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Button width="100"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button style="width:100px;height:30px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;Button percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button style="height:80%;"/&gt;</listing>
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
         * @default "30"
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;Button height="30"/&gt;</listing>
         * @example
		 * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        private var _enabled:Boolean = true;

        [Bindable("enabledChanged")]
        [Inspectable(category="General", enumeration="true,false", defaultValue="true")]
        /**
         * <p>PrimeFaces: <strong>disabled</strong></p>
         *
         * @default "false"
		 * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Button disabled="false"/&gt;</listing>
         * @example
		 * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button disabled="false"/&gt;</listing>
         */
        override public function get enabled():Boolean
        {
            return _enabled;
        }


        [Inspectable(category="General", enumeration="true,false", defaultValue="true")]
        override public function set enabled(value:Boolean):void
        {
			if (_enabled != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "enabled", _enabled, value);
                _enabled = value;
                invalidateSkinState();
				dispatchEvent(new Event("enabledChanged"));
            }
        }

        [Bindable("labelChanged")]
        /**
		 * <p>PrimeFaces: <strong>value</strong></p>
		 *
		 * @default "Button"
		 *
		 * @example
         * <strong>Visual Editor:</strong>
         * <listing version="3.0">&lt;Button value="Button"/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:button value="Button"/&gt;</listing>
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
				dispatchEvent(new Event("labelChanged"));
			}
		}
		
		[Bindable("toolTipChanged")]
        /**
		 * <p>PrimeFaces: <strong>title</strong></p>
         *
		 * @example
         * <strong>Visual Editor:</strong>
         * <listing version="3.0">&lt;Button title=""/&gt;</listing>
		 *
         * @example
		 * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button title=""/&gt;</listing>
         */
		override public function set toolTip(value:String):void
		{
			if (super.toolTip != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "toolTip", super.toolTip, value);
				
				super.toolTip = value;
				dispatchEvent(new Event("toolTipChanged"));
			}
		}
		
		private var _actionListener:String;
		
		[Bindable("actionListenerChanged")]
		public function get actionListener():String
		{
			return _actionListener;
		}
		
		public function set actionListener(value:String):void
		{
			if (_actionListener != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "actionListener", _actionListener, value);
				
				_actionListener = value;
				dispatchEvent(new Event("actionListenerChanged"));
			}
		}

        public function get propertyEditorClass():Class
		{
			return ButtonPropertyEditor;
		}		
		
		private var _propertiesChangedEvents:Array;
		public function get propertiesChangedEvents():Array
		{
			return _propertiesChangedEvents;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

			xml.@disabled = !this.enabled;
            xml.@value = this.label;
			xml.@title = this.toolTip;
			xml.@isCommandButton = this.isCommandButton.toString();
			xml.@actionListener = this.isCommandButton ? this.actionListener : "";

			return xml;
		}

        public function fromXML(xml:XML, childFromXMLCallback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

            component.fromXML(xml, childFromXMLCallback, localSurface, lookup);

            this.enabled = component.enabled;
			this.isCommandButton = component.isCommandButton;
            this.label = component.label;
            this.toolTip = component.toolTip;
			this.actionListener = component.actionListener;
        }

		public function toCode():XML
		{
			component.enabled = this.enabled;
			component.label = this.label;
			component.toolTip = this.toolTip;
			component.isCommandButton = this.isCommandButton;
			component.actionListener = this.actionListener;
            component.isSelected = this.isSelected;

            (component as components.primeFaces.Button).width = this.width;
            (component as components.primeFaces.Button).height = this.height;
            (component as components.primeFaces.Button).percentWidth = this.percentWidth;
            (component as components.primeFaces.Button).percentHeight = this.percentHeight;

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