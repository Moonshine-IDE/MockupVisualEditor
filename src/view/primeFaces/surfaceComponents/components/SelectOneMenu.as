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
    [Exclude(name="ELEMENT_NAME", kind="property")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]
    [Exclude(name="internalToXML", kind="method")]
    [Exclude(name="mainXML", kind="property")]
    [Exclude(name="widthOutput", kind="property")]
    [Exclude(name="heightOutput", kind="property")]
	[Exclude(name="componentAddedToEditor", kind="method")]
	[Exclude(name="getComponentsChildren", kind="method")]
	[Exclude(name="updateItems", kind="method")]

    /**
     * <p>Representation of selectOneMenu in HTML</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;SelectOneMenu
     * <b>Attributes</b>
     * width="120"
     * height="120"
     * percentWidth="80"
     * percentHeight="80"
     * class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;selectOneMenu
     * <b>Attributes</b>
     * style="width:120px;height:120px;"
     * class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;
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
				"lazyChanged"
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
		
		private var _value:String;
		[Bindable("valueChanged")]
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
		
		private var _lazy:Boolean;
		[Bindable("lazyChanged")]
		public function get lazy():Boolean
		{
			return _lazy;
		}
		public function set lazy(value:Boolean):void
		{
			if (_lazy == value) return;
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "lazy", _lazy, value);
			
			_lazy = value;
			dispatchEvent(new Event("lazyChanged"));
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
			xml["@lazy"] = this.lazy.toString();
			
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
			this.lazy = xml.@lazy == "true" ? true : false;
			
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
			xml["@lazy"] = this.lazy.toString();
			
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