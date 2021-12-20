package view.primeFaces.surfaceComponents.components
{
    import components.primeFaces.InputTextarea;

    import data.OrganizerItem;

    import flash.events.Event;

    import interfaces.components.IInputTextarea;

    import mx.utils.StringUtil;

    import spark.components.TextArea;

    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IIdAttribute;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.InputTextareaPropertyEditor;
    import view.suportClasses.PropertyChangeReference;

	[Exclude(name="isCounterDisplay", kind="property")]

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
     * <p>Representation of PrimeFaces inputTextarea component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;InputTextarea
     *      <b>Attributes</b>
     *      id=""
     *      width="100"
     *      height="60"
	 * isAutoResize="true"
     *      value=""
     *      maxlength=""
	 * counter=""
	 * counterTemplate="{0} characters remaining."
     * required="false"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:inputTextarea
     *      <b>Attributes</b>
     *      id=""
     *      style="width:100px;height:60px;"
	 * autoResize="true"
     *      value=""
     *      maxlength=""
	 * counter=""
     *      counterTemplate="{0} characters remaining."
     * required="false"/&gt;
     * </pre>
     */
    public class InputTextarea extends TextArea implements IPrimeFacesSurfaceComponent, IIdAttribute, IHistorySurfaceComponent, ICDATAInformation
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "inputTextarea";
        public static const ELEMENT_NAME:String = "InputTextarea";

		private var component:IInputTextarea;
		
        public function InputTextarea()
        {
            super();
			
			component = new components.primeFaces.InputTextarea();
			
            this.mouseChildren = false;
            this.toolTip = "";
            this.width = 100;
			this.height = 60;
            this.minWidth = 20;
			this.minHeight = 40;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "textChanged",
				"isAutoResizeChanged",
				"isCounterDisplayChanged",
				"counterChanged",
				"counterTemplateChanged",
				"maxLengthChanged",
				"idAttributeChanged"
            ];
			
			this.prompt = "Input Text Area";
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

        public function get propertyEditorClass():Class
        {
            return InputTextareaPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
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

        private var _isAutoResize:Boolean = true;

        private var _idAttribute:String;
        [Bindable(event="idAttributeChanged")]
        /**
         * <p>PrimeFaces: <strong>id (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputTextarea id=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea id=""/&gt;</listing>
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
         * <listing version="3.0">&lt;InputTextarea percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea style="width:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputTextarea width="100"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea style="width:100px;height:60px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputTextarea percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea style="height:80%;"/&gt;</listing>
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
         * @default "60"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputTextarea height="60"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea style="width:100px;height:60px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        [Bindable(event="isAutoResizeChanged")]
        /**
         * <p>PrimeFaces: <strong>autoResize</strong></p>
         *
         * @default "true"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;inputTextarea isAutoResize="true"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea autoResize="true"/&gt;</listing>
         */
        public function get isAutoResize():Boolean
        {
            return _isAutoResize;
        }
        public function set isAutoResize(value:Boolean):void
        {
			if (_isAutoResize != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "isAutoResize", _isAutoResize, value);
				
				_isAutoResize = value;
				dispatchEvent(new Event("isAutoResizeChanged"));
			}
        }

        private var _counter:String;
		[Bindable(event="counterChanged")]
        /**
         * <p>PrimeFaces: <strong>counter (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputTextarea counter=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea counter=""/&gt;</listing>
         */
		public function get counter():String
		{
			return _counter;
		}

		public function set counter(value:String):void
		{
			if (_counter != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "counter", _counter, value);
				
				_counter = value;
				dispatchEvent(new Event("counterChanged"));
			}
		}
		
		private var _counterTemplate:String = "{0} characters remaining.";
		[Bindable(event="counterTemplateChanged")]
        /**
         * <p>PrimeFaces: <strong>counterTemplate (Optional)</strong></p>
         *
		 * @default "{0} characters remaining."
		 *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputTextarea counterTemplate="{0} characters remaining."/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea counterTemplate="{0} characters remaining."/&gt;</listing>
         */
		public function get counterTemplate():String
		{
			return _counterTemplate;
		}

		public function set counterTemplate(value:String):void
		{
			if (_counterTemplate != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "counterTemplate", _counterTemplate, value);
				
				_counterTemplate = value;
				dispatchEvent(new Event("counterTemplateChanged"));
			}
		}
		
		private var _maxLength:String = "";

		[Bindable(event="maxLengthChanged")]
        /**
         * <p>PrimeFaces: <strong>maxlength (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputTextarea maxlength=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea maxlength=""/&gt;</listing>
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

        private var _required:Boolean;
        private var requiredChanged:Boolean;

        [Bindable(event="requiredChanged")]
        /**
         * <p>PrimeFaces: <strong>required</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputTextarea required="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea required="false"/&gt;</listing>
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

		[Bindable("textChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputTextarea value=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputTextarea value=""/&gt;</listing>
         */
		override public function set text(value:String):void
		{
			if (super.text != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "text", super.text, value);
				
				super.text = value;
				dispatchEvent(new Event("textChanged"));
			}
		}

        private var _isCounterDisplay:Boolean;
        [Bindable(event="isCounterDisplayChanged")]
        public function get isCounterDisplay():Boolean
        {
            return _isCounterDisplay;
        }

        public function set isCounterDisplay(value:Boolean):void
        {
            if (_isCounterDisplay != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "isCounterDisplay", _isCounterDisplay, value);

                _isCounterDisplay = value;
                dispatchEvent(new Event("isCounterDisplayChanged"));
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
            xml.@isAutoResize = this.isAutoResize;
			xml.@isCounterDisplay = this.isCounterDisplay;
			if ((StringUtil.trim(maxLength).length != 0) && Math.round(Number(maxLength)) != 0)
			{
				xml.@maxlength = this.maxLength;
			}
			if (isCounterDisplay)
			{
				xml.@counterTemplate = this.counterTemplate;
				if (StringUtil.trim(counter).length != 0) xml.@counter = this.counter;
			}

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

			component.fromXML(xml, callback);
			
            this.text = component.text;
            this.isAutoResize = component.isAutoResize;
			this.maxLength = component.maxLength;
            this.required = component.required;
			this.isCounterDisplay = component.isCounterDisplay;
			this.counterTemplate = component.counterTemplate;
			this.counter = component.counter;
			this.idAttribute = component.idAttribute;
        }

        public function toCode():XML
        {
			component.text = this.text;
			component.isAutoResize = this.isAutoResize;
			component.required = this.required;
			component.maxLength = this.maxLength;
			component.isCounterDisplay = this.isCounterDisplay;
			component.counterTemplate = this.counterTemplate;
			component.idAttribute = this.idAttribute;
			component.counter = this.counter;
			
			component.isSelected = this.isSelected;
			(component as components.primeFaces.InputTextarea).width = this.width;
			(component as components.primeFaces.InputTextarea).height = this.width;
			(component as components.primeFaces.InputTextarea).percentWidth = this.percentWidth;
			(component as components.primeFaces.InputTextarea).percentHeight = this.percentHeight;
			
            return component.toCode();
        }

        public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
        public function toRora():XML
        {
            return null;
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
