package view.primeFaces.surfaceComponents.components
{
    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.DivPropertyEditor;
    import view.primeFaces.propertyEditors.WindowPropertyEditor;

    public class Div extends Container implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "div";
        public static var ELEMENT_NAME:String = "Div";

        protected var mainXML:XML;

        public function Div()
        {
            super();

            this.width = 120;
            this.height = 120;
            this.minWidth = 20;
            this.minHeight = 20;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "titleChanged",
                "directionChanged",
                "wrapChanged",
                "gapChanged",
                "verticalAlignChanged",
                "horizontalAlignChanged"
            ];
        }

        public function get propertyEditorClass():Class
        {
            return DivPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        public function toXML():XML
        {
            mainXML = new XML("<" + ELEMENT_NAME + "/>");

            return this.internalToXML();
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);
            XMLCodeUtils.applyChildrenPositionToXML(this, xml);

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IPrimeFacesSurfaceComponent = this.getElementAt(i) as IPrimeFacesSurfaceComponent;
                if(element === null)
                {
                    continue;
                }

                xml.appendChild(element.toCode());
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            this.wrap = xml.@wrap == "true";

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
            XMLCodeUtils.applyChildrenPositionFromXML(xml, this);

            var elementsXML:XMLList = xml.elements();
            var childCount:int = elementsXML.length();
            for(var i:int = 0; i < childCount; i++)
            {
                var childXML:XML = elementsXML[i];
                callback(this, childXML);
            }
        }

        protected function internalToXML():XML
        {
            XMLCodeUtils.setSizeFromComponentToXML(this, mainXML);
            XMLCodeUtils.applyChildrenPositionToXML(this, mainXML);

            mainXML.@wrap = this.wrap;

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IPrimeFacesSurfaceComponent = this.getElementAt(i) as IPrimeFacesSurfaceComponent;
                if(element === null)
                {
                    continue;
                }
                mainXML.appendChild(element.toXML());
            }
            return mainXML;
        }
    }
}