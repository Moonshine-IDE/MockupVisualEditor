package view.primeFaces.surfaceComponents.components
{
    import components.primeFaces.Tree;

    import data.OrganizerItem;

    import flash.events.Event;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import interfaces.components.ITree;

    import mx.controls.Tree;

    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.primeFaces.propertyEditors.TreePropertyEditor;
    import view.suportClasses.PropertyChangeReference;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces tree component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;Tree
     * <b>Attributes</b>
     * width="120"
     * height="120"
     * var=""
     * value=""&gt;
     *  &lt;TreeNode value="#{}"/&gt;
     * &lt;/Tree&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:tree
     * <b>Attributes</b>
     * style="width:120px;height:120px;"
     * var=""
     * value=""&gt;
     *  &lt;p:treeNode&gt;
     *      &lt;h:outputText value="#{}"/&gt;
     *  &lt;/p:treeNode&gt;
     * &lt;/p:tree&gt;
     * </pre>
     */
    public class Tree extends mx.controls.Tree implements IGetChildrenSurfaceComponent, IHistorySurfaceComponent, ICDATAInformation
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "tree";
        public static const ELEMENT_NAME:String = "Tree";
		
		private var component:ITree;
		
        public function Tree()
        {
            super();
			
			component = new components.primeFaces.Tree();
			
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
                "explicitMinHeightChanged",
				"treeVarChanged",
				"treeValueChanged"
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
         * <listing version="3.0">&lt;Tree percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tree style="width:80%;"/&gt;</listing>
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
         * @default "121"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Tree width="121"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tree style="width:121px;height:20px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;Tree percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tree style="height:80%;"/&gt;</listing>
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
         * @default "20"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Tree height="20"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tree style="width:121px;height:20px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
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
            return TreePropertyEditor;
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
		
		private var _treeVar:String = "";

		[Bindable("treeVarChanged")]
        /**
         * <p>PrimeFaces: <strong>var</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Tree var=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tree var=""/&gt;</listing>
         */
		public function get treeVar():String
		{
			return _treeVar;
		}

		public function set treeVar(value:String):void
		{
			if (_treeVar == value) return;
			
			_propertyChangeFieldReference = new PropertyChangeReference(this, "treeVar", _treeVar, value);
			
			_treeVar = value;
			dispatchEvent(new Event("treeVarChanged"));
		}
		
		private var _treeValue:String = "";

		[Bindable("treeValueChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Tree value=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:tree value=""/&gt;</listing>
         */
		public function get treeValue():String
		{
			return _treeValue;
		}
		public function set treeValue(value:String):void
		{
			if (_treeValue == value) return;
			
			_propertyChangeFieldReference = new PropertyChangeReference(this, "treeValue", _treeValue, value);
			
			_treeValue = value;
			dispatchEvent(new Event("treeValueChanged"));
		}

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            xml.@["var"] = this.treeVar;
            xml.@value = this.treeValue;

            var treeNode:XML;
            if (treeVar != "")
            {
                treeNode = new XML("<TreeNode/>");
                treeNode.@value = "#{"+ this.treeVar +"}";
                xml.appendChild(treeNode);
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

			component.fromXML(xml, callback, localSurface, lookup);
			
            this.treeVar = component.treeVar;
            this.treeValue = component.treeValue;
        }

        public function toCode():XML
        {
			component.treeValue = this.treeValue;
			component.treeVar = this.treeVar;
			
			component.isSelected = this.isSelected;
			(component as components.primeFaces.Tree).width = this.width;
			(component as components.primeFaces.Tree).height = this.width;
			(component as components.primeFaces.Tree).percentWidth = this.percentWidth;
			(component as components.primeFaces.Tree).percentHeight = this.percentHeight;
			
            return component.toCode();
        }
        public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
        public function toRora():XML
        {
            return null;
        }
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, null));
		}
    }
}
