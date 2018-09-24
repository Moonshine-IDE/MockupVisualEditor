package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.collections.ArrayCollection;
    import mx.collections.IList;
    
    import spark.components.DropDownList;
    
    import data.OrganizerItem;
    import data.SelectItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.interfaces.ISelectableItemsComponent;
    import view.primeFaces.propertyEditors.SelectOneMenuPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.SelectOneMenuSkin;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]
	[Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="isSelected", kind="property")]
	[Exclude(name="dataProvider", kind="property")]

    /**
     * <p>Representation of selectOneMenu in HTML</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;SelectOneMenu
     * <b>Attributes</b>
     * width="120"
     * height="120"
     * percentWidth=""
     * percentHeight=""
     * editable="false"
     * value=""/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:selectOneMenu
     * <b>Attributes</b>
     * style="width:120px;height:120px;"
     * editable="false"
     * value=""/&gt;
     * </pre>
     */
    public class SelectOneMenu extends DropDownList implements ISelectableItemsComponent, IPrimeFacesSurfaceComponent, IHistorySurfaceCustomHandlerComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "selectOneMenu";
        public static const ELEMENT_NAME:String = "SelectOneMenu";

        public function SelectOneMenu()
        {
            super();
			
			this.width = 120;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
			
			this.setStyle("skinClass", SelectOneMenuSkin);

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"dataProviderChanged",
				"editableChanged"
            ];
			
			this.dataProvider = new ArrayCollection([new SelectItem("Select One", "")]);
			this.labelField = "itemLabel";
			this.requireSelection = true;
        }
		
		override public function set dataProvider(value:IList):void
		{
			if (super.dataProvider === value) return;
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "dataProvider", super.dataProvider, value);
			
			super.dataProvider = value;
			dispatchEvent(new Event("dataProviderChanged"));
		}

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;SelectOneMenu percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneMenu style="percentWidth:80%;"/&gt;</listing>
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
         * @default 120
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;SelectOneMenu width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneMenu style="width:120px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;SelectOneMenu percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneMenu style="percentHeight:80%;"/&gt;</listing>
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
         * @default 120
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;SelectOneMenu height="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneMenu style="height:120px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

		private var _value:String;

		[Bindable("valueChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @default null
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;SelectOneMenu value=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneMenu value=""/&gt;</listing>
         */
		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			if (_value === value) return;
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "value", _value, value);
			
			_value = value;
			dispatchEvent(new Event("valueChanged"));
		}
		
		private var _editable:Boolean;

		[Bindable("editableChanged")]
        /**
         * <p>PrimeFaces: <strong>editable</strong></p>
         *
         * @default false
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;SelectOneMenu editable="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneMenu editable="false"/&gt;</listing>
         */
		public function get editable():Boolean
		{
			return _editable;
		}

		public function set editable(value:Boolean):void
		{
			if (_editable == value) return;
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "editable", _editable, value);
			
			_editable = value;
			dispatchEvent(new Event("editableChanged"));
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
		
		private var _isUpdating:Boolean;
		public function get isUpdating():Boolean
		{
			return _isUpdating;
		}
		
		public function set isUpdating(value:Boolean):void
		{
			_isUpdating = value;
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
		
		protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
		{
			_propertyChangeFieldReference = new PropertyChangeReference(this, fieldName, oldValue, newValue);
		}

        public function get propertyEditorClass():Class
        {
            return SelectOneMenuPropertyEditor;
        }
		
		public function restorePropertyOnChangeReference(nameField:String, value:*):void
		{
			
		}

		public function getComponentsChildren():OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, "SelectOneMenu", null));
		}
		
        public function toXML():XML
        {
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			
			XMLCodeUtils.setSizeFromComponentToXML(this, xml);
			
			xml["@value"] = this.value;
			xml["@editable"] = this.editable.toString();
			
			var itemXML:XML;
			for each (var item:SelectItem in dataProvider)
			{
				itemXML = new XML("<selectItem />");
				itemXML["@itemLabel"] = item.itemLabel;
				itemXML["@itemValue"] = item.itemValue;
				itemXML["@itemVar"] = item.itemVar;
				itemXML["@value"] = item.value;
				xml.appendChild(itemXML);
			}

            return xml;
        }
		
		public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
			
			this.value = xml.@value;
			this.editable = xml.@editable == "true" ? true : false;
			
			var tmpItem:SelectItem;
			this.dataProvider = new ArrayCollection();
			for each (var i:XML in xml.selectItem)
			{
				tmpItem = new SelectItem(i.@itemLabel, i.@itemValue);
				tmpItem.itemVar = i.@itemVar;
				tmpItem.value = i.@value;
				this.dataProvider.addItem(tmpItem);
			}
        }

		public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");
			var facetNamespace:Namespace = new Namespace("f", "http://xmlns.jcp.org/jsf/core");
			var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
			xml.addNamespace(primeFacesNamespace);
			xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this);
            xml["@value"] = this.value;
			xml["@editable"] = this.editable.toString();
			
			var itemXML:XML;
			for each (var item:SelectItem in dataProvider)
			{
				itemXML = new XML("<selectItem />");
				itemXML.addNamespace(facetNamespace);
				itemXML.setNamespace(facetNamespace);
				itemXML["@itemLabel"] = item.itemLabel;
				itemXML["@itemValue"] = item.itemValue;
				xml.appendChild(itemXML);
			}

            return xml;
        }
    }
}