package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.core.IVisualElement;
    import mx.core.IVisualElementContainer;
    import mx.events.CollectionEvent;
    
    import spark.components.NavigatorContent;
    import spark.events.ElementExistenceEvent;
    import spark.events.IndexChangeEvent;
    
    import components.tabNavigator.TabNavigatorWithOrientation;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;
    
    import view.interfaces.IComponentSizeOutput;
    import view.interfaces.IDiv;
    import view.interfaces.IDropAcceptableComponent;
    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.interfaces.ISelectableItemsComponent;
    import view.primeFaces.propertyEditors.TabViewPropertyEditor;
    import view.primeFaces.supportClasses.ContainerDirection;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceTabView;

    [Exclude(name="addElement", kind="method")]
    [Exclude(name="removeItemAt", kind="method")]
    [Exclude(name="EVENT_CHILDREN_UPDATED", kind="property")]

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]

    /**
     * <p>Representation of PrimeFaces tabView component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;TabView
     * <b>Attributes</b>
     * width="120"
     * height="120"
     * orientation="top"
     * scrollable="false"&gt;
     *  &lt;tab title="Tab"&gt;
     *    &lt;Div class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop" wrap="false"/&gt;
     *  &lt;/tab&gt;
     * &lt;/TabView&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:tabView
     * <b>Attributes</b>
     * style="width:120px;height:120px;"
     * orientation="top"
     * scrollable="false"/&gt;
     *  &lt;p:tab title="Tab"&gt;
     *      &lt;div class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop" /&gt;
     *  &lt;/p:tab&gt;
     * &lt;/p:tabView&gt;
     * </pre>
     */
    public class TabView extends TabNavigatorWithOrientation implements IPrimeFacesSurfaceComponent, ISelectableItemsComponent, IHistorySurfaceCustomHandlerComponent, IComponentSizeOutput, IDiv
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "tabView";
        public static const ELEMENT_NAME:String = "TabView";
		public static const EVENT_CHILDREN_UPDATED:String = "eventChildrenUpdated";

        public function TabView()
        {
            super();

            this.selectedIndex = 0;

            this.minWidth = 120;
            this.minHeight = 120;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"orientationChanged",
				"scrollableChanged",
				"itemRemoved",
				"itemAdded",
				"itemUpdated",
                IndexChangeEvent.CHANGE,
                CollectionEvent.COLLECTION_CHANGE
            ];

            var navigatorContent:NavigatorContent = new NavigatorContent();
            navigatorContent.label = "Tab";

            addElement(navigatorContent);
        }

        private var tabViewContentHeightChanged:Boolean;

        private var _div:Div;
        public function get div():Div
        {
            if (selectedItem)
            {
                var navContent:NavigatorContent = (selectedItem as NavigatorContent);
                if (navContent.numElements > 0)
                {
                    _div = (selectedItem as NavigatorContent).getElementAt(0) as Div;
                }
            }
            return _div;
        }

        private var _widthOutput:Boolean = true;
        private var widthOutputChanged:Boolean;

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
                    tabViewContentHeightChanged = true;
                    this.invalidateProperties();
                    this.invalidateDisplayList();
                }
            }
        }

        private var _heightOutput:Boolean = true;
        private var heightOutputChanged:Boolean;

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
                    tabViewContentHeightChanged = true;
                    this.invalidateProperties();
                    this.invalidateDisplayList();
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

        public function get propertyEditorClass():Class
        {
            return TabViewPropertyEditor;
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
		
		[Exclude(name="isSelected", kind="property")]
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
		}

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;TabView percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tabView style="width:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;TabView width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tabView style="width:120px;height:120px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;TabView percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tabView style="height:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;TabView height="20"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tabView style="width:120px;height:120px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        [Inspectable(enumeration="top,left,bottom,right", defaultValue="top")]
        [Bindable("orientationChanged")]
        /**
         * <p>PrimeFaces: <strong>orientation</strong></p>
         *
         * @default "top"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;TabView orientation="top"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tabView orientation="top"/&gt;</listing>
         */
        override public function get orientation():String
        {
            return super.orientation;
        }

        [Bindable("scrollableChanged")]
        /**
         * <p>PrimeFaces: <strong>scrollable</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;TabView scrollable="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tabView scrollable="false"/&gt;</listing>
         */
        override public function get scrollable():Boolean
        {
            return super.scrollable;
        }

        override protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
        {
            if (oldValue && (oldValue is Array)) _propertyChangeFieldReference = new PropertyChangeReferenceTabView(this, fieldName, oldValue, newValue);
            else _propertyChangeFieldReference = new PropertyChangeReference(this, fieldName, oldValue, newValue);
        }

        public function restorePropertyOnChangeReference(nameField:String, value:*):void
		{
			switch(nameField)
			{
				case "removeItemAt":
					try
					{
						this.getItemIndex(value.object);
						removeElementAt(value.index);
					} 
					catch(e:Error)
					{
						addElementAt(value.object, value.index);
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				case "addItemAt":
					try
					{
						this.getItemIndex(value);
						removeElement(value);
					} 
					catch(e:Error)
					{
						addElementAt(value, super.numElements);
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				default:
					this[nameField.toString()] = value;
					break;
			}
		}

        override public function addElement(element:IVisualElement):IVisualElement
        {
			_propertyChangeFieldReference = new PropertyChangeReferenceTabView(this, "addItemAt", element, element);
			var divContent:Div;

            if (element is NavigatorContent)
            {
                divContent = this.getNewDiv();

                element = super.addElement(element);
                (element as NavigatorContent).addElement(divContent);

                return element;
            }
            else
            {
                divContent = this.div;
                if (divContent)
                {
                    return divContent.addElement(element);
                }
                else
                {
                    return (this.selectedItem as NavigatorContent).addElement(element);
                }
            }
			
			dispatchEvent(new Event("itemAdded"));
        }
		
		override public function removeItemAt(index:int):Object
		{
			var historyObject:Object = {object:this.getItemAt(index), index:index};
			_propertyChangeFieldReference = new PropertyChangeReferenceTabView(this, "removeItemAt", historyObject, historyObject);
			var navigatorContent:NavigatorContent = super.removeItemAt(index) as NavigatorContent;

            var div:Div = navigatorContent.getElementAt(0) as Div;
            div.removeEventListener(ElementExistenceEvent.ELEMENT_ADD, onDivElementAddRemove);
            div.removeEventListener(ElementExistenceEvent.ELEMENT_REMOVE, onDivElementAddRemove);
			
			dispatchEvent(new Event("itemRemoved"));

            return navigatorContent;
		}

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@orientation = this.orientation;
            xml.@scrollable = this.scrollable;

            var tabCount:int = this.numElements;
            for (var i:int = 0; i < tabCount; i++)
            {
                xml.appendChild(this.tabToXML(i));
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            this.removeAllElements();

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            if ("@orientation" in xml)
            {
                this.orientation = xml.@orientation == "" ? "top" : xml.@orientation;
            }
            this.scrollable = xml.@scrollable == "true";

            var tabsXML:XMLList = xml.elements("tab");
            var tabsCount:int = tabsXML.length();
            for(var i:int = 0; i < tabsCount; i++)
            {
                var tabXML:XML = tabsXML[i];
                var tabChildren:XMLList = tabXML.Div;

                var tab:NavigatorContent = new NavigatorContent();
                tab.label = tabXML.@title;
                if (tabChildren.length() == 1)
                {
                    super.addElement(tab);
                }
                else
                {
                    this.addElement(tab);
                }

                this.tabFromXML(tab, tabXML, callback);
            }
            this.selectedIndex = xml.@selectedIndex;

            tabViewContentHeightChanged = true;
            this.invalidateDisplayList();
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this);

            xml.@orientation = this.orientation;
            xml.@scrollable = this.scrollable;

            var tabCount:int = this.numElements;
            for (var i:int = 0; i < tabCount; i++)
            {
                var navContent:NavigatorContent = this.getElementAt(i) as NavigatorContent;
                var navContentCount:int = navContent.numElements;

                var tab:XML = new XML("<tab />");
                tab.addNamespace(primeFacesNamespace);
                tab.setNamespace(primeFacesNamespace);
                tab.@title = navContent.label;

                for (var j:int = 0; j < navContentCount; j++)
                {
                    var surfaceElement:IPrimeFacesSurfaceComponent = navContent.getElementAt(j) as IPrimeFacesSurfaceComponent;
                    if (surfaceElement === null)
                    {
                        continue;
                    }

                    tab.appendChild(surfaceElement.toCode());
                }

                xml.appendChild(tab);
            }

            return xml;
        }
		
		public function getComponentsChildren():OrganizerItem
		{
			var componentsArray:Array = [];
			var organizerItem:OrganizerItem;
			var element:IPrimeFacesSurfaceComponent;
			for(var i:int = 0; i < this.numElements; i++)
			{
				var navContent:NavigatorContent = this.getElementAt(i) as NavigatorContent;
				var navContentCount:int = navContent.numElements;
				
				for (var j:int = 0; j < navContentCount; j++)
				{
					var surfaceElement:IPrimeFacesSurfaceComponent = navContent.getElementAt(j) as IPrimeFacesSurfaceComponent;
					if (surfaceElement === null)
					{
						continue;
					}
					
					organizerItem = surfaceElement.getComponentsChildren();
					if (organizerItem) 
					{
						organizerItem.name = navContent.label;
						componentsArray.push(organizerItem);
					}
				}
			}
			
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, "TabView", (componentsArray.length > 0) ? componentsArray : []));
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

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (tabViewContentHeightChanged)
            {
                this.setContentGroupSize();
                tabViewContentHeightChanged = false;
            }
        }

        override protected function partAdded(partName:String, instance:Object):void
        {
            super.partAdded(partName, instance);

            if (instance == tabBar)
            {
                tabBar.addEventListener(IndexChangeEvent.CHANGE, onTabChange);
            }
        }

        override protected function partRemoved(partName:String, instance:Object):void
        {
            super.partRemoved(partName, instance);

            if (instance == tabBar)
            {
                tabBar.removeEventListener(IndexChangeEvent.CHANGE, onTabChange);
            }
        }

        private function tabToXML(index:int):XML
        {
            var xml:XML = new XML(<tab/>);
            var tab:NavigatorContent = this.getItemAt(index) as NavigatorContent;
            xml.@title = tab.label;
            var elementCount:int = tab.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IPrimeFacesSurfaceComponent = tab.getElementAt(i) as IPrimeFacesSurfaceComponent;
                if(element === null)
                {
                    continue;
                }
                xml.appendChild(element.toXML());
            }
            return xml;
        }

        private function tabFromXML(tab:NavigatorContent, xml:XML, callback:Function):void
        {
            var elementsXML:XMLList = xml.elements();
            var childCount:int = elementsXML.length();
            var container:Div;
            if (tab.numElements > 0)
            {
                container = tab.getElementAt(0) as Div;
            }
            for(var i:int = 0; i < childCount; i++)
            {
                var childXML:XML = elementsXML[i];
                if (container)
                {
                    container.setStyle("borderVisible", false);
                    callback(container, childXML);
                }
                else
                {
                    container = this.getNewDiv();
                    container.fromXML(childXML, callback);

                    tab.addElement(container);
                }
            }
        }

        private function setContentGroupSize():void
        {
            if (!selectedItem) return;

            var elementsHeight:Number = 0;
            var elementsWidth:Number = 0;
            var visualElementContainer:IVisualElementContainer = (selectedItem as IVisualElementContainer);
            var divContainer:Div;
            var numEl:int = visualElementContainer.numElements;
            if (numEl > 0)
            {
                divContainer = visualElementContainer.getElementAt(0) as Div;
                if (divContainer)
                {
                    visualElementContainer = divContainer as IVisualElementContainer;
                    numEl = visualElementContainer.numElements;
                }
            }

            for (var i:int = 0; i < numEl; i++)
            {
                var contentGroupChild:IVisualElement = visualElementContainer.getElementAt(i);
                elementsHeight += contentGroupChild.height;

                if (div.direction == ContainerDirection.HORIZONTAL_LAYOUT)
                {
                    elementsWidth += contentGroupChild.width;
                }
            }

            this.contentGroup.height = elementsHeight;
            if (div.direction == ContainerDirection.HORIZONTAL_LAYOUT)
            {
                this.contentGroup.width = elementsWidth;
            }

        }

        private function getNewDiv():Div
        {
            var div:Div = new Div();
            div.percentWidth = div.percentHeight = 100;
            div.setStyle("borderVisible", false);
            div.addEventListener(ElementExistenceEvent.ELEMENT_ADD, onDivElementAddRemove);
            div.addEventListener(ElementExistenceEvent.ELEMENT_REMOVE, onDivElementAddRemove);

            return div;
        }

        private function onDivElementAddRemove(event:ElementExistenceEvent):void
        {
            if (!widthOutput || !heightOutput)
            {
                tabViewContentHeightChanged = true;
                this.invalidateDisplayList();
            }
        }

        private function onTabChange(event:IndexChangeEvent):void
        {
            dispatchEvent(event.clone());
        }
    }
}
