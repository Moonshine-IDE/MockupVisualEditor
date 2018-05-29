package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.collections.ArrayList;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    
    import spark.components.ComboBox;
    
    import data.DataProviderListItem;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IDataProviderComponent;
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.interfaces.ISelectableItemsComponent;
    import view.primeFaces.propertyEditors.AutoCompleteDropDownListPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.AutoCompleteDropDownListSkin;
    import view.suportClasses.PropertyChangeReference;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]

    /**
     * <p>Representation of PrimeFaces autoComplete component</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;DropDownList
     * <b>Attributes</b>
     * width="120"
     * height="30"
     * multiple="false"
     * dropDown="true"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:autoComplete
     * <b>Attributes</b>
     * style="width:120px;height:30px;"
     * multiple="false"
     * dropDown="true"/&gt;
     * </pre>
     */
    public class AutoCompleteDropDownList extends ComboBox implements IPrimeFacesSurfaceComponent,
            IDataProviderComponent, ISelectableItemsComponent, IHistorySurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "autoComplete";
        public static const ELEMENT_NAME:String = "DropDownList";

        public function AutoCompleteDropDownList()
        {
            super();

            this.setStyle("skinClass", AutoCompleteDropDownListSkin);
            this.setStyle("borderColor", "#a8a8a8");

            this.mouseChildren = false;

            this.dataProvider = new ArrayList(
                    [
                        new DataProviderListItem("One"),
                        new DataProviderListItem("Two"),
                        new DataProviderListItem("Three"),
                        new DataProviderListItem("Four"),
                        new DataProviderListItem("Five")
                    ]);

            this.selectedIndex = 0;

            this.width = 120;
            this.height = 30;
            this.minWidth = 20;
            this.minHeight = 20;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "dropDownListChanged",
                "multipleChanged"
            ];
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

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DropDownList width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:autoComplete style="width:120px;height:30px;"/&gt;</listing>
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
         * @default "30"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DropDownList height="30"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        private var _isDropDown:Boolean = true;

        /**
         * <p>PrimeFaces: <strong>dropdown</strong></p>
         *
         * @default "true"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DropDownList dropdown="true"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:autoComplete dropdown="true"/&gt;</listing>
         */
        public function get isDropDown():Boolean
        {
            return _isDropDown;
        }

        private var _multiple:Boolean;

		[Bindable("multipleChanged")]
        /**
         * <p>PrimeFaces: <strong>multiple</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DropDownList multiple="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:autoComplete multiple="false"/&gt;</listing>
         */
        public function get multiple():Boolean
        {
            return _multiple;
        }

        public function set multiple(value:Boolean):void
        {
            if (_multiple != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "multiple", _multiple, value);
				
                _multiple = value;
                dispatchEvent(new Event("multipleChanged"));
            }
        }

        public function get propertyEditorClass():Class
        {
            return AutoCompleteDropDownListPropertyEditor;
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

            xml.@dropdown = this.isDropDown;
            xml.@multiple = this.multiple;

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.multiple = xml.@multiple == "true";
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            xml.@dropdown = this.isDropDown;
            xml.@multiple = this.multiple;

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            return xml;
        }

        override protected function dataProvider_collectionChangeHandler(event:Event):void
        {
            super.dataProvider_collectionChangeHandler(event);

            if (event is CollectionEvent)
            {
                var ce:CollectionEvent = CollectionEvent(event);

                if (ce.kind == CollectionEventKind.ADD || ce.kind == CollectionEventKind.REMOVE)
                {
                    dispatchEvent(new Event("dropDownListChanged"));
                }
            }
        }
    }
}
