package view.domino.surfaceComponents.components
{   
    import flash.events.Event;

    import interfaces.IComponentSizeOutput;

    import spark.components.Label;
    import spark.layouts.VerticalAlign;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.interfaces.IDominoSurfaceComponent;
    import view.primeFaces.propertyEditors.OutputLabelPropertyEditor;
    import view.domino.propertyEditors.DominoLabelPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IOutputLabel;
    import components.primeFaces.OutputLabel;

    import components.domino.DominoPar;
    import components.domino.DominoRun;
    import components.domino.DominoFont;
    import components.domino.DominoLabel;

    import mx.collections.ArrayList;

    import mx.controls.Alert;
    import utils.StringHelper;

    import interfaces.dominoComponents.IDominoLabel;
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
    public class DominoLabel extends Label implements IDominoSurfaceComponent, IHistorySurfaceComponent, ICDATAInformation, IComponentSizeOutput
    {
        public static const DOMINO_ELEMENT_NAME:String = "label";
       
        public static const ELEMENT_NAME:String = "Label";
		private var component:IDominoLabel;
		
        public function DominoLabel()
        {
            super();
            component = new components.domino.DominoLabel();
			
            this.text = "Label";

            this.setStyle("verticalAlign", VerticalAlign.MIDDLE);

            this.toolTip = "";
            this.width = 100;
            this.height = 30;
            this.minWidth = 20;
            this.minHeight = 20;
            this.maxDisplayedLines = -1;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "textChanged",
                "sizeChanged",
                "forAttributeChanged",
				"indicateRequiredChanged",
                "colorAttributeChanged",
                "fontStyleAttributeChanged",
                "hidewhenAttributeChanged"
            ];
        }


        private var _hidewhen:String;
        [Bindable(event="hidewhenAttributeChanged")]
		public function get hidewhen():String
		{
			return _hidewhen;
		}
		public function set hidewhen(value:String):void
		{
			if (_hidewhen != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "hidewhen", _hidewhen, value);
				
                _hidewhen = value;
                dispatchEvent(new Event("hidewhenAttributeChanged"))
            }
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
            return DominoLabelPropertyEditor;
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

        private var _indicateRequired:Boolean;
        private var indicateRequiredChanged:Boolean;
		
		[Bindable("indicateRequiredChanged")]
        /**
         * <p>PrimeFaces: <strong>none</strong></p>
         *
         * @default "false"
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel indicateRequired="false"/&gt;</listing>
         */
        public function get indicateRequired():Boolean
        {
            return _indicateRequired;
        }
		
        public function set indicateRequired(value:Boolean):void
        {
            if (_indicateRequired != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "indicateRequired", _indicateRequired, value);
				
                _indicateRequired = value;
                indicateRequiredChanged = true;
                invalidateProperties();
				dispatchEvent(new Event("indicateRequiredChanged"));
            }
        }

      
        /****************************************************************
         * font color for lable
         * https://help.hcltechsw.com/dom_designer/10.0.1/basic/H_DEFINED_ENTITIES_XML.html
         * aqua | black | blue | fuchsia | gray | green | lime | 
         * maroon | navy | olive |purple | red | silver | teal |
         * white | yellow | none | system " 
         */
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


        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="width:80%;"/&gt;</listing>
         */
        override public function get percentWidth():Number
        {
            return super.percentWidth;
        }

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "100"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel width="100"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="height:80%;"/&gt;</listing>
         */
        override public function get percentHeight():Number
        {
            return super.percentHeight;
        }

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "30"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel height="30"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        private var _forAttribute:String;

        [Bindable("forAttributeChanged")]
        /**
         * <p>PrimeFaces: <strong>for</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel for=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;h:outputLabel for=""/&gt;</listing>
         */
        public function get forAttribute():String
        {
            return _forAttribute;
        }

        public function set forAttribute(value:String):void
        {
            if (_forAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "forAttribute", _forAttribute, value);
				
                _forAttribute = value;
                dispatchEvent(new Event("forAttributeChanged"));
            }
        }

        [Inspectable(category="General", defaultValue="Label")]
        [Bindable("textChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @default "Label"
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel value="Label"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;h:outputLabel value="Label"/&gt;</listing>
         */
        override public function get text():String
        {
            return super.text;
        }

		override public function set text(value:String):void
		{
			if (super.text != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "text", super.text, value);
				
				super.text = value;
				dispatchEvent(new Event("textChanged"));
			}
		}


        //------------comenent start------------------
		private var _font:DominoFont;
		public function set font(font:DominoFont):void
		{
			_font = font;
		}
		public function get font():DominoFont
		{
			return _font ;
		}

		private var _par:DominoPar;
		public function set par(par:DominoPar):void
		{
			_par = par;
		}
		public function get par():DominoPar
		{
			return _par ;
		}

		private var _run:DominoRun;
		public function set run(run:DominoRun):void
		{
			_run = run;
		}
		public function get run():DominoRun
		{
			return _run ;
		}

		//-------------other componetn end-------------
		
		

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME +">"+escape(this.text)+"</"+ELEMENT_NAME+ ">");
            if(this.size){
                xml.@size = this.size;
            }

            if(this.color){
                xml.@color = this.color;
            }

            if(this.fontStyle){
                xml.@style = this.fontStyle;
            }
            
            if(this.hidewhen){
                var encodeFormulaStr:String= StringHelper.base64Encode(this.hidewhen);
                 xml.@hidewhen = encodeFormulaStr;
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
           
			component.fromXML(xml, callback);
           
            this.text = component.text;
            this.color = component.color;
            this.size = component.size;
            this.fontStyle=component.fontStyle;
            if(component.hidewhen){
                
               this.hidewhen=  StringHelper.base64Decode(component.hidewhen);
            }


        }

        public function toCode():XML
        {
			component.text = this.text;
            component.size = this.size;
            component.color = this.color;
            component.fontStyle = this.fontStyle;
			//component.forAttribute = this.forAttribute;
			//component.indicateRequired = this.indicateRequired;
			
			component.isSelected = this.isSelected;
            component.hidewhen = this.hidewhen;
		
            return component.toCode();
        }
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, null));
		}

         override protected function commitProperties():void
        {
            super.commitProperties();

            // if (indicateRequiredChanged)
            // {
			// 	isUpdating = true; // do not update 'text' change to history manager as the 'text' change here is the effect of another field change
            //     if (indicateRequired && !hasIndicationRequired())
            //     {
            //         this.text += " *";
            //     }
            //     else if (this.text && !indicateRequired)
            //     {
            //         this.text = this.text.replace(" *", "");
            //     }
            //     indicateRequiredChanged = false;
			// 	isUpdating = false;
            // }

            if (this.widthOutputChanged)
            {
                this.percentWidth = Number.NaN;
                this.width = Number.NaN;
                this.widthOutputChanged = false;
            }

            if (this.heightOutputChanged)
            {
                this.percentHeight = Number.NaN;
                this.height = Number.NaN;
                this.heightOutputChanged = false;
            }
        }
    }
}