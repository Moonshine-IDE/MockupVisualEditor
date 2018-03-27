package view.primeFaces.surfaceComponents.components
{
    import mx.controls.Tree;

    import utils.XMLCodeUtils;

    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.BasicPropertyEditor;

    public class Tree extends mx.controls.Tree implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "tree";
        public static const ELEMENT_NAME:String = "Tree";

        public function Tree()
        {
            super();

            this.mouseChildren = false;
            this.width = 120;
            this.height = 120;
            this.minWidth = 20;
            this.minHeight = 20;

            this.showRoot = false;
            this.setStyle("folderOpenIcon", null);
            this.setStyle("folderClosedIcon", null);
            this.setStyle("defaultLeafIcon", null);

            this.labelField = "label";

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged"
            ];

            var data:Array = [
                    {
                        label: "Node 0",
                        children: [
                            { label: "Node 0.0",
                              children: [
                                  {label: "Node 0.0.0"},
                                  {label: "Node 0.0.1"}
                            ]},
                            { label: "Node 0.1",
                              children: [
                                  {label: "Node 0.1.0"}
                              ]}
                        ]
                    },
                    {
                        label: "Node 1",
                        children: [
                            {
                                label: "Node 1.0",
                                children: [
                                    {label: "Node 1.0.0"}
                            ]},
                            {
                                label: "Node 1.1"
                            }
                        ]
                    },
                    {
                        label: "Node 2"
                    }
             ];

            this.dataProvider = data;
        }

        public function get propertyEditorClass():Class
        {
            return BasicPropertyEditor;
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

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            createPrimeFacesTreeChildren(this.dataProvider, xml);

            return xml;
        }

        private function createPrimeFacesTreeChildren(data:Object, xml:XML):void
        {
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            var hNamespace:Namespace = new Namespace("h", "http://xmlns.jcp.org/jsf/html");

            for each (var item:Object in data)
            {
                var node:XML = new XML("<treeNode/>");
                node.addNamespace(primeFacesNamespace);
                node.setNamespace(primeFacesNamespace);

                var outputText:XML = new XML("<outputText/>");
                outputText.addNamespace(hNamespace);
                outputText.setNamespace(hNamespace);

                outputText.@value = item.label;

                node.appendChild(outputText);
                xml.appendChild(node);

                if (item.children)
                {
                    createPrimeFacesTreeChildren(item.children, node);
                }
            }
        }
    }
}
