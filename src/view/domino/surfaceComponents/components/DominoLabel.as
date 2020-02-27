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
    import view.interfaces.IDominoSurfaceComponent
    import view.primeFaces.propertyEditors.OutputLabelPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IOutputLabel;
    import components.primeFaces.OutputLabel;

    import components.domino.DominoPar;
    import components.domino.DominoRun;
    import components.domino.DominoFont;
    import components.domino.DominoLabel;

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
                "forAttributeChanged",
				"indicateRequiredChanged"
            ];
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
            return OutputLabelPropertyEditor;
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
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
            var par_xml:XML = new XML("<par/>");
            var run_xml:XML = new XML("<run/>");
			var font_xml:XML = new XML("<font>"+this.text+"</font>");
            var cxml:XML = new XML()
            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }
            if(this.font!=null){
                if(this.font.color){
                    font_xml.@color=this.font.color
                }

                if(this.font.size){
                    font_xml.@size=this.font.size
                }

                if(this.font.style){
                    font_xml.@style=this.font.style
                }

                if(this.font.name){
                    font_xml.@name=this.font.name
                }

            
                font_xml.@truetype=this.font.truetype
                
                
                if(this.font.pitch){
                    font_xml.@pitch=this.font.pitch
                }
            }

			//CodeXMLUtils.addSizeHtmlStyleToXML(xml, this);
			//font node must before the text node
			run_xml.appendChild(font_xml);
            //run_xml.appendChild(this.text);
            //run_xml.text=this.text;
            //run_xml.createTextNode(this.text);
            
            if(this.par!=null){
                if(this.par.def)
                par_xml.@def=this.par.def;
            }
			
			par_xml.appendChild(run_xml);

            return par_xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

			component.fromXML(xml, callback);
            this.text = component.text;
        }

        public function toCode():XML
        {
			component.text = this.text;
			//component.forAttribute = this.forAttribute;
			//component.indicateRequired = this.indicateRequired;
			
			component.isSelected = this.isSelected;
			// (component as components.domino.DominoLabel).width = this.width;
			// (component as components.domino.DominoLabel).height = this.width;
			// (component as components.domino.DominoLabel).percentWidth = this.percentWidth;
			// (component as components.domino.DominoLabel).percentHeight = this.percentHeight;
			
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