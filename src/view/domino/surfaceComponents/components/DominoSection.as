package view.domino.surfaceComponents.components
{
        import flash.events.Event;
        import flash.events.MouseEvent;
        import interfaces.IComponentSizeOutput;
        import mx.effects.AnimateProperty;
        import mx.events.EffectEvent;
        import mx.events.FlexEvent;
        import mx.core.IVisualElement;
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
        import mx.collections.ArrayList;
        import view.interfaces.IDropAcceptableComponent;


        [Exclude(name="propertiesChangedEvents", kind="property")]
        [Exclude(name="propertyChangeFieldReference", kind="property")]
        [Exclude(name="propertyEditorClass", kind="property")]
        [Exclude(name="isUpdating", kind="property")]
        [Exclude(name="toXML", kind="method")]
        [Exclude(name="fromXML", kind="method")]
        [Exclude(name="toCode", kind="method")]
        [Exclude(name="mainXML", kind="property")]
        [Exclude(name="commitProperties", kind="method")]
        [Exclude(name="isSelected", kind="property")]
        [Exclude(name="getComponentsChildren", kind="method")]
        [Exclude(name="cdataXML", kind="property")]
        [Exclude(name="cdataInformation", kind="property")]
        [Exclude(name="updatePropertyChangeReference", kind="method")]

        public class DominoSection extends Panel implements IDominoSurfaceComponent, IHistorySurfaceComponent, ICDATAInformation, IComponentSizeOutput,IDropAcceptableComponent
        {
            private var _open:Boolean = true;
            private var openChanged:Boolean;

            private var _openAnim:AnimateProperty;
            private var _duration:Number = 200;
            private var durationChanged:Boolean;
            protected var mainXML:XML;

            protected var isCollapsible:Boolean = true;
            
            public static const DOMINO_ELEMENT_NAME:String = "section";
       
            public static const ELEMENT_NAME:String = "Section";
            private var component:IDominoSection;
            
            
            
            
            public function DominoSection(isOpen:Boolean = true):void
            {
                super();
                component = new components.domino.DominoSection(this);
                super.width = 300;
                open = isOpen;
                _propertiesChangedEvents = [
                    "titleChanged",
                    "sizeChanged",
                    "colorAttributeChanged",
                    "fontStyleAttributeChanged",
                    "onreadAttributeChanged",
                    "oneditAttributeChanged",
                    "onpreviewAttributeChanged",
                    "onprintAttributeChanged",
                    "accessfieldkindAttributeChanged",
                    "accessfieldnameAttributeChanged"

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

            //we should cache the height of the panel 
            private var cachedHeight:Number = 0;

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


            override public function set height(value:Number):void
            {
                if(super.height!=value)
                {
                    _propertyChangeFieldReference = new PropertyChangeReference(this, "height", super.height, value);
				
				    super.height = value;
                    if(_open){
                        cachedHeight=super.height;
                    }

                    dispatchEvent(new Event("heightChanged"))
                }

                
                
            }

            /**
             * the height that the component should be when open
             */
            protected function get openHeight():Number
            {
                if(cachedHeight>0){
                    return  cachedHeight;
                }else{
                    return  super.height;
                }
                
               
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
                       // Alert.show("this.openHeight 305:"+this.openHeight);
                        _openAnim.toValue = this.openHeight;
                        _open = true;
                        dispatchEvent(new Event(Event.OPEN));
                    }
                    else
                    {
                         //cache the height before it closed
                         cachedHeight=super.height;
                    

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
                        this.height = this.openHeight;
                        //Alert.show("this.height:"+this.height);
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


        //*******************************title *************** */    
 [Bindable]
        private var _colors:ArrayList = new ArrayList([
        {label: "aqua",description: "aqua color.",htmlcolor:"#00FFFF"},
        {label: "black",description:"",htmlcolor:"#000000"},
        {label: "blue",description:"",htmlcolor:"#0000FF"}, 
        {label: "fuchsia",description:"",htmlcolor:"#FF00FF"},
        {label: "gray",description:"",htmlcolor:"#808080"},
        {label: "green",description:"",htmlcolor:"#008000"},
        {label: "lime",description:"",htmlcolor:"#00FF00"},
        {label: "maroon",description:"",htmlcolor:"#800000"},
        {label: "navy",description:"",htmlcolor:"#000080"},
        {label: "olive",description:"",htmlcolor:"#808000"},
        {label: "purple",description:"",htmlcolor:"#800080"},
        {label: "red",description:"",htmlcolor:"#FF0000"},
        {label: "silver",description:"",htmlcolor:"#C0C0C0"},
        {label: "teal",description:"",htmlcolor:"#008080"},
        {label: "white",description:"",htmlcolor:"#ffffff"},
        {label: "yellow",description:"",htmlcolor:"#FFFF00"},
        {label: "none",description:"",htmlcolor:"#000000"},
        {label: "system",description:"A preset color. For instance, the font color of a hotspot link is 'system' because it is determined by the %link.color.attrs; property settings for a form.",
        htmlcolor:"#4B0082"}
        ]);

        public function get colors():ArrayList
        {
            return _colors;
        }


        private var _color:String = "system";
		[Bindable(event="colorAttributeChanged")]
        public function get color():String
        {
            return _color;
        }
		
        public function set color(value:String):void
        {
            if (_color != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "color", _color, value);
				
                _color = value;
                var html_color:String =null;
                for(var i:int=0; i<_colors.length; i++)
                {
                 
                  if(_colors.getItemAt(i).label==value){
                      html_color=_colors.getItemAt(i).htmlcolor
                  }
                }

                if(html_color!=null){
                     super.setStyle("color",html_color);
                }
               
                dispatchEvent(new Event("colorAttributeChanged"))
            }
        }

        //------------font style--------------------------------------------

        //<!ENTITY % font.styles "normal | bold | italic | underline | strikethrough | superscript | subscript | shadow | emboss | extrude">
        [Bindable]
        private var _fontStyles:ArrayList = new ArrayList([
              {label: "normal",description: "normal",value:"normal",enabled:true},
              {label: "bold",description: "bold",value:"bold",enabled:true},
              {label: "italic",description: "italic",value:"italic",enabled:true},
              {label: "underline",description: "underline",value:"underline",enabled:true},
              {label: "strikethrough",description: "strikethrough",value:"strikethrough",enabled:true},
              {label: "superscript",description: "superscript",value:"superscript",enabled:true},
              {label: "shadow",description: "shadow",value:"shadow",enabled:true},
              {label: "emboss",description: "emboss",value:"emboss",enabled:true},
              {label: "extrude",description: "extrude",value:"extrude",enabled:true},
              {label: "subscript",description: "subscript",value:"subscript",enabled:true},
              
        ])


         public function get fontStyles():ArrayList
        {
            return _fontStyles;
        }



        private var _fontStyle:String = "normal";
		[Bindable(event="fontStyleAttributeChanged")]
        public function get fontStyle():String
        {
            return _fontStyle;
        }
		
        public function set fontStyle(value:String):void
        {
            if (_fontStyle != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "fontStyle", _fontStyle, value);
				
                _fontStyle = value;
                
               
                dispatchEvent(new Event("colorAttributeChanged"))
            }
        }

        //------------color setting end------------------------------------------------
        //<!ENTITY % field.kinds "editable | computed | computedfordisplay | computedwhencomposed ">
        //<!ENTITY % section.colexp.tokens "expand | collapse | editorexpand | editorcollapse">
        
        [Bindable]
        private var _sectionTokens:ArrayList = new ArrayList([
              {label: "expand",description: "expand",value:"expand",enabled:true},
              {label: "collapse",description: "collapse",value:"collapse",enabled:true},
              {label: "editorexpand",description: "editorexpand",value:"editorexpand",enabled:true},
              {label: "editorcollapse",description: "editorcollapse",value:"editorcollapse",enabled:true}
              
        ])


        private var _fieldKinds:ArrayList = new ArrayList([
              {label: "editable",description: "editable",value:"editable",enabled:true},
              {label: "computed",description: "computed",value:"computed",enabled:true},
              {label: "computedfordisplay",description: "computedfordisplay",value:"computedfordisplay",enabled:true},
              {label: "computedwhencomposed",description: "computedwhencomposed",value:"computedwhencomposed",enabled:true}
              
        ])

         public function get sectionTokens():ArrayList
        {
            return _sectionTokens;
        }

         public function get fieldKinds():ArrayList
        {
            return _fieldKinds;
        }



    
        
        private var _onread:String;
        [Bindable(event="onreadAttributeChanged")]
		public function set onread(value:String):void
		{
			 if (_onread != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "onread", _onread, value);
				
                _onread = value;
                
               
                dispatchEvent(new Event("onreadAttributeChanged"))
            }
		}
		public function get onread():String
		{
			return _onread ;
		}

		private var _onedit:String;
		[Bindable(event="oneditAttributeChanged")]
		public function set onedit(value:String):void
		{
			 if (_onedit != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "onedit", _onedit, value);
				
                _onedit = value;
                
               
                dispatchEvent(new Event("oneditAttributeChanged"))
            }
		}
		public function get onedit():String
		{
			return _onedit ;
		}
		

		private var _onpreview:String;
		[Bindable(event="onpreviewAttributeChanged")]
		public function set onpreview(value:String):void
		{
			 if (_onpreview != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "onpreview", _onpreview, value);
				
                _onpreview = value;
                
               
                dispatchEvent(new Event("onpreviewAttributeChanged"))
            }
		}
		public function get onpreview():String
		{
			return _onpreview ;
		}


		private var _onprint:String;
		[Bindable(event="onprintAttributeChanged")]
		public function set onprint(value:String):void
		{
			 if (_onprint != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "onprint", _onprint, value);
				
                _onprint = value;
                
               
                dispatchEvent(new Event("onprintAttributeChanged"))
            }
		}
		public function get onprint():String
		{
			return _onprint ;
		}


		private var _expanded:Boolean=true;
		public function set expanded(t:Boolean):void
		{
            if (_expanded != t)
            {
             	_expanded = t;

            }
		}
        [Bindable]
		public function get expanded():Boolean
		{
			return _expanded ;
		}


		private var _showastext:Boolean;
		public function set showastext(t:Boolean):void
		{
             if (_showastext != t)
            {
             	_showastext = t;

            }
		}
        [Bindable]
		public function get showastext():Boolean
		{
			return _showastext ;
		}


		private var _accessfieldkind:String;
		[Bindable(event="accessfieldkindAttributeChanged")]
		public function set accessfieldkind(value:String):void
		{
			 if (_accessfieldkind != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "accessfieldkind", _accessfieldkind, value);
				
                _accessfieldkind = value;
                
               
                dispatchEvent(new Event("accessfieldkindAttributeChanged"))
            }
		}
		public function get accessfieldkind():String
		{
			return _accessfieldkind ;
		}


		private var _accessfieldname:String;
		[Bindable(event="accessfieldnameAttributeChanged")]
		public function set accessfieldname(value:String):void
		{
			 if (_accessfieldname != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "accessfieldname", _accessfieldname, value);
				
                _accessfieldname = value;
                
               
                dispatchEvent(new Event("accessfieldnameAttributeChanged"))
            }
		}
		public function get accessfieldname():String
		{
			return _accessfieldname ;
		}
        
        [Bindable("sizeChanged")]
        /**
         * <p>Domino: <strong>size</strong></p>
         *
         * @default "12"
         *
           */

         private var _size:String = "12";
         public function get size():String
        {
            return  this._size ;
        }

		 public function set size(value:String):void
		{
			if (this._size != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "size", this._size, value);
				
				this._size = value;
               
                super.setStyle("fontSize",value);
				dispatchEvent(new Event("sizeChanged"));
			}
		}





        public function dropElementAt(element:IVisualElement, index:int):void
		{
			this.addElementAt(element, index);
		}

             public function toXML():XML
            {
                mainXML = new XML("<" + ELEMENT_NAME +">"+"</"+ELEMENT_NAME+ ">");
                if(super.title){
                    mainXML.@title=super.title
                }

                if(this.color){
                    mainXML.@titleColor=this.color;
                }
                if(this.fontStyle){
                    mainXML.@titleFontStyle=this.fontStyle
                }

                if(this.size){
                    mainXML.@titleSize=this.size
                }

                return this.internalToXML();
            }

        public function fromXML(xml:XML, callback:Function):void
        {
            //Alert.show("xml:"+xml);
            if(xml.@title)
            super.title = xml.@title;

            if(xml.@titleColor)
            this.color = xml.@titleColor;
            if(xml.@titleSize)
            this.size = xml.@titleSize;

            if(xml.@titleFontStyle)
            this.fontStyle = xml.@titleFontStyle;

           
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
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
			component.title = super.title;

            component.titleSize = this.size;
            component.titleColor = this.color;
            component.titleFontStyle = this.fontStyle;
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



            protected function internalToXML():XML
            {
                XMLCodeUtils.setSizeFromComponentToXML(this, mainXML);

             //   mainXML["@class"] = _cssClass = XMLCodeUtils.getChildrenPositionForXML(this);
             //   mainXML.@wrap = this.wrap;

                if (cdataXML)
                {
                    mainXML.appendChild(cdataXML);
                }

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