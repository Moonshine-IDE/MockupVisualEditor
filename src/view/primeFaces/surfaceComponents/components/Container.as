package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import spark.components.BorderContainer;
    import spark.layouts.HorizontalLayout;
    import spark.layouts.VerticalLayout;
    
    import components.FlowLayout;
    
    import view.primeFaces.supportClasses.ContainerDirection;

    public class Container extends BorderContainer
    {
        public function Container()
        {
            super();

            this.setHoriztonalLayout();
        }
		
		protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
		{
			throw new Error("needs to be override in an ISurfaceComponent class.");
		}
		
        private var _direction:String = "Horizontal";
        private var directionChanged:Boolean;
		
		[Bindable("directionChanged")]
        [Inspectable(enumeration="Horizontal,Vertical", defaultValue="Horizontal")]
        public function get direction():String
        {
            return _direction;
        }
		
        public function set direction(value:String):void
        {
            if (_direction != value)
            {
				updatePropertyChangeReference("direction", _direction, value);
				
                _direction = value;
                this.directionChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("directionChanged"));
            }
        }

        private var _wrap:Boolean;
        private var wrapChanged:Boolean;
		
		[Bindable("wrapChanged")]
        public function get wrap():Boolean
        {
            return _wrap;
        }
        public function set wrap(value:Boolean):void
        {
            if (_wrap != value)
            {
				updatePropertyChangeReference("wrap", _wrap, value);
				
                _wrap = value;
                this.directionChanged = true;
                this.wrapChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("wrapChanged"));
            }
        }

        private var _gap:int;
        private var gapChanged:Boolean;
		
		[Bindable("gapChanged")]
        [Inspectable(defaultValue="0")]
        public function get gap():int
        {
            return _gap;
        }

        public function set gap(value:int):void
        {
            if (_gap != value)
            {
				updatePropertyChangeReference("gap", _gap, value);
				
                _gap = value;
                this.gapChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("gapChanged"));
            }
        }

        private var alignChanged:Boolean;

        private var _verticalAlign:String = "top";
		
		[Bindable("verticalAlignChanged")]
        [Inspectable(enumeration="top,bottom,middle", defaultValue="top")]
        public function get verticalAlign():String
        {
            return _verticalAlign;
        }

        public function set verticalAlign(value:String):void
        {
            if (_verticalAlign != value)
            {
				updatePropertyChangeReference("verticalAlign", _verticalAlign, value);
				
                _verticalAlign = value;
                this.alignChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("verticalAlignChanged"));
            }
        }

        private var _horizontalAlign:String = "left"; // center, right
		
		[Bindable("horizontalAlignChanged")]
        [Inspectable(enumeration="left,right,center", defaultValue="left")]
        public function get horizontalAlign():String
        {
            return _horizontalAlign;
        }

        public function set horizontalAlign(value:String):void
        {
            if (_horizontalAlign != value)
            {
				updatePropertyChangeReference("horizontalAlign", _horizontalAlign, value);
				
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
            if (!this.wrap) return;

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
