package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.core.IVisualElement;
    import mx.events.CollectionEvent;
    
    import spark.components.NavigatorContent;
    import spark.events.IndexChangeEvent;
    
    import components.tabNavigator.TabNavigatorWithOrientation;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.interfaces.ISelectableItemsComponent;
    import view.primeFaces.propertyEditors.TabViewPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceTabView;

    public class TabView extends TabNavigatorWithOrientation implements IPrimeFacesSurfaceComponent, ISelectableItemsComponent, IHistorySurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "tabView";
        public static const ELEMENT_NAME:String = "TabView";
		public static const EVENT_CHILDREN_UPDATED:String = "eventChildrenUpdated";

        public function TabView()
        {
            super();

            this.selectedIndex = 0;

            this.width = 120;
            this.height = 120;
            this.minWidth = 20;
            this.minHeight = 20;

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
			_propertyChangeFieldReference = new PropertyChangeReference(this, "addItemAt", element, element);
			
            if (element is NavigatorContent)
            {
                return super.addElement(element);
            }
            else
            {
                return (this.selectedItem as NavigatorContent).addElement(element);
            }
			
			dispatchEvent(new Event("itemAdded"));
        }
		
		override public function removeItemAt(index:int):Object
		{
			var historyObject:Object = {object:this.getItemAt(index), index:index};
			_propertyChangeFieldReference = new PropertyChangeReference(this, "removeItemAt", historyObject, historyObject);
			return super.removeItemAt(index);
			
			dispatchEvent(new Event("itemRemoved"));
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
		
		override protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
		{
			if (oldValue && (oldValue is Array)) _propertyChangeFieldReference = new PropertyChangeReferenceTabView(this, fieldName, oldValue, newValue);
			else _propertyChangeFieldReference = new PropertyChangeReference(this, fieldName, oldValue, newValue);
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
                var tab:NavigatorContent = new NavigatorContent();
                tab.label = tabXML.@title;

                this.addElement(tab);

                this.tabFromXML(tab, tabXML, callback);
            }
            this.selectedIndex = xml.@selectedIndex;
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

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
            for(var i:int = 0; i < childCount; i++)
            {
                var childXML:XML = elementsXML[i];
                callback(tab, childXML);
            }
        }
    }
}
