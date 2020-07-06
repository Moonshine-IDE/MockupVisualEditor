package view.domino.surfaceComponents.components
{
    import components.domino.DominoTabView;
    import components.tabNavigator.TabNavigatorWithOrientation;

    import data.OrganizerItem;

    import flash.events.Event;

    import interfaces.IComponentSizeOutput;
    import interfaces.components.ITabView;

    import mx.core.IVisualElement;
    import mx.core.IVisualElementContainer;
    import mx.events.CollectionEvent;
    import mx.utils.StringUtil;
    import mx.controls.Alert;
    //import components.primeFaces.Div;

    import spark.events.ElementExistenceEvent;
    import spark.events.IndexChangeEvent;

    import utils.XMLCodeUtils;
    import view.interfaces.IDominoSurfaceComponent;
    import view.interfaces.ICDATAInformation;
    import view.interfaces.IDiv;
    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.interfaces.ISelectableItemsComponent;
    import view.domino.propertyEditors.TabViewPropertyEditor;
    import view.primeFaces.supportClasses.ContainerDirection;
    import view.primeFaces.supportClasses.NavigatorContent;
    //import view.primeFaces.supportClasses.components.Div;
    import view.primeFaces.surfaceComponents.components.Div;
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
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="partAdded", kind="method")]
    [Exclude(name="partRemoved", kind="method")]
    [Exclude(name="updateDisplayList", kind="method")]
    [Exclude(name="div", kind="property")]
    [Exclude(name="widthOutput", kind="property")]
    [Exclude(name="heightOutput", kind="property")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

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
    public class DominoTabView extends TabNavigatorWithOrientation implements IDominoSurfaceComponent, ISelectableItemsComponent,
            IHistorySurfaceCustomHandlerComponent, IComponentSizeOutput, IDiv, ICDATAInformation
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "tabView";
        public static const ELEMENT_NAME:String = "TabView";
		public static const EVENT_CHILDREN_UPDATED:String = "eventChildrenUpdated";

		private var component:ITabView;
		
        public function DominoTabView()
        {
            super();
			
			component = new components.domino.DominoTabView(this);
			
            this.selectedIndex = 0;

            this.minWidth = 300;
            this.minHeight = 170;

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
             //Alert.show("get div is divContent:"+super.selectedIndex);
            if (super.selectedItem)
            {
                var navContent:NavigatorContent = (super.selectedItem as NavigatorContent);
                //Alert.show("navContent.numElements:"+navContent.numElements);
                if (navContent.numElements > 0)
                {
                  
                    if((super.selectedItem as NavigatorContent).getElementAt(0) is Div){
                        //Alert.show("select is div");
                         _div =  (super.selectedItem as NavigatorContent).getElementAt(0) as Div;
                    }else{
                        //Alert.show("select not is div");
                        _div = null;
                    }
                   
                }else{

                    if(super.selectedIndex==0){
                         navContent.addElement(getNewDiv());
                         _div=navContent.getElementAt(0) as Div;
                    }else{
                         _div = null;
                    }


                   
                   
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
         * <listing version="3.0">&lt;p:tabView style="percentWidth:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;p:tabView style="percentHeight:80%;"/&gt;</listing>
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

            //Alert.show("addElement");
            if (element is NavigatorContent)
            {
                 //Alert.show("element is NavigatorContent");
                return super.addElement(element);

            }
            else
            {
                var divContent:Div = this.div;
                if (divContent)
                {
                     
                    return divContent.addElement(element);
                }
                else
                {
                     // Alert.show("element not is divContent");
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

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            xml.@orientation = this.orientation;
            xml.@scrollable = this.scrollable;
           
            //  if(div.direction){
            //     xml.@direction=div.direction;
            // }

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

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

			component.fromXML(xml, callback);
			
			this.orientation = component.orientation;
			this.scrollable = component.scrollable;
			this.selectedIndex = component.selectedIndex;
			
			var tabsXML:XMLList = xml.elements("tab");
            var tabsCount:int = tabsXML.length();
            for(var i:int = 0; i < tabsCount; i++)
            {
                var tabXML:XML = tabsXML[i];
                var tab:NavigatorContent = this.getElementAt(i) as NavigatorContent;
  
                this.tabFromXML(tab, tabXML);
            }
	
            tabViewContentHeightChanged = true;
            this.invalidateDisplayList();
        }

        public function toCode():XML
        {
            component.orientation = this.orientation;
            component.scrollable = this.scrollable;
			
			component.isSelected = this.isSelected;
			(component as components.domino.DominoTabView).width = this.width;
			(component as components.domino.DominoTabView).height = this.width;
			(component as components.domino.DominoTabView).percentWidth = this.percentWidth;
			(component as components.domino.DominoTabView).percentHeight = this.percentHeight;
			
            return component.toCode();
        }
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			var organizerItem:OrganizerItem;
			var surfaceElement:IPrimeFacesSurfaceComponent;
			var navContent:NavigatorContent;
			
			// returning particular tab index item
			if (params.length > 0)
			{
				if (params[0] == "addItemAt")
				{
					navContent = this.getElementAt(params[1]) as NavigatorContent;
					surfaceElement = navContent.getElementAt(0) as IPrimeFacesSurfaceComponent;
					organizerItem = (surfaceElement as IPrimeFacesSurfaceComponent).getComponentsChildren();
					if (organizerItem)
					{
						organizerItem.name = StringUtil.trim(navContent.label).length > 0 ? navContent.label : "Tab (Unlabelled)";
						organizerItem.type = OrganizerItem.TYPE_TAB;
					}
				}
				
				return organizerItem;
			}
			
			// returning regular component item
			var componentsArray:Array = [];
			for(var i:int = 0; i < this.numElements; i++)
			{
				navContent = this.getElementAt(i) as NavigatorContent;
				var navContentCount:int = navContent.numElements;
				
				for (var j:int = 0; j < navContentCount; j++)
				{
					surfaceElement = navContent.getElementAt(j) as IPrimeFacesSurfaceComponent;
					if (surfaceElement === null)
					{
						continue;
					}
					
					organizerItem = surfaceElement.getComponentsChildren();
					if (organizerItem) 
					{
						organizerItem.name = StringUtil.trim(navContent.label).length > 0 ? navContent.label : "Tab (Unlabelled)";
						organizerItem.type = OrganizerItem.TYPE_TAB;
						componentsArray.push(organizerItem);
					}
				}
			}
			
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, (componentsArray.length > 0) ? componentsArray : []));
		}

        public function getNewDiv():Div
        {
            var div:Div = new Div();
            div.percentWidth = div.percentHeight = 100;
            div.setStyle("borderVisible", false);
            div.addEventListener(ElementExistenceEvent.ELEMENT_ADD, onDivElementAddRemove);
            div.addEventListener(ElementExistenceEvent.ELEMENT_REMOVE, onDivElementAddRemove);

            return div;
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (this.widthOutputChanged)
            {
                this.percentWidth = 200;
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
                callLater(setContentGroupSize);
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

        private function tabFromXML(tab:NavigatorContent, xml:XML):void
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
					container.percentWidth = div.percentHeight = 100;
                    container.addEventListener(ElementExistenceEvent.ELEMENT_ADD, onDivElementAddRemove);
                    container.addEventListener(ElementExistenceEvent.ELEMENT_REMOVE, onDivElementAddRemove);
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

        private function onDivElementAddRemove(event:ElementExistenceEvent):void
        {
            invalidateTabViewSize();
        }

        private function onTabChange(event:IndexChangeEvent):void
        {
			// the following event throw makes Moonshine as something has changed
			// to the file adding the * mark to the tab; 
			// this also makes Organizer updates by the component's
			// last PropertyChangeReference value; 
			// I see the based on this event some fields in property editor
			// updates though; Following flag will not raise this event outside
			// of the Visual Editor library and will prevent Moonshine from thinking
			// something has changed, and leave Organizer from self-updating
			isUpdating = true;
            dispatchEvent(event.clone());
			isUpdating = false;

            invalidateTabViewSize();
        }

        private function invalidateTabViewSize():void
        {
            if (!widthOutput || !heightOutput)
            {
                tabViewContentHeightChanged = true;
                this.invalidateDisplayList();
            }
        }
    }
}
