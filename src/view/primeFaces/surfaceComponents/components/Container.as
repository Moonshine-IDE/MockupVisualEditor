package view.primeFaces.surfaceComponents.components
{
    import components.FlowLayout;

    import flash.events.Event;

    import spark.components.BorderContainer;
    import spark.layouts.HorizontalLayout;
    import spark.layouts.VerticalLayout;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.WindowPropertyEditor;
    import view.primeFaces.supportClasses.ContainerDirection;

    public class Container extends BorderContainer implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "div";
        public static var ELEMENT_NAME:String = "Div";

        public function Container()
        {
            super();

            this.setHoriztonalLayout();

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

        private var _direction:String;
        private var directionChanged:Boolean;

        [Inspectable(enumeration="flexHorizontalLayout,flexVerticalLayout", defaultValue="flexHorizontalLayout")]
        public function get direction():String
        {
            return _direction;
        }

        public function set direction(value:String):void
        {
            if (_direction != value)
            {
                _direction = value;
                this.directionChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("directionChanged"));
            }
        }

        private var _wrap:Boolean;
        private var wrapChanged:Boolean;

        public function get wrap():Boolean
        {
            return _wrap;
        }

        public function set wrap(value:Boolean):void
        {
            if (_wrap != value)
            {
                _wrap = value;
                this.wrapChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("wrapChanged"));
            }
        }

        private var _gap:int;
        private var gapChanged:Boolean;

        [Inspectable(defaultValue="0")]
        public function get gap():int
        {
            return _gap;
        }

        public function set gap(value:int):void
        {
            if (_gap != value)
            {
                _gap = value;
                this.gapChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("gapChanged"));
            }
        }

        private var alignChanged:Boolean;

        private var _verticalAlign:String = "top";

        [Inspectable(enumeration="top,bottom,middle", defaultValue="top")]
        public function get verticalAlign():String
        {
            return _verticalAlign;
        }

        public function set verticalAlign(value:String):void
        {
            if (_verticalAlign != value)
            {
                _verticalAlign = value;
                this.alignChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("verticalAlignChanged"));
            }
        }

        private var _horizontalAlign:String = "left"; // center, right

        [Inspectable(enumeration="left,right,center", defaultValue="left")]
        public function get horizontalAlign():String
        {
            return _horizontalAlign;
        }

        public function set horizontalAlign(value:String):void
        {
            if (_horizontalAlign != value)
            {
                _horizontalAlign = value;
                this.alignChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("horizontalAlignChanged"));
            }
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (this.directionChanged && !this.wrap)
            {
                if (direction == ContainerDirection.HORIZONTAL_LAYOUT)
                {
                    this.setHoriztonalLayout();
                }
                else if (direction == ContainerDirection.VERTICAL_LAYOUT)
                {
                    this.setVerticalLayout();
                }
                this.directionChanged = false;
            }

            if (this.wrapChanged)
            {
                this.setFlowLayout();

                this.directionChanged = false;
                this.wrapChanged = false;
            }

            if (this.gapChanged)
            {
                this.setGapLayout();

                this.gapChanged = false;
            }

            if (this.alignChanged)
            {
                this.setLayoutAlign();

                this.alignChanged = false;
            }
        }

        public function get propertyEditorClass():Class
        {
            return WindowPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            setCommonXMLAttributes(xml);

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

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");

            setCommonXMLAttributes(xml);

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
            if ('@percentWidth' in xml)
            {
                this.percentWidth = xml.@percentWidth;
            }
            else
            {
                this.width = xml.@width;
            }

            if ('@percentHeight' in xml)
            {
                this.percentHeight = xml.@percentHeight;
            }
            else
            {
                this.height = xml.@height;
            }

            var elementsXML:XMLList = xml.elements();
            var childCount:int = elementsXML.length();
            for(var i:int = 0; i < childCount; i++)
            {
                var childXML:XML = elementsXML[i];
                callback(this, childXML);
            }
        }

        protected function setCommonXMLAttributes(xml:XML):void
        {
            if (!isNaN(this.percentWidth))
            {
                xml.@percentWidth = this.percentWidth;
            }
            else
            {
                xml.@width = this.width;
            }

            if (!isNaN(this.percentHeight))
            {
                xml.@percentHeight = this.percentHeight;
            }
            else
            {
                xml.@height = this.height;
            }
        }

        private function setHoriztonalLayout():void
        {
            var hLayout:HorizontalLayout = new HorizontalLayout();
            hLayout.gap = this.gap;

            this.layout = hLayout;

            this.setLayoutAlign();
        }

        private function setVerticalLayout():void
        {
            var hLayout:VerticalLayout = new VerticalLayout();
            hLayout.gap = this.gap;

            this.layout = hLayout;

            this.setLayoutAlign();
        }

        private function setFlowLayout():void
        {
            var flowLayout:FlowLayout = new FlowLayout();
            flowLayout.horizontalGap = this.gap;

            this.layout = flowLayout;

            this.setLayoutAlign();
        }

        private function setGapLayout():void
        {
            if (this.wrap)
            {
                (this.layout as FlowLayout).horizontalGap = this.gap;
            }
            else if (direction == ContainerDirection.HORIZONTAL_LAYOUT)
            {
                (this.layout as HorizontalLayout).gap = this.gap;
            }
            else if (direction == ContainerDirection.VERTICAL_LAYOUT)
            {
                (this.layout as VerticalLayout).gap = this.gap;
            }
        }

        private function setLayoutAlign():void
        {
            if (this.wrap)
            {
                (this.layout as FlowLayout).horizontalAlign = this.horizontalAlign;
                (this.layout as FlowLayout).verticalAlign = this.verticalAlign;
            }
            else if (direction == ContainerDirection.HORIZONTAL_LAYOUT)
            {
                (this.layout as HorizontalLayout).horizontalAlign = this.horizontalAlign;
                (this.layout as HorizontalLayout).verticalAlign = this.verticalAlign;
            }
            else if (direction == ContainerDirection.VERTICAL_LAYOUT)
            {
                (this.layout as VerticalLayout).horizontalAlign = this.horizontalAlign;
                (this.layout as VerticalLayout).verticalAlign = this.verticalAlign;
            }
        }
    }
}
