package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.utils.StringUtil;
    
    import spark.components.TextInput;
    
    import utils.XMLCodeUtils;

    import view.interfaces.IIdAttribute;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.InputTextPropertyEditor;

    public class InputText extends TextInput implements IPrimeFacesSurfaceComponent, IIdAttribute
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "inputText";
        public static const ELEMENT_NAME:String = "InputText";

        public function InputText()
        {
            super();

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

		private var _maxLength:String = "";

		[Bindable(event="maxLengthChanged")]
        public function get maxLength():String
		{
			return _maxLength;
		}

		public function set maxLength(value:String):void
		{
			if (_maxLength != value)
			{
				_maxLength = value;
				dispatchEvent(new Event("maxLengthChanged"));
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

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@value = this.text;
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

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.text = xml.@value;
			this.maxLength = xml.@maxlength;
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
			if ((StringUtil.trim(maxLength).length != 0) && Math.round(Number(maxLength)) != 0)
			{
				xml.@maxlength = this.maxLength;
			}

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

            return xml;
        }
    }
}
