package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.formatters.NumberBaseRoundType;
    import mx.utils.StringUtil;
    
    import spark.components.TextInput;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.IComponentSizeOutput;

    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IIdAttribute;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.InputNumberPropertyEditor;
    import view.primeFaces.supportClasses.InputNumberFormatter;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;

    [Exclude(name="commitProperties", kind="method")]

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="EVENT_CHILDREN_UPDATED", kind="property")]
    [Exclude(name="DEFAULT_DECIMAL_SEPARATOR", kind="property")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces inputNumber component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;InputNumber
     * <b>Attributes</b>
     * id=""
     * width="100"
     * height="30"
     * value=""
     * decimalSeparator="."
     * thousandSeparator=","
     * required="false"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:inputNumber
     * <b>Attributes</b>
     * id=""
     * style="width:100px;height:30px;"
     * value=""
     * decimalSeparator="."
     * thousandSeparator=","
     * required="false"/&gt;
     * </pre>
     */
    public class InputNumber extends TextInput implements IPrimeFacesSurfaceComponent, IIdAttribute,
            IHistorySurfaceCustomHandlerComponent, IComponentSizeOutput
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "inputNumber";
        public static const ELEMENT_NAME:String = "InputNumber";
		public static const EVENT_CHILDREN_UPDATED:String = "eventChildrenUpdated";

        public static const DEFAULT_DECIMAL_SEPARATOR:String = ".";
        private static const DEFAULT_THOUSANDS_SEPARATOR:String = ",";

        private var _formatter:InputNumberFormatter;
		private var _multiFieldOldValues:Array;

        public function InputNumber()
        {
            super();

            _formatter = new InputNumberFormatter();
            _formatter.useThousandsSeparator = true;
            _formatter.rounding = NumberBaseRoundType.NONE;
            _formatter.precision = -1;

            this.mouseChildren = false;

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
                "formattedTextChanged",
                "idAttributeChanged",
				"requiredChanged"
            ];

            this.prompt = "0.00";
            this.typicalText = "0.00";
            this.text = "0.00";
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

        public function get propertyEditorClass():Class
        {
            return InputNumberPropertyEditor;
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

		public function restorePropertyOnChangeReference(nameField:String, value:*):void
		{
			switch(nameField)
			{
				case "text":
					super.text = value;
					break;
				default:
					this[nameField.toString()] = value;
					break;
			}
			dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
		}

        private var _idAttribute:String;
        /**
         * <p>PrimeFaces: <strong>id (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputNumber id=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputNumber id=""/&gt;</listing>
         */
        public function get idAttribute():String
        {
            return _idAttribute;
        }

        [Bindable("idAttributeChanged")]
        public function set idAttribute(value:String):void
        {
            if (_idAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "idAttribute", _idAttribute, value);

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
         * <listing version="3.0">&lt;InputNumber percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputNumber style="width:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputMask width="100"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputMask style="width:100px;height:30px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputNumber percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputNumber style="height:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputMask height="30"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputMask style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        private var _decimalSeparator:String = DEFAULT_DECIMAL_SEPARATOR;
        private var decimalSeparatorChanged:Boolean;

		[Bindable("decimalSeparatorChanged")]
        /**
         * <p>PrimeFaces: <strong>decimalSeparator</strong></p>
         *
         * @default "."
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputNumber decimalSeparator="."/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputNumber decimalSeparator="."/&gt;</listing>
         */
        public function get decimalSeparator():String
        {
            return _decimalSeparator;
        }

        public function set decimalSeparator(value:String):void
        {
            if (_decimalSeparator != value)
            {
                value = StringUtil.trim(value);
                
                if (!value)
                {
                    value = DEFAULT_DECIMAL_SEPARATOR;
                }

				_multiFieldOldValues = [{field:"text", value:super.text}, {field:"decimalSeparator", value:_decimalSeparator}];
				
                _decimalSeparator = value;
                decimalSeparatorChanged = true;
                invalidateProperties();
				dispatchEvent(new Event("decimalSeparatorChanged"));
            }
        }

        private var _thousandSeparator:String = DEFAULT_THOUSANDS_SEPARATOR;
        private var thousandsSeparatorChanged:Boolean;

		[Bindable("thousandSeparatorChanged")]
        /**
         * <p>PrimeFaces: <strong>thousandSeparator</strong></p>
         *
         * @default ","
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputNumber thousandSeparator=","/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputNumber thousandSeparator=","/&gt;</listing>
         */
        public function get thousandSeparator():String
        {
            return _thousandSeparator;
        }

        public function set thousandSeparator(value:String):void
        {
            if (_thousandSeparator != value)
            {
                value = StringUtil.trim(value);

				_multiFieldOldValues = [{field:"text", value:super.text}, {field:"thousandSeparator", value:_thousandSeparator}];
					
                _thousandSeparator = value;
                thousandsSeparatorChanged = true;
                invalidateProperties();
				dispatchEvent(new Event("thousandSeparatorChanged"));
            }
        }

        [CollapseWhiteSpace]
        [Bindable("change")]
        [Bindable("formattedTextChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @default "0.00"
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputNumber value=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputNumber value=""/&gt;</listing>
         */
        override public function set text(value:String):void
        {
            if (super.text != value)
            {
				_multiFieldOldValues = [{field:"text", value:super.text}];
				refreshText(value);
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
         * <listing version="3.0">&lt;InputNumber required="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputNumber required="false"/&gt;</listing>
         */
        public function get required():Boolean
        {
            return _required;
        }

        public function set required(value:Boolean):void
        {
            if (_required != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "required", _required, value);

                _required = value;
                requiredChanged = true;

                dispatchEvent(new Event("requiredChanged"));
            }
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (decimalSeparatorChanged)
            {
                var newDecimalSeparatorText:String = this.getTextWithNewDecimalseparator();

                _formatter.decimalSeparatorFrom = decimalSeparator;
                _formatter.decimalSeparatorTo = decimalSeparator;

                this.refreshText(newDecimalSeparatorText ? newDecimalSeparatorText : this.text);

                decimalSeparatorChanged = false;
            }

            if (thousandsSeparatorChanged)
            {
                var newThousandsSeparatorText:String = this.getTextWithoutThousandsSeparator();

                _formatter.thousandsSeparatorFrom = thousandSeparator;
                _formatter.thousandsSeparatorTo = thousandSeparator;
                _formatter.useThousandsSeparator = thousandSeparator ? true : false;

                this.refreshText(newThousandsSeparatorText ? newThousandsSeparatorText : this.text);

                thousandsSeparatorChanged = false;
            }

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
            xml.@thousandSeparator = this.thousandSeparator;
            xml.@decimalSeparator = this.decimalSeparator;

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.thousandSeparator = xml.@thousandSeparator;
            this.decimalSeparator = xml.@decimalSeparator;
            this.idAttribute = xml.@id;
            this.required = xml.@required == "true";

            var newTextValue:String = xml.@value;
            if (this.thousandSeparator)
            {
                var thousandsSeparatorReg:RegExp = new RegExp('\\' + this.thousandSeparator, "g");
                newTextValue = newTextValue.replace(thousandsSeparatorReg, "");
            }

            this.refreshText(newTextValue);
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this);

            if (this.text)
            {
                xml.@value = this.text;
            }
            xml.@thousandSeparator = this.thousandSeparator;
            xml.@decimalSeparator = this.decimalSeparator;
            xml.@required = this.required;

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

            return xml;
        }
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, "InputNumber", null));
		}

        private function refreshText(value:String):void
        {
            if (value == "0" || value == "0.00" || !value)
            {
                super.text = this.decimalSeparator ? "0.00".replace(".", this.decimalSeparator) : "0.00";
            }
            else
            {
                super.text = _formatter.format(value);
            }
			
            _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, null, _multiFieldOldValues, [{field:"text", value:super.text}, {field:"decimalSeparator", value:_decimalSeparator}, {field:"thousandSeparator", value:_thousandSeparator}]);
            dispatchEvent(new Event("formattedTextChanged"));
        }

        private function getTextWithoutThousandsSeparator():String
        {
            var newTextValue:String;
            if (thousandsSeparatorChanged && _formatter.thousandsSeparatorFrom != _formatter.decimalSeparatorFrom)
            {
                var thousandsSeparatorReg:RegExp = new RegExp('\\' + _formatter.thousandsSeparatorFrom, "g");
                newTextValue = this.text.replace(thousandsSeparatorReg, "");
            }

            return newTextValue;
        }

        private function getTextWithNewDecimalseparator():String
        {
            var newTextValue:String;
            if (decimalSeparatorChanged && _formatter.decimalSeparatorFrom != this.decimalSeparator
                    && _formatter.thousandsSeparatorFrom != _formatter.decimalSeparatorFrom)
            {
                var decimalSeparatorReg:RegExp = new RegExp('\\' + _formatter.decimalSeparatorFrom, "g");
                    newTextValue = this.text.replace(decimalSeparatorReg, this.decimalSeparator);

            }

            return newTextValue;
        }
    }
}
