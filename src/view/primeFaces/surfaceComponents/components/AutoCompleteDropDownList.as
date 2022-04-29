package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import mx.collections.ArrayList;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    
    import spark.components.ComboBox;
    
    import data.DataProviderListItem;
    import data.OrganizerItem;

    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;

    import view.interfaces.IDataProviderComponent;
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.interfaces.ISelectableItemsComponent;
    import view.primeFaces.propertyEditors.AutoCompleteDropDownListPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.AutoCompleteDropDownListSkin;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IAutoCompleteDropDownList;
    import components.primeFaces.AutoCompleteDropDownList;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="dataProvider_collectionChangeHandler", kind="method")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

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
	 * value="" completeMethod=""
	 * var="" itemLabel="" itemValue=""
	 * converter=""
     * dropDown="true"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:autoComplete
     * <b>Attributes</b>
     * style="width:120px;height:30px;"
     * multiple="false"
	 * value="" completeMethod=""
	 * var="" itemLabel="" itemValue="" 
	 * converter=""
     * dropDown="true"/&gt;
     * </pre>
     */
    public class AutoCompleteDropDownList extends ComboBox implements IGetChildrenSurfaceComponent,
            IDataProviderComponent, ISelectableItemsComponent, IHistorySurfaceComponent, ICDATAInformation
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "autoComplete";
        public static const ELEMENT_NAME:String = "DropDownList";

		private var component:IAutoCompleteDropDownList;
		
        public function AutoCompleteDropDownList()
        {
            super();
			
			component = new components.primeFaces.AutoCompleteDropDownList();
			
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
                "multipleChanged",
				"valueChanged",
				"completeMethodChanged",
				"fieldVarChanged",
				"itemLabelChanged",
				"itemValueChanged",
				"converterChanged"
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
         * <listing version="3.0">&lt;DropDownList percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:autoComplete style="width:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;DropDownList width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:autoComplete style="width:120px;height:30px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;DropDownList percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:autoComplete style="height:80%;"/&gt;</listing>
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
         * @default "30"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DropDownList height="30"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:autoComplete style="width:100px;height:30px;"/&gt;</listing>
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
		
		private var _value:String = "";
		
		[Bindable("valueChanged")]
		/**
		 * <p>PrimeFaces: <strong>value</strong></p>
		 *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;DropDownList value=""/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:autoComplete value=""/&gt;</listing>
		 */
		public function get value():String
		{
			return _value;
		}
		public function set value(value:String):void
		{
			if (_value != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "value", _value, value);
				
				_value = value;
				dispatchEvent(new Event("valueChanged"));
			}
		}

        private var _fieldVar:String = "";

        [Bindable("fieldVarChanged")]
        /**
         * <p>PrimeFaces: <strong>var</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DropDownList var=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:autoComplete var=""/&gt;</listing>
         */
        public function get fieldVar():String
        {
            return _fieldVar;
        }
        public function set fieldVar(value:String):void
        {
            if (_fieldVar != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "fieldVar", _fieldVar, value);

                _fieldVar = value;
                dispatchEvent(new Event("fieldVarChanged"));
            }
        }

        private var _completeMethod:String;
		
		[Bindable("completeMethodChanged")]
		/**
		 * <p>PrimeFaces: <strong>completeMethod (Optional)</strong></p>
		 *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;DropDownList completeMethod=""/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:autoComplete completeMethod=""/&gt;</listing>
		 */
		public function get completeMethod():String
		{
			return _completeMethod;
		}
		public function set completeMethod(value:String):void
		{
			if (_completeMethod != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "completeMethod", _completeMethod, value);
				
				_completeMethod = value;
				dispatchEvent(new Event("completeMethodChanged"));
			}
		}

		private var _itemLabel:String;
		
		[Bindable("itemLabelChanged")]
		/**
		 * <p>PrimeFaces: <strong>itemLabel (Optional)</strong></p>
		 *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;DropDownList itemLabel=""/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:autoComplete itemLabel=""/&gt;</listing>
		 */
		public function get itemLabel():String
		{
			return _itemLabel;
		}
		public function set itemLabel(value:String):void
		{
			if (_itemLabel != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "itemLabel", _itemLabel, value);
				
				_itemLabel = value;
				dispatchEvent(new Event("itemLabelChanged"));
			}
		}
		
		private var _itemValue:String;
		
		[Bindable("itemValueChanged")]
		/**
		 * <p>PrimeFaces: <strong>itemValue (Optional)</strong></p>
		 *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;DropDownList itemValue=""/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:autoComplete itemValue=""/&gt;</listing>
		 */
		public function get itemValue():String
		{
			return _itemValue;
		}
		public function set itemValue(value:String):void
		{
			if (_itemValue != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "itemValue", _itemValue, value);
				
				_itemValue = value;
				dispatchEvent(new Event("itemValueChanged"));
			}
		}
		
		private var _converter:String;
		
		[Bindable("converterChanged")]
		/**
		 * <p>PrimeFaces: <strong>converter (Optional)</strong></p>
		 *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;DropDownList converter=""/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:autoComplete converter=""/&gt;</listing>
		 */
		public function get converter():String
		{
			return _converter;
		}
		public function set converter(value:String):void
		{
			if (_converter != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "converter", _converter, value);
				
				_converter = value;
				dispatchEvent(new Event("converterChanged"));
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

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            xml.@['var'] = this.fieldVar;
            xml.@value = this.value;

            xml.@dropdown = this.isDropDown;
            xml.@multiple = this.multiple;

			if (this.completeMethod)
            {
                xml.@completeMethod = this.completeMethod;
            }

			if (this.itemLabel)
            {
                xml.@itemLabel = this.itemLabel;
            }

			if (this.itemValue)
            {
                xml.@itemValue = this.itemValue;
            }

			if (this.converter)
            {
                xml.@converter = this.converter;
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);
			
			this.component.fromXML(xml, callback, localSurface, lookup);
			
            this.value = component.value;
            this.fieldVar = component.fieldVar;

            this.multiple = component.multiple;

			this.completeMethod = component.completeMethod;
			this.itemLabel = component.itemLabel;
			this.itemValue = component.itemValue;
			this.converter = component.converter;
        }

        public function toCode():XML
        {
            component.multiple = this.multiple;
			
			component.value = this.value;
            component.fieldVar = this.fieldVar;
			component.completeMethod = this.completeMethod;
			component.itemLabel = this.itemLabel;
			component.itemValue = this.itemValue;
			component.converter = this.converter;
			
			component.isSelected = this.isSelected;
			(component as components.primeFaces.AutoCompleteDropDownList).percentWidth = this.percentWidth;
			(component as components.primeFaces.AutoCompleteDropDownList).percentHeight = this.percentHeight;
			(component as components.primeFaces.AutoCompleteDropDownList).height = this.height;
			(component as components.primeFaces.AutoCompleteDropDownList).width = this.width;
			
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
			return (new OrganizerItem(this, "AutoComplete", null));
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
