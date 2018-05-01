package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import spark.components.Label;
    import spark.layouts.VerticalAlign;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.models.PropertyChangeReferenceVO;
    import view.primeFaces.propertyEditors.OutputLabelPropertyEditor;

    public class OutputLabel extends Label implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "outputLabel";
        public static const ELEMENT_NAME:String = "OutputLabel";

        public function OutputLabel()
        {
            super();

            this.text = "Label";

            this.setStyle("verticalAlign", VerticalAlign.MIDDLE);

            this.toolTip = "";
            this.width = 100;
            this.height = 30;
            this.minWidth = 20;
            this.minHeight = 20;

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

        private var _indicateRequired:Boolean;
        private var indicateRequiredChanged:Boolean;
		
		[Bindable("indicateRequiredChanged")]
        public function get indicateRequired():Boolean
        {
            return _indicateRequired;
        }
		
        public function set indicateRequired(value:Boolean):void
        {
            if (_indicateRequired != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReferenceVO(this, "indicateRequired", _indicateRequired, value);
				
                _indicateRequired = value;
                indicateRequiredChanged = true;
                invalidateProperties();
				dispatchEvent(new Event("indicateRequiredChanged"));
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

        private var _forAttribute:String;

        public function get forAttribute():String
        {
            return _forAttribute;
        }
		
		private var _propertyChangeFieldReference:PropertyChangeReferenceVO;
		public function get propertyChangeFieldReference():PropertyChangeReferenceVO
		{
			return _propertyChangeFieldReference;
		}
		
		public function set propertyChangeFieldReference(value:PropertyChangeReferenceVO):void
		{
			_propertyChangeFieldReference = value;
		}
		
		[Bindable("forAttributeChanged")]
        public function set forAttribute(value:String):void
        {
            if (_forAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReferenceVO(this, "forAttribute", _forAttribute, value);
				
                _forAttribute = value;
                dispatchEvent(new Event("forAttributeChanged"));
				
            }
        }
		
		[Bindable("textChanged")]
		override public function set text(value:String):void
		{
			if (super.text != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReferenceVO(this, "text", super.text, value);
				
				super.text = value;
				dispatchEvent(new Event("textChanged"));
			}
		}
		
		public var isUpdating:Boolean;
		
		public function restorePropertyOnChangeReference(nameField:String, value:*):void
		{
			this[nameField.toString()] = value;
		}

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@value = this.text;

            if (this.forAttribute)
            {
                xml["@for"] = this.forAttribute;
            }

            return xml;
        }

        public function fromXML(xml:XML, childFromXMLCallback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.text = xml.@value;
            this.forAttribute = xml["@for"];
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            xml.@value = this.text;
            if (this.forAttribute)
            {
                xml["@for"] = this.forAttribute;
            }

            return xml;
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (indicateRequiredChanged)
            {
				isUpdating = true; // do not update 'text' change to history manager as the 'text' change here is the effect of another field change
                if (indicateRequired)
                {
                    this.text += " *";
                }
                else if (this.text)
                {
                    this.text = this.text.replace(" *", "");
                }
                indicateRequiredChanged = false;
				isUpdating = false;
            }
        }
    }
}
