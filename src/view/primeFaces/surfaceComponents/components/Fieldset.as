package view.primeFaces.surfaceComponents.components
{
    import components.CollapsiblePanel;

    import flash.events.Event;

    import flash.events.MouseEvent;

    import mx.events.FlexEvent;

    import spark.components.HGroup;

    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.FieldsetPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.FieldsetSkin;

    /**
     * The icon designating a "closed" state
     */
    [Style(name="closedIcon", type="Object")]

    /**
     * The icon designating an "open" state
     */
    [Style(name="openIcon", type="Object")]

    public class Fieldset extends CollapsiblePanel implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "fieldset";
        public static const ELEMENT_NAME:String = "Fieldset";

        [Embed(source='/assets/minus_close.png')]
        public var closeIcon:Class;

        [Embed(source='/assets/plus_open.png')]
        public var openIcon:Class;

        public function Fieldset(isOpen:Boolean = true)
        {
            super(isOpen);

            this.width = 110;
            this.height = 120;
            this.minHeight = 120;
            this.isCollapsible = false;

            this.setStyle("closedIcon", closeIcon);
            this.setStyle("openIcon", openIcon);
            this.setStyle("skinClass", FieldsetSkin);
            this.setStyle("dropShadowVisible", false);
            this.setStyle("borderColor", "#a8a8a8");

            this.title = "Basic";

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "toggleableChanged"
            ];
        }

        [SkinPart(required="true")]
        public var titleGroup:HGroup;

        private var _toggleable:Boolean;
        private var toggleableChanged:Boolean;

        [Bindable(event="toggleableChanged")]
        public function get toggleable():Boolean
        {
            return _toggleable;
        }

        public function set toggleable(value:Boolean):void
        {
            if (_toggleable != value)
            {
                this.isCollapsible = value;
                _toggleable = value;
                toggleableChanged = true;
                dispatchEvent(new Event("toggleableChanged"));

                this.invalidateSkinState();
            }
        }

        public function get propertyEditorClass():Class
        {
            return FieldsetPropertyEditor;
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

            xml.@legend = this.title;
            xml.@toggleable = this.toggleable;
            xml.@toggleSpeed = this.duration;

            return xml;
        }

        public function fromXML(xml:XML, childFromXMLCallback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.title = xml.@legend;
            this.toggleable = xml.@toggleable == "true" ? true : false;

            var toggleDuration:Number = Number(xml.@toggleSpeed);
            this.duration = isNaN(toggleDuration) ? 200 : toggleDuration;
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            xml.@legend = this.title;
            xml.@toggleable = this.toggleable;
            xml.@toggleSpeed = this.duration;

            return xml;
        }

        override protected function onCollapsiblePanelCreationComplete(event:FlexEvent):void
        {
            super.onCollapsiblePanelCreationComplete(event);

            titleDisplay.removeEventListener(MouseEvent.CLICK, onTitleDisplayClick);
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (toggleableChanged)
            {
                if (toggleable)
                {
                    titleGroup.addEventListener(MouseEvent.CLICK, onTitleDisplayClick);
                }
                else
                {
                    titleGroup.removeEventListener(MouseEvent.CLICK, onTitleDisplayClick);
                }
                toggleableChanged = false;

                this.measuredHeight = this.height;
            }
        }
    }
}
