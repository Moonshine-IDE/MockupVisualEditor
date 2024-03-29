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
    import flash.events.Event;

    import interfaces.IComponentSizeOutput;
	import interfaces.ILookup;
	import interfaces.ISurface;

	import mx.utils.StringUtil;
    
    import spark.components.TextInput;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IIdAttribute;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.primeFaces.propertyEditors.InputTextPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IInputText;
    import components.primeFaces.InputText;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces inputText component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;InputText
     * <b>Attributes</b>
     * id=""
     * width="100"
     * height="30"
     * value=""
     * maxlength=""
     * required="false"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:inputText
     * <b>Attributes</b>
     * id=""
     * style="width:100px;height:30px;"
     * value=""
     * maxlength=""
     * required="false"/&gt;
     * </pre>
     */
    public class InputText extends TextInput implements IGetChildrenSurfaceComponent, IIdAttribute,
            IHistorySurfaceComponent, IComponentSizeOutput
    {
        public static const DOMINO_XML_ELEMENT_NAME:String = "field";
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "inputText";
        public static const ELEMENT_NAME:String = "InputText";
		
		private var component:IInputText;
		
        public function InputText()
        {
            super();
			
			component = new components.primeFaces.InputText();
			
            this.mouseChildren = false;
            this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
			this.maxHeight = 30;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "textChanged",
				"maxLengthChanged",
                "idAttributeChanged"
            ];
			
			this.prompt = "Input Text";
        }

        private var _widthOutput:Boolean = true;
        protected var widthOutputChanged:Boolean;

        [Bindable]
        public function get widthOutput():Boolean
        {
            return _widthOutput;
        }

        public function set widthOutput(value:Boolean):void
        {
            if (_widthOutput != value)
            {
                _widthOutput = value;

                if (!value)
                {
                    widthOutputChanged = true;
                    this.invalidateProperties();
                }
            }
        }

        private var _heightOutput:Boolean = true;
        protected var heightOutputChanged:Boolean;

        [Bindable]
        public function get heightOutput():Boolean
        {
            return _heightOutput;
        }

        public function set heightOutput(value:Boolean):void
        {
            if (_heightOutput != value)
            {
                _heightOutput = value;

                if (!value)
                {
                    heightOutputChanged = true;
                    this.invalidateProperties();
                }
            }
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

        private var _idAttribute:String;
		[Bindable(event="idAttributeChanged")]
        /**
         * <p>PrimeFaces: <strong>id (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText id=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText id=""/&gt;</listing>
         */
        public function get idAttribute():String
        {
            return _idAttribute;
        }
		
        public function set idAttribute(value:String):void
        {
            if (_idAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "idAttribute", _idAttribute, value);
				
                _idAttribute = value;
                dispatchEvent(new Event("idAttributeChanged"))
            }
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="width:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputText width="100"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="width:100px;height:30px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputText percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="height:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputText height="30"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

		private var _maxLength:String = "";
		[Bindable(event="maxLengthChanged")]
        /**
         * <p>PrimeFaces: <strong>maxlength (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText maxlength=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText maxlength=""/&gt;</listing>
         */
        public function get maxLength():String
		{
			return _maxLength;
		}

		public function set maxLength(value:String):void
		{
			if (_maxLength != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "maxLength", _maxLength, value);
				
				_maxLength = value;
				dispatchEvent(new Event("maxLengthChanged"));
			}
		}


        [Inspectable(category="General", defaultValue="")]
        [Bindable("textChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText value=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText value=""/&gt;</listing>
         */
        override public function get text():String
        {
            return super.text;
        }

		override public function set text(value:String):void
		{
			if (super.text != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "text", super.text, value);
				
				super.text = value;
				dispatchEvent(new Event("textChanged"));
			}
		}

        private var _required:Boolean;
        private var requiredChanged:Boolean;

        [Bindable(event="requiredChanged")]
        /**
         * <p>PrimeFaces: <strong>required</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText required="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText required="false"/&gt;</listing>
         */
        public function get required():Boolean
        {
            return _required;
        }

        public function set required(value:Boolean):void
        {
            if (_required != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "required", _required, value);

                _required = value;
                requiredChanged = true;

                dispatchEvent(new Event("requiredChanged"));
            }
        }

        public function get propertyEditorClass():Class
        {
            return InputTextPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (this.widthOutputChanged)
            {
                this.percentWidth = Number.NaN;
                this.width = Number.NaN;
                this.widthOutputChanged = false;
            }

            if (this.heightOutputChanged)
            {
                this.percentHeight = Number.NaN;
                this.height = Number.NaN;
                this.heightOutputChanged = false;
            }
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            xml.@value = this.text;
            xml.@required = this.required;

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

			if ((StringUtil.trim(maxLength).length != 0) && Math.round(Number(maxLength)) != 0)
			{
				xml.@maxlength = this.maxLength;
			}

            return xml;
        }

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

			component.fromXML(xml, callback, localSurface, lookup);
			
            this.text = component.text;
			this.maxLength = component.maxLength;
            this.idAttribute = component.idAttribute;
            this.required = component.required;
        }

        public function toCode():XML
        {
            component.text = this.text;
            component.required = this.required;
			component.maxLength = this.maxLength;
			component.idAttribute = this.idAttribute;
				
			component.isSelected = this.isSelected;
			(component as components.primeFaces.InputText).width = this.width;
			(component as components.primeFaces.InputText).height = this.width;
			(component as components.primeFaces.InputText).percentWidth = this.percentWidth;
			(component as components.primeFaces.InputText).percentHeight = this.percentHeight;
			
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
