package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import spark.components.Label;
    import spark.layouts.VerticalAlign;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.OutputLabelPropertyEditor;
    import view.suportClasses.PropertyChangeReference;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="commitProperties", kind="method")]

    /**
     * <p>Representation of PrimeFaces outputLabel component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;OutputLabel
     * <b>Attributes</b>
     * width="100"
     * height="30"
     * value="Label"
     * for=""
     * indicateRequired="false"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;h:outputLabel
     * <b>Attributes</b>
     * style="width:100px;height:30px;"
     * value="Label"
     * for=""/&gt;
     * </pre>
     */
    public class OutputLabel extends Label implements IPrimeFacesSurfaceComponent, IHistorySurfaceComponent
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
		
		[Exclude(name="isSelected", kind="property")]
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
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

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@value = this.text;
            xml.@indicateRequired = this.indicateRequired;

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
            this.indicateRequired = xml.@indicateRequired == "true";
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this);

            xml.@value = this.text;
            if (this.forAttribute)
            {
                xml["@for"] = this.forAttribute;
            }

            return xml;
        }
		
		public function getComponentsChildren():OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, "OutputLabel", null));
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
