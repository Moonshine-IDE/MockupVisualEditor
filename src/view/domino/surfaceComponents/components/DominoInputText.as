package view.domino.surfaceComponents.components
{
    import flash.events.Event;

    import interfaces.IComponentSizeOutput;

    import mx.utils.StringUtil;
    
    import spark.components.TextInput;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IIdAttribute;
    import view.interfaces.INameAttribute;
    import view.interfaces.IDominoSurfaceComponent;
    import view.domino.propertyEditors.InputTextPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IInputText;
    import interfaces.dominoComponents.IDominoInputText;
    import components.domino.DominoInputText;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces inputText component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;InputText
     * <b>Attributes</b>
     * id=""
     * width="100"
     * height="30"
     * value=""
     * maxlength=""
     * required="false"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:inputText
     * <b>Attributes</b>
     * id=""
     * style="width:100px;height:30px;"
     * value=""
     * maxlength=""
     * required="false"/&gt;
     * </pre>
     */
    public class DominoInputText extends TextInput implements IDominoSurfaceComponent,IIdAttribute,
            IHistorySurfaceComponent, IComponentSizeOutput
    {
        public static const DOMINO_ELEMENT_NAME:String = "field";
       
        public static const ELEMENT_NAME:String = "Field";
		
		private var component:IDominoInputText;
		
        public function DominoInputText()
        {
            super();
			
			component = new components.domino.DominoInputText();
			
            this.mouseChildren = false;
            this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
			this.maxHeight = 30;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "textChanged",
				"maxLengthChanged",
                "idAttributeChanged", 
                "nameAttributeChanged", 
                "kindAttributeChanged", 
                "typeAttributeChanged", 
                "allowmultivaluesAttributeChanged", 
            ];
			
			this.prompt = "Input Text";
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

        private var _idAttribute:String;
		[Bindable(event="idAttributeChanged")]
        /**
         * <p>PrimeFaces: <strong>id (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText id=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText id=""/&gt;</listing>
         */
        public function get idAttribute():String
        {
            return _idAttribute;
        }
		
        public function set idAttribute(value:String):void
        {
            if (_idAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "idAttribute", _idAttribute, value);
				
                _idAttribute = value;
                dispatchEvent(new Event("idAttributeChanged"))
            }
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="width:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputText width="100"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="width:100px;height:30px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputText percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="height:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputText height="30"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

		private var _maxLength:String = "";
		[Bindable(event="maxLengthChanged")]
        /**
         * <p>PrimeFaces: <strong>maxlength (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText maxlength=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText maxlength=""/&gt;</listing>
         */
        public function get maxLength():String
		{
			return _maxLength;
		}

		public function set maxLength(value:String):void
		{
			if (_maxLength != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "maxLength", _maxLength, value);
				
				_maxLength = value;
				dispatchEvent(new Event("maxLengthChanged"));
			}
		}


        [Inspectable(category="General", defaultValue="")]
        [Bindable("textChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText value=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText value=""/&gt;</listing>
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
        /**
         * Domino property list start***********************
         */

        //-----name-------------------------
        private var _nameAttribute:String;
		[Bindable(event="nameAttributeChanged")]
        public function get nameAttribute():String
        {
            return _nameAttribute;
        }
		
        public function set nameAttribute(value:String):void
        {
            if (_nameAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "nameAttribute", _nameAttribute, value);
				
                _nameAttribute = value;
                dispatchEvent(new Event("nameAttributeChanged"))
            }
        }
        //-----allowmultiple-------------------------
        private var _allowmultivalues:Boolean;
        private var allowmultipleChanged:Boolean;

        [Bindable(event="allowmultipleChanged")]
        public function get allowmultivalues():Boolean
        {
            return _allowmultivalues;
        }

        public function set allowmultivalues(value:Boolean):void
        {
            if (_allowmultivalues != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "allowmultipleChanged", _allowmultivalues, value);

                _allowmultivalues = value;
                allowmultipleChanged = true;

                dispatchEvent(new Event("allowmultipleChanged"));
            }
        }

         //-----type-------------------------
         private var _type:String;
		[Bindable(event="typeAttributeChanged")]
        public function get type():String
        {
            return _type;
        }
		
        public function set type(value:String):void
        {
            if (_type != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "type", _type, value);
				
                _type = value;
                dispatchEvent(new Event("typeAttributeChanged"))
            }
        }

          //-----kind-------------------------
          private var _kind:String;
		[Bindable(event="kindAttributeChanged")]
        public function get kind():String
        {
            return _kind;
        }
		
        public function set kind(value:String):void
        {
            if (_kind != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "kind", _kind, value);
				
                _kind = value;
                dispatchEvent(new Event("kindAttributeChanged"))
            }
        }
          //-----width-------------------------
          //-----heigh-------------------------
         /**
         * Domino property list end***********************
         */

        private var _required:Boolean;
        private var requiredChanged:Boolean;

        [Bindable(event="requiredChanged")]
        /**
         * <p>PrimeFaces: <strong>required</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText required="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText required="false"/&gt;</listing>
         */
        public function get required():Boolean
        {
            return _required;
        }

        public function set required(value:Boolean):void
        {
            if (_required != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "required", _required, value);

                _required = value;
                requiredChanged = true;

                dispatchEvent(new Event("requiredChanged"));
            }
        }

        public function get propertyEditorClass():Class
        {
            return InputTextPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

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

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            xml.@value = this.text;
            xml.@required = this.required;

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

			if ((StringUtil.trim(maxLength).length != 0) && Math.round(Number(maxLength)) != 0)
			{
				xml.@maxlength = this.maxLength;
			}

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

			component.fromXML(xml, callback);
			
            this.text = component.text;
			this.maxLength = component.maxLength;
            this.idAttribute = component.idAttribute;
            this.required = component.required;
        }

        public function toCode():XML
        {
            component.text = this.text;
            component.required = this.required;
			component.maxLength = this.maxLength;
			component.idAttribute = this.idAttribute;
				
			component.isSelected = this.isSelected;
			(component as components.domino.DominoInputText).width = this.width;
			(component as components.domino.DominoInputText).height = this.width;
			(component as components.domino.DominoInputText).percentWidth = this.percentWidth;
			(component as components.domino.DominoInputText).percentHeight = this.percentHeight;
			
            return component.toCode();
        }
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, null));
		}
    }
}
