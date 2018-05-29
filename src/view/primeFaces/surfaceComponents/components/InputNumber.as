package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.formatters.NumberFormatter;
    
    import spark.components.TextInput;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IIdAttribute;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.InputNumberPropertyEditor;
    import view.suportClasses.PropertyChangeReference;

    [Exclude(name="commitProperties", kind="method")]

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]

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
     * thousandSeparator=","/&gt;
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
     * thousandSeparator=","/&gt;
     * </pre>
     */
    public class InputNumber extends TextInput implements IPrimeFacesSurfaceComponent, IIdAttribute, IHistorySurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "inputNumber";
        public static const ELEMENT_NAME:String = "InputNumber";

        private var _formatter:NumberFormatter;

        public function InputNumber()
        {
            super();

            _formatter = new NumberFormatter();
            _formatter.useThousandsSeparator = true;

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
                "textChanged",
                "idAttributeChanged",
				"thousandSeparatorChanged",
				"decimalSeparatorChanged"
            ];

            this.prompt = "0.00";
            this.typicalText = "0.00";
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
                _propertyChangeFieldReference = new PropertyChangeReference(this, "idAttribute", _idAttribute, value);

                _idAttribute = value;
                dispatchEvent(new Event("idAttributeChanged"))
            }
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

        private var _decimalSeparator:String = ".";
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
				_propertyChangeFieldReference = new PropertyChangeReference(this, "decimalSeparator", _decimalSeparator, value);
				
                _decimalSeparator = value;
                decimalSeparatorChanged = true;
                invalidateProperties();
				dispatchEvent(new Event("decimalSeparatorChanged"));
            }
        }

        private var _thousandSeparator:String = ",";
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
				_propertyChangeFieldReference = new PropertyChangeReference(this, "thousandSeparator", _thousandSeparator, value);
				
                _thousandSeparator = value;
                thousandsSeparatorChanged = true;
                invalidateProperties();
				dispatchEvent(new Event("thousandSeparatorChanged"));
            }
        }

        [CollapseWhiteSpace]
        [Bindable("change")]
        [Bindable("textChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
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
				var oldValue:String = super.text;
                super.text = _formatter.format(value);
				
				_propertyChangeFieldReference = new PropertyChangeReference(this, "text", oldValue, super.text);
				dispatchEvent(new Event("textChanged"));
            }
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (decimalSeparatorChanged)
            {
                _formatter.decimalSeparatorFrom = decimalSeparator;
                _formatter.decimalSeparatorTo = decimalSeparator;

                decimalSeparatorChanged = false;
            }

            if (thousandsSeparatorChanged)
            {
                _formatter.thousandsSeparatorFrom = thousandSeparator;
                _formatter.thousandsSeparatorTo = thousandSeparator;

                thousandsSeparatorChanged = false;
            }
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@value = this.text;
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

            this.text = xml.@value;
            this.thousandSeparator = xml.@thousandSeparator;
            this.decimalSeparator = xml.@decimalSeparator;
            this.idAttribute = xml.@id;
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            xml.@value = this.text;
            xml.@thousandSeparator = this.thousandSeparator;
            xml.@decimalSeparator = this.decimalSeparator;

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

            return xml;
        }
    }
}
