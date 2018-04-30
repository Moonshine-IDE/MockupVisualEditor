package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import mx.formatters.NumberFormatter;

    import spark.components.TextInput;

    import utils.XMLCodeUtils;

    import view.interfaces.IIdAttribute;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.InputNumberPropertyEditor;

    public class InputNumber extends TextInput implements IPrimeFacesSurfaceComponent, IIdAttribute
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
                "idAttributeChanged"
            ];

            this.prompt = "0.00";
            this.typicalText = "0.00";
        }


        private var _decimalSeparator:String = "";
        private var decimalSeparatorChanged:Boolean;

        private var _thousandSeparator:String = "";
        private var thousandsSeparatorChanged:Boolean;

        public function get decimalSeparator():String
        {
            return _decimalSeparator;
        }

        public function set decimalSeparator(value:String):void
        {
            if (_decimalSeparator != value)
            {
                _decimalSeparator = value;
                decimalSeparatorChanged = true;
                invalidateProperties();
            }
        }

        public function get thousandSeparator():String
        {
            return _thousandSeparator;
        }

        public function set thousandSeparator(value:String):void
        {
            if (_thousandSeparator != value)
            {
                _thousandSeparator = value;
                thousandsSeparatorChanged = true;
                invalidateProperties();
            }
        }

        [CollapseWhiteSpace]
        [Bindable("textChanged")]
        [Bindable("change")]
        override public function set text(value:String):void
        {
            if (super.text != value)
            {
                super.text = _formatter.format(value);
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

        private var _idAttribute:String;
        public function get idAttribute():String
        {
            return _idAttribute;
        }

        public function set idAttribute(value:String):void
        {
            if (_idAttribute != value)
            {
                _idAttribute = value;
                dispatchEvent(new Event("idAttributeChanged"))
            }
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
