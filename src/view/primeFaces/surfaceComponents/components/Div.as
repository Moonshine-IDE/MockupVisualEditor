package view.primeFaces.surfaceComponents.components
{
    import interfaces.IComponentSizeOutput;

    import mx.core.IVisualElement;
    
    import data.OrganizerItem;

    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;
    import view.interfaces.IDiv;
    import view.interfaces.IDropAcceptableComponent;
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.DivPropertyEditor;
    import view.primeFaces.supportClasses.Container;
    import view.primeFaces.supportClasses.ContainerDirection;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IDiv;
    import components.primeFaces.Div;
    import mx.controls.Alert;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="div", kind="property")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]
    [Exclude(name="internalToXML", kind="method")]
    [Exclude(name="mainXML", kind="property")]
    [Exclude(name="widthOutput", kind="property")]
    [Exclude(name="heightOutput", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="dropElementAt", kind="method")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]
    [Exclude(name="_cdataXML", kind="property")]
    [Exclude(name="_cdataInformation", kind="property")]
    [Exclude(name="contentChanged", kind="property")]

    /**
     * <p>Representation of div in HTML</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;Div
     * <b>Attributes</b>
     * width="120"
     * height="120"
     * percentWidth="80"
     * percentHeight="80"
     * class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"&gt;
     *  &lt;Script&gt;
     *      &lt;![CDATA[ Some information ]]&gt;
 *      &lt;/Script&gt;
     * &lt;/Div&gt;
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
    public class Div extends Container implements IPrimeFacesSurfaceComponent, view.interfaces.IDiv,
            IHistorySurfaceComponent, IComponentSizeOutput, IDropAcceptableComponent, ICDATAInformation
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "div";
        public static var ELEMENT_NAME:String = "Div";

		private var component:interfaces.components.IDiv;
		
        protected var mainXML:XML;

        protected var contentChanged:Boolean;

        public  var isDomino:Boolean =false;

        public function Div()
        {
            super();
			
			component = new components.primeFaces.Div(this);
			
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
                "horizontalAlignChanged", 
                "windowsTitleChanged"
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


        // private var _title:String = "";

        
        // public function get title():String
        // {
        //     return _title;
        // }

        // public function set title(value:String):void
        // {
        //     if (_title != value)
        //     {
        //         _title = value;
        //         dispatchEvent(new Event("titleChanged"));
        //     }
        // }

        protected var _cdataXML:XML;

        public function get cdataXML():XML
        {
            return _cdataXML;
        }

        protected var _cdataInformation:String;

        public function get cdataInformation():String
        {
            return _cdataInformation;
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

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:80%;"/&gt;</listing>
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
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:120px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;Div percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="height:80%;"/&gt;</listing>
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
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div height="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="height:120px;"/&gt;</listing>
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

		public function getComponentsChildren(...params):OrganizerItem
		{
			var componentsArray:Array = [];
			var organizerItem:OrganizerItem;
			var element:IPrimeFacesSurfaceComponent;
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
		
		public function dropElementAt(element:IVisualElement, index:int):void
		{
			this.addElementAt(element, index);
		}

        public function toXML():XML
        {
            mainXML = new XML("<" + ELEMENT_NAME + "/>");

            return this.internalToXML();
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            component.fromXML(xml, callback);

			_cssClass = component.cssClass;
			wrap = component.wrap;
			
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
            XMLCodeUtils.applyChildrenPositionFromXML(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);
        }

        public function toCode():XML
        {
			component.isSelected = this.isSelected;
			(component as components.primeFaces.Div).width = this.width;
			(component as components.primeFaces.Div).height = this.width;
			(component as components.primeFaces.Div).percentWidth = this.percentWidth;
			(component as components.primeFaces.Div).percentHeight = this.percentHeight;
			(component as components.primeFaces.Div).isDomino=isDomino;
            (component as components.primeFaces.Div).direction=direction;
            var xml:XML = component.toCode();

            xml["@class"] = component.cssClass = XMLCodeUtils.getChildrenPositionForXML(this);
           
            // if(this.title){
            //     xml["@title"]=this.title;
            // }
            return xml;
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

        protected function internalToXML():XML
        {
            XMLCodeUtils.setSizeFromComponentToXML(this, mainXML);

            mainXML["@class"] = _cssClass = XMLCodeUtils.getChildrenPositionForXML(this);
            mainXML.@wrap = this.wrap;
            mainXML.@direction=direction;

            if (cdataXML)
            {
                mainXML.appendChild(cdataXML);
            }

            //setting the postion for horizontal and Vertical
			//Alert.show("_cssClass:"+_cssClass);
			if(_cssClass){
				if(_cssClass.indexOf("flexCenter")>=0){
					mainXML.@hpostion="center"
				}
				if(_cssClass.indexOf("flexHorizontalLayoutLeft")>=0){
					mainXML.@hpostion="left"
				}
				if(_cssClass.indexOf("flexHorizontalLayoutRight")>=0){
					mainXML.@hpostion="right"
				}


				if(_cssClass.indexOf("flexVerticalLayoutRight")>=0){
					mainXML.@vpostion="right"
				}
				if(_cssClass.indexOf("flexMiddle")>=0){
					mainXML.@vpostion="center"
				}

				if(_cssClass.indexOf("flexVerticalLayoutLeft")>=0){
					mainXML.@vpostion="left"
				}
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

        protected function resetPercentWidthHeightBasedOnLayout():void
        {
            if (isNaN(this.percentHeight) && isNaN(this.percentWidth)) return;

            var childrensHeight:Number = 0;
            var childrensWidth:Number = 0;
            var numEl:int = this.numElements;

            for (var i:int = 0; i < numEl; i++)
            {
                var element:IVisualElement = this.getElementAt(i);
                if (direction == ContainerDirection.VERTICAL_LAYOUT)
                {
                    if (!isNaN(element.height))
                    {
                        childrensHeight += element.height;
                    }

                    if (childrensWidth < element.width)
                    {
                        if (!isNaN(element.width))
                        {
                            childrensWidth = element.width;
                        }
                    }
                }
                else if (direction == ContainerDirection.HORIZONTAL_LAYOUT)
                {
                    if (!isNaN(element.width))
                    {
                        childrensWidth += element.width;
                    }

                    if (childrensHeight < element.height)
                    {
                        if (!isNaN(element.height))
                        {
                            childrensHeight = element.height;
                        }
                    }
                }
            }

            if (childrensHeight > this.height && !isNaN(this.percentHeight))
            {
                this.percentHeight = Number.NaN;
            }

            if (childrensWidth > this.width && !isNaN(this.percentWidth))
            {
                this.percentWidth = Number.NaN;
            }
        }
    }
}
