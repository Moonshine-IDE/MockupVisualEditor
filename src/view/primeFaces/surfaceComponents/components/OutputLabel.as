package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import spark.components.Label;
    import spark.layouts.VerticalAlign;

    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.OutputLabelPropertyEditor;

    public class OutputLabel extends Label implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "outputLabel";
        public static const ELEMENT_NAME:String = "OutputLabel";

        public function OutputLabel()
        {
            super();

            this.text = "Label";

            this.setStyle("verticalAlign", VerticalAlign.MIDDLE);

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
                "forAttributeChanged"
            ];
        }

        private var _indicateRequired:Boolean;
        private var indicateRequiredChanged:Boolean;

        public function get indicateRequired():Boolean
        {
            return _indicateRequired;
        }

        public function set indicateRequired(value:Boolean):void
        {
            if (_indicateRequired != value)
            {
                _indicateRequired = value;
                indicateRequiredChanged = true;
                invalidateProperties();
            }
        }

        public function get propertyEditorClass():Class
        {
            return OutputLabelPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;

        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        private var _forAttribute:String;

        public function get forAttribute():String
        {
            return _forAttribute;
        }

        public function set forAttribute(value:String):void
        {
            if (_forAttribute != value)
            {
                _forAttribute = value;
                dispatchEvent(new Event("forAttributeChanged"));
            }
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@value = this.text;

            if (!this.forAttribute)
            {
                delete xml["@for"];
            }
            else
            {
                xml["@for"] = this.forAttribute;
            }

            return xml;
        }

        public function fromXML(xml:XML, childFromXMLCallback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.text = xml.@value;
            this.forAttribute = xml["@for"];
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            xml.@value = this.text;
            if (!this.forAttribute)
            {
                delete xml["@for"];
            }
            else
            {
                xml["@for"] = this.forAttribute;
            }

            return xml;
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (indicateRequiredChanged)
            {
                if (indicateRequired)
                {
                    this.text += " *";
                }
                else if (this.text)
                {
                    this.text = this.text.replace(" *", "");
                }
                indicateRequiredChanged = false;
            }
        }
    }
}
