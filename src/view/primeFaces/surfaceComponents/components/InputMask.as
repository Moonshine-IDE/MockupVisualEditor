package view.primeFaces.surfaceComponents.components
{
    import components.MaskedTextInput;

    import flash.events.Event;

    import utils.XMLCodeUtils;

    import view.interfaces.IIdAttribute;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.InputMaskPropertyEditor;

    public class InputMask extends MaskedTextInput implements IPrimeFacesSurfaceComponent, IIdAttribute
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "inputMask";
        public static const ELEMENT_NAME:String = "InputMask";

        public function InputMask()
        {
            super();

            this.maskText = "(999) 999-9999";
            this.mouseChildren = false;
            this.showMaskWhileWrite = false;

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
        }

        private var _idAttribute:String;
        public function get idAttribute():String
        {
            return _idAttribute;
        }

        public function set idAttribute(value:String)
        {
            if (_idAttribute != value)
            {
                _idAttribute = value;
                dispatchEvent(new Event("idAttributeChanged"))
            }
        }

        public function get propertyEditorClass():Class
        {
            return InputMaskPropertyEditor;
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

            xml.@mask = this.maskText;
            xml.@value = this.text;

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.maskText = xml.@mask;
            this.text = xml.@value;
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
            xml.@mask = this.maskText;

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

            return xml;
        }
    }
}
