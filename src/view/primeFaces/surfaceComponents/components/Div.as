package view.primeFaces.surfaceComponents.components
{
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.IComponentSizeOutput;

    import view.interfaces.IDiv;
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.DivPropertyEditor;
    import view.primeFaces.supportClasses.Container;
    import view.suportClasses.PropertyChangeReference;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="div", kind="property")]
    [Exclude(name="ELEMENT_NAME", kind="property")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]
    [Exclude(name="internalToXML", kind="method")]
    [Exclude(name="mainXML", kind="property")]
    [Exclude(name="widthOutput", kind="property")]
    [Exclude(name="heightOutput", kind="property")]

    /**
     * <p>Representation of div in HTML</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;Div
     * <b>Attributes</b>
     * width="120"
     * height="120"
     * class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;div
     * <b>Attributes</b>
     * style="width:120px;height:120px;"
     * class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;
     * </pre>
     */
    public class Div extends Container implements IPrimeFacesSurfaceComponent, IDiv, IHistorySurfaceComponent, IComponentSizeOutput
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "div";
        public static var ELEMENT_NAME:String = "Div";

        protected var mainXML:XML;

        public function Div()
        {
            super();

            this.width = 120;
            this.height = 120;
            this.minWidth = 20;
            this.minHeight = 20;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "titleChanged",
                "directionChanged",
                "wrapChanged",
                "gapChanged",
                "verticalAlignChanged",
                "horizontalAlignChanged"
            ];
        }

        private var _widthOutput:Boolean = true;
        [Bindable]
        public function get widthOutput():Boolean
        {
            return _widthOutput;
        }

        public function set widthOutput(value:Boolean):void
        {
            _widthOutput = value;
        }

        private var _heightOutput:Boolean = true;
        [Bindable]
        public function get heightOutput():Boolean
        {
            return _heightOutput;
        }

        public function set heightOutput(value:Boolean):void
        {
            _heightOutput = value;
        }

        private var _cssClass:String;
        /**
         * <p>HTML: <strong>class</strong></p>
         *
         * <p>This property helps laying out children Horizontally or Vertically. It uses browser FlexBox mechanism to avoid problems which occurs when children in div are positioned using default mechanism. Exported PrimeFaces project contains moonshine-layout-styles.css file which has classes ready to use for laying out children.</p>
         *
         * <p>Use listed css classes to laying out children:</p>
         *
         * <p><strong>Horizontal Layout</strong></p>
         * <ul>
         *  <li>flexHorizontalLayoutWrap</li>
         *  <li>flexHorizontalLayout</li>
         *  <li>flexHorizontalLayoutLeft</li>
         *  <li>flexHorizontalLayoutRight</li>
         *  <li>flexHorizontalLayoutTop</li>
         *  <li>flexHorizontalLayoutBottom</li>
         * </ul>
         *
         * <p><strong>Vertical Layout</strong></p>
         * <ul>
         *  <li>flexVerticalLayoutWrap</li>
         *  <li>flexVerticalLayout</li>
         *  <li>flexVerticalLayoutLeft</li>
         *  <li>flexVerticalLayoutRight</li>
         *  <li>flexVerticalLayoutTop</li>
         *  <li>flexVerticalLayoutBottom</li>
         * </ul>
         *
         * <p><strong>Horizontal/Vertical Layout</strong></p>
         * <ul>
         *  <li>flexMiddle</li>
         *  <li>flexCenter</li>
         * </ul>
         *
         * https://css-tricks.com/snippets/css/a-guide-to-flexbox/
         *
         * @default "flexHorizontalLayoutWrap flexHorizontalLayoutLeft flexHorizontalLayoutTop"
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div class="flexHorizontalLayoutWrap flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;</listing>
         * @example
         * <strong>HTML:</strong>
         * <listing version="3.0">&lt;div class="flexHorizontalLayoutWrap flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;</listing>
         */
        public function get cssClass():String
        {
            return _cssClass;
        }

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Button width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button style="width:120px;height:120px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
        }

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Button height="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button style="width:120px;height:120px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        override public function set height(value:Number):void
        {
            super.height = value;
        }

        public function get div():Div
        {
            return this;
        }

        public function get propertyEditorClass():Class
        {
            return DivPropertyEditor;
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
		
		private var _propertyChangeFieldReference:PropertyChangeReference;
		public function get propertyChangeFieldReference():PropertyChangeReference
		{
			return _propertyChangeFieldReference;
		}
		
		public function set propertyChangeFieldReference(value:PropertyChangeReference):void
		{
			_propertyChangeFieldReference = value;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
        {
            _propertyChangeFieldReference = new PropertyChangeReference(this, fieldName, oldValue, newValue);
        }

        public function restorePropertyOnChangeReference(nameField:String, value:*, eventType:String=null):void
		{
			this[nameField.toString()] = value;
		}

        public function toXML():XML
        {
            mainXML = new XML("<" + ELEMENT_NAME + "/>");

            return this.internalToXML();
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this);
            xml["@class"] = _cssClass = XMLCodeUtils.getChildrenPositionForXML(this);

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IPrimeFacesSurfaceComponent = this.getElementAt(i) as IPrimeFacesSurfaceComponent;
                if(element === null)
                {
                    continue;
                }

                xml.appendChild(element.toCode());
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            this._cssClass = xml.@["class"];
            this.wrap = xml.@wrap == "true";

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
            XMLCodeUtils.applyChildrenPositionFromXML(xml, this);

            var elementsXML:XMLList = xml.elements();
            var childCount:int = elementsXML.length();
            for(var i:int = 0; i < childCount; i++)
            {
                var childXML:XML = elementsXML[i];
                callback(this, childXML);
            }
        }

        protected function internalToXML():XML
        {
            XMLCodeUtils.setSizeFromComponentToXML(this, mainXML);

            mainXML["@class"] = _cssClass = XMLCodeUtils.getChildrenPositionForXML(this);
            mainXML.@wrap = this.wrap;

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
