package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.utils.StringUtil;
    
    import spark.components.TextArea;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IIdAttribute;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.InputTextareaPropertyEditor;
    import view.suportClasses.PropertyChangeReference;

    public class InputTextarea extends TextArea implements IPrimeFacesSurfaceComponent, IIdAttribute, IHistorySurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "inputTextarea";
        public static const ELEMENT_NAME:String = "InputTextarea";

        public function InputTextarea()
        {
            super();

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
		
		private var _isUpdating:Boolean;
		public function get isUpdating():Boolean
		{
			return _isUpdating;
		}
		
		public function set isUpdating(value:Boolean):void
		{
			_isUpdating = value;
		}
		
		public function restorePropertyOnChangeReference(nameField:String, value:*, eventType:String=null):void
		{
			this[nameField.toString()] = value;
		}

        private var _isAutoResize:Boolean;
		[Bindable(event="isAutoResizeChanged")]
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
		
		private var _counter:String;
		[Bindable(event="counterChanged")]
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

        private var _idAttribute:String;
		[Bindable(event="idAttributeChanged")]
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
		
		[Bindable("textChanged")]
		override public function set text(value:String):void
		{
			if (super.text != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "text", super.text, value);
				
				super.text = value;
				dispatchEvent(new Event("textChanged"));
			}
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

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@value = this.text;
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

            this.text = xml.@value;
            this.isAutoResize = (xml.@isAutoResize == "true") ? true : false;
			this.maxLength = xml.@maxlength;
			if (String(xml.@isCounterDisplay) == "true")
			{
				this.isCounterDisplay = true;
				this.counterTemplate = String(xml.@counterTemplate);
				if (xml.@counter != undefined) this.counter = String(xml.@counter);
			}

            this.idAttribute = xml.@id;
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            xml.@value = this.text;
            if (isAutoResize) xml.@autoResize = this.isAutoResize.toString();
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
    }
}
