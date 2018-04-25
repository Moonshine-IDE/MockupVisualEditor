package view.primeFaces.surfaceComponents.components
{
    import components.CollapsiblePanel;

    import flash.display.DisplayObject;

    import flash.events.Event;

    import flash.events.MouseEvent;

    import mx.core.IVisualElement;

    import mx.core.mx_internal;

    import mx.events.FlexEvent;

    import spark.components.HGroup;

    import utils.XMLCodeUtils;

    import view.interfaces.IDiv;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.FieldsetPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.FieldsetSkin;
    import view.suportClasses.events.SurfaceComponentEvent;

    /**
     * The icon designating a "closed" state
     */
    [Style(name="closedIcon", type="Object")]

    /**
     * The icon designating an "open" state
     */
    [Style(name="openIcon", type="Object")]

    public class Fieldset extends CollapsiblePanel implements IPrimeFacesSurfaceComponent, IDiv
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

            _div = new Div();
            this.addEventListener(Event.REMOVED_FROM_STAGE, onFieldsetRemoved);
        }

        [SkinPart(required="true")]
        public var titleGroup:HGroup;

        private var _div:Div;
        public function get div():Div
        {
            return _div;
        }

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

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IPrimeFacesSurfaceComponent = this.getElementAt(i) as IPrimeFacesSurfaceComponent;
                if(element === null)
                {
                    continue;
                }
                xml.appendChild(element.toXML());
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.title = xml.@legend;
            this.toggleable = xml.@toggleable == "true" ? true : false;

            var toggleDuration:Number = Number(xml.@toggleSpeed);
            this.duration = isNaN(toggleDuration) ? 200 : toggleDuration;

            var elementsXML:XMLList = xml.elements();
            var childCount:int = elementsXML.length();
            for(var i:int = 0; i < childCount; i++)
            {
                var childXML:XML = elementsXML[i];
                callback(this, childXML);
            }
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            //In my opinion this is ans issue in PrimeFaces. If I add height to Fieldset and it's toggleable it doesn't work.
            var fieldsetHeight:Number = this.height;
            if (this.toggleable)
            {
                fieldsetHeight = Number.NaN;
            }

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, fieldsetHeight, this.percentWidth, this.percentHeight);

            xml.@legend = this.title;
            xml.@toggleable = this.toggleable;
            xml.@toggleSpeed = this.duration;

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

        override protected function childrenCreated():void
        {
            super.childrenCreated();

            this.ensureInternalDivIsAdded();
        }

        private function onFieldsetRemoved(event:Event):void
        {
            this.removeEventListener(Event.REMOVED_FROM_STAGE, onFieldsetRemoved);

            dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentAdded, [this.div]));
        }

        private function ensureInternalDivIsAdded():void
        {
            _div.percentWidth = _div.percentHeight = 100;
            _div.setStyle("borderVisible", false);

            super.addElement(_div);

            dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentAdded, [_div]));
        }

        override public function addElement(element:IVisualElement):IVisualElement
        {
            if (this.div)
            {
                return this.div.addElement(element);
            }
            else
            {
                return super.addElement(element);
            }
        }

        override public function removeElement(element:IVisualElement):IVisualElement
        {
            if (this.div)
            {
                return this.div.removeElement(element);
            }
            else
            {
                return super.removeElement(element);
            }
        }
    }
}
