package view.primeFaces.surfaceComponents.components
{
    import components.tabNavigator.TabNavigatorWithOrientation;

    import mx.core.IVisualElement;

    import spark.components.NavigatorContent;
    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.interfaces.ISelectableItemsComponent;
    import view.primeFaces.propertyEditors.TabViewPropertyEditor;

    public class TabView extends TabNavigatorWithOrientation implements IPrimeFacesSurfaceComponent, ISelectableItemsComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "tabView";
        public static const ELEMENT_NAME:String = "tabView";

        public function TabView()
        {
            super();

            this.selectedIndex = 0;

            this.width = 120;
            this.height = 30;
            this.minWidth = 20;
            this.minHeight = 20;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged"
            ];

            var navigatorContent:NavigatorContent = new NavigatorContent();
            navigatorContent.label = "Title";

            addElement(navigatorContent);
        }

        override public function addElement(element:IVisualElement):IVisualElement
        {
            if (element is NavigatorContent)
            {
                return super.addElement(element);
            }
            else
            {
                return (this.selectedItem as NavigatorContent).addElement(element);
            }
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
                tab.label = tabXML.@label;

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
                var tab:XML = new XML("<tab />");
                tab.addNamespace(primeFacesNamespace);
                tab.setNamespace(primeFacesNamespace);

                var navContent:NavigatorContent = this.getElementAt(i) as NavigatorContent;
                var navContentCount:int = navContent.numElements;
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
            var xml:XML = <tab/>;
            var tab:NavigatorContent = this.getItemAt(index) as NavigatorContent;
            xml.@label = tab.label;
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

        public function tabFromXML(tab:NavigatorContent, xml:XML, callback:Function):void
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
