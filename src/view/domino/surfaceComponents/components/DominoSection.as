package view.domino.surfaceComponents.components
{
        import flash.events.Event;
        import flash.events.MouseEvent;
        import interfaces.IComponentSizeOutput;
        import mx.effects.AnimateProperty;
        import mx.events.EffectEvent;
        import mx.events.FlexEvent;
        import view.primeFaces.propertyEditors.OutputLabelPropertyEditor;
        import view.domino.propertyEditors.DominoSectionPropertyEditor;
        import view.suportClasses.PropertyChangeReference;
        import data.OrganizerItem;
        import view.interfaces.IHistorySurfaceComponent;
        import view.interfaces.IPrimeFacesSurfaceComponent;
        import view.interfaces.IDominoSurfaceComponent;
        import utils.MxmlCodeUtils;
        import utils.XMLCodeUtils;
        import view.interfaces.ICDATAInformation;
        import spark.components.Label;
        import spark.components.Panel;
        import components.domino.DominoSection;
        import interfaces.dominoComponents.IDominoSection; 
        import mx.controls.Alert; 
        public class DominoSection extends Panel implements IDominoSurfaceComponent, IHistorySurfaceComponent, ICDATAInformation, IComponentSizeOutput
        {
            private var _open:Boolean = true;
            private var openChanged:Boolean;

            private var _openAnim:AnimateProperty;
            private var _duration:Number = 200;
            private var durationChanged:Boolean;

            protected var isCollapsible:Boolean = true;
            [Exclude(name="propertiesChangedEvents", kind="property")]
            [Exclude(name="propertyChangeFieldReference", kind="property")]
            [Exclude(name="propertyEditorClass", kind="property")]
            [Exclude(name="isUpdating", kind="property")]
            [Exclude(name="toXML", kind="method")]
            [Exclude(name="fromXML", kind="method")]
            [Exclude(name="toCode", kind="method")]
            [Exclude(name="commitProperties", kind="method")]
            [Exclude(name="isSelected", kind="property")]
            [Exclude(name="getComponentsChildren", kind="method")]
            [Exclude(name="cdataXML", kind="property")]
            [Exclude(name="cdataInformation", kind="property")]
            [Exclude(name="updatePropertyChangeReference", kind="method")]

            public static const DOMINO_ELEMENT_NAME:String = "section";
       
            public static const ELEMENT_NAME:String = "Section";
            private var component:IDominoSection;
            
            
            
            
            public function DominoSection(isOpen:Boolean = true):void
            {
                super();
                component = new components.domino.DominoSection();
                open = isOpen;
                _propertiesChangedEvents = [
                    "titleChanged"
                ];
                this.addEventListener(FlexEvent.CREATION_COMPLETE, onCollapsiblePanelCreationComplete);
            }


        public function getComponentsChildren(...params):OrganizerItem
		{
			var componentsArray:Array = [];
			var organizerItem:OrganizerItem;
			var element:IPrimeFacesSurfaceComponent;
            //Alert.show("getComponentsChildren:"+this.numElements);
			for(var i:int = 0; i < this.numElements; i++)
			{
				element = this.getElementAt(i) as IPrimeFacesSurfaceComponent;
				if (!element)
				{
					continue;
				}
				
				organizerItem = element.getComponentsChildren();
				if (organizerItem) componentsArray.push(organizerItem);
			}

			
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, (componentsArray.length > 0) ? componentsArray : []));
		}
        private var _widthOutput:Boolean = true;
        protected var widthOutputChanged:Boolean;

        [Bindable]
        public function get widthOutput():Boolean
        {
            return _widthOutput;
        }

        public function set widthOutput(value:Boolean):void
        {
            if (_widthOutput != value)
            {
                _widthOutput = value;

                if (!value)
                {
                    widthOutputChanged = true;
                    this.invalidateProperties();
                }
            }
        }

        private var _heightOutput:Boolean = true;
        protected var heightOutputChanged:Boolean;

        [Bindable]
        public function get heightOutput():Boolean
        {
            return _heightOutput;
        }

        public function set heightOutput(value:Boolean):void
        {
            if (_heightOutput != value)
            {
                _heightOutput = value;

                if (!value)
                {
                    heightOutputChanged = true;
                    this.invalidateProperties();
                }
            }
        }

        public function get propertyEditorClass():Class
        {
            return DominoSectionPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;

        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
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

        private var _isUpdating:Boolean;
        public function get isUpdating():Boolean
        {
            return _isUpdating;
        }

        public function set isUpdating(value:Boolean):void
        {
            _isUpdating = value;
        }
		
		private var _isSelected:Boolean;

		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
		}
         private var _cdataXML:XML;

        public function get cdataXML():XML
        {
            return _cdataXML;
        }

        private var _cdataInformation:String;

        public function get cdataInformation():String
        {
            return _cdataInformation;
        }
            
         protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
        {
            _propertyChangeFieldReference = new PropertyChangeReference(this, fieldName, oldValue, newValue);
        }
            
            protected function updateIsUpdating(value:Boolean):void
            {
                isUpdating = value;
                //throw new Error("needs to be override in an ISurfaceComponent class.");
            }

            protected function onTitleDisplayClick(event:MouseEvent):void
            {
                toggleOpen();
            }

            private function onOpenAnimEffectEnd(event:EffectEvent):void
            {
                contentGroup.visible = contentGroup.includeInLayout = this.open;
                updateIsUpdating(false);
            }
            
            public function get isAnimationPlaying():Boolean
            {
                return _openAnim.isPlaying;
            }

            [PercentProxy("percentHeight")]
            [Inspectable(category="General")]
            [Bindable("heightChanged")]
            override public function get height():Number
            {
                if (!open && _openAnim && !_openAnim.isPlaying)
                {
                    return _openAnim.toValue;
                }

                return super.height;
            }

            /**
             * the height that the component should be when open
             */
            protected function get openHeight():Number
            {
                return measuredHeight;
            }

            /**
             * the height that the component should be when closed
             */
            private function get closedHeight():Number
            {
                if (!titleDisplay) return Number.NaN;

                return (titleDisplay as Label).height + 5;
            }

            /**
             * Collapses / expands this block (with animation)
             */
            public function toggleOpen():void
            {
                if (!contentGroup) return;

                if (!_openAnim.isPlaying)
                {
                    updatePropertyChangeReference("open", _open, !_open);
                    
                    _openAnim.fromValue = _openAnim.target.height;
                    if (!_open)
                    {
                        _openAnim.toValue = this.openHeight;
                        _open = true;
                        dispatchEvent(new Event(Event.OPEN));
                    }
                    else
                    {
                        _openAnim.toValue = _openAnim.target.closedHeight;
                        _open = false;
                        dispatchEvent(new Event(Event.CLOSE));
                    }

                    dispatchEvent(new Event("openChanged"));
                    _openAnim.play();
                }
            }

            [Inspectable(defaultValue="200")]
            [Bindable(event="durationChanged")]
            public function get duration():Number
            {
                return _duration;
            }

            public function set duration(value:Number):void
            {
                if (_duration != value)
                {
                    updatePropertyChangeReference("duration", _duration, value);
                    
                    _duration = value;
                    durationChanged = true;
                    invalidateProperties();
                    
                    dispatchEvent(new Event("durationChanged"));
                }
            }

            /**
             * Whether the block is in a expanded (open) state or not
             */
            [Bindable(event="openChanged")]
            public function get open():Boolean
            {
                return _open;
            }

            /**
             * @private
             */
            public function set open(value:Boolean):void
            {
                if (_open != value)
                {
                    updateIsUpdating(true);
                    openChanged = true;
                    invalidateProperties();
                }
            }

            override protected function commitProperties():void
            {
                super.commitProperties();

                if (this.openChanged)
                {
                    toggleOpen();
                    this.openChanged = false;
                }

                if (this.durationChanged)
                {
                    if (_openAnim && !_openAnim.isPlaying)
                    {
                        _openAnim.duration = this.duration;
                    }
                    this.durationChanged = false;
                }
            }
            /**
             * @private
             */
            override public function invalidateSize():void
            {
                super.invalidateSize();
                if (_openAnim && !_openAnim.isPlaying)
                {
                    if (_open && isCollapsible)
                    {
                        this.height = openHeight;
                    }
                }
            }

            protected function onCollapsiblePanelCreationComplete(event:FlexEvent):void
            {
                this.removeEventListener(FlexEvent.CREATION_COMPLETE, onCollapsiblePanelCreationComplete);

                _openAnim = new AnimateProperty(this);
                _openAnim.addEventListener(EffectEvent.EFFECT_END, onOpenAnimEffectEnd, false, 0, true);
                _openAnim.duration = this.duration;
                _openAnim.property = "height";

                titleDisplay.addEventListener(MouseEvent.CLICK, onTitleDisplayClick);
            }


             public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME +">"+"</"+ELEMENT_NAME+ ">");
            if(super.title){
                xml.@title=super.title
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
           
			component.fromXML(xml, callback);
           
            super.title = component.title;
           

        }

        public function toCode():XML
        {
			component.title = super.title;
           
			//component.forAttribute = this.forAttribute;
			//component.indicateRequired = this.indicateRequired;
			
			component.isSelected = this.isSelected;
		
            return component.toCode();
        }

            //---------------------title-------------------------
            
           
            override public function get title():String
            {
                return super.title;
            }
            
            override public function set title(value:String):void
            {
                if (super.title != value)
                {
                    _propertyChangeFieldReference = new PropertyChangeReference(this, "title", super.title, value);
				
				    super.title = value;
                    
                
                    dispatchEvent(new Event("titleChanged"))
                }
            }
    }
}
