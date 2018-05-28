package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    import flash.net.registerClassAlias;
    
    import mx.collections.ArrayCollection;
    import mx.collections.ArrayList;
    import mx.utils.ObjectUtil;
    
    import spark.components.DataGrid;
    import spark.components.gridClasses.GridColumn;
    
    import data.DataProviderListItem;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IDataProviderComponent;
    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.DataTablePropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="tableColumnDescriptor", kind="property")]
	[Exclude(name="generateColumns", kind="method")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]

    /**
     * <p>Representation of PrimeFaces dataTable component</p>
     *
     * <strong>Visual Editor XML:</strong>
	 *
     * <pre>
     * 	&lt;DataTable
     * 		<b>Attributes</b>
     * 		width="120"
     * 		height="120"
     * 		paginator="false"
     * 		resizableColumns="false"
	 *  	var="" value=""
     * 		emptyMessage="No records found."&gt;
	 * 		   &lt;column headerText="Column 1" value=""/&gt;
	 * &lt;/DataTable&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     *  &lt;p:dataTable
     *      	<b>Attributes</b>
     *      	style="width:120px;height:120px;"
     *      	paginator="false"
     *      	resizableColumns="false"
	 *     	var="" value=""
	 *     	emptyMessage="No records found."&gt;
	 *          &lt;p:column headerText="Column 1" value=""&gt;
	 * 		        &lt;h:outputText value=""/&gt;
	 *          &lt;/p:column&gt;
	 * &lt;/p:dataTable&gt;
     * </pre>
     */
    public class DataTable extends DataGrid implements IPrimeFacesSurfaceComponent, IDataProviderComponent, IHistorySurfaceCustomHandlerComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "dataTable";
        public static const ELEMENT_NAME:String = "DataTable";
		public static const GRID_ITEM_EDIT:String = "gridItemEdit";
		public static const GRID_ITEM_DELETE:String = "gridItemDelete";
		public static const GRID_ITEM_ADD:String = "gridItemAdd";
		public static const EVENT_CHILDREN_UPDATED:String = "eventChildrenUpdated";

        private static const NO_RECORDS_FOUND:String = "No records found.";

        public function DataTable()
        {
            super();

            this.mouseChildren = false;
            this.width = 120;
            this.height = 120;
            this.minWidth = 20;
            this.minHeight = 20;
            this.resizableColumns = false;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "resizableColumnsChanged",
                "paginatorChanged",
                "emptyMessageChanged",
				"tableVarChanged",
				"tableValueChanged",
				"tableColumnDescriptorChanged",
				"itemRemoved",
				"itemAdded",
				"itemUpdated",
            ];

            fillDataTable();
        }

        public function get propertyEditorClass():Class
        {
            return DataTablePropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
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

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DropDownList height="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:dataTable style="width:100px;height:120px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
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
         * <listing version="3.0">&lt;DataTable width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:dataTable style="width:120px;height:30px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
        }

		private var _tableVar:String = "";

		[Bindable("tableVarChanged")]
        /**
         * <p>PrimeFaces: <strong>var</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DataTable var=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:dataTable var=""/&gt;</listing>
         */
		public function get tableVar():String
		{
			return _tableVar;
		}
		public function set tableVar(value:String):void
		{
			if (_tableVar == value) return;
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "tableVar", _tableVar, value);
			
			_tableVar = value;
			dispatchEvent(new Event("tableVarChanged"));
		}
		
		private var _tableValue:String = "";

		[Bindable("tableValueChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DataTable value=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:dataTable value=""/&gt;</listing>
         */
		public function get tableValue():String
		{
			return _tableValue;
		}
		public function set tableValue(value:String):void
		{
			if (_tableValue == value) return;
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "tableValue", _tableValue, value);
			
			_tableValue = value;
			dispatchEvent(new Event("tableValueChanged"));
		}

        private var _emptyMessage:String = NO_RECORDS_FOUND;

        [Bindable(event="emptyMessageChanged")]
        /**
         * <p>PrimeFaces: <strong>emptyMessage</strong></p>
         *
         * @default "No records found."
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DataTable emptyMessage="No records found."/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:dataTable emptyMessage="No records found."/&gt;</listing>
         */
        public function get emptyMessage():String
        {
            return _emptyMessage;
        }

        public function set emptyMessage(value:String):void
        {
            if (_emptyMessage != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "emptyMessage", _emptyMessage, value);
				
                _emptyMessage = value;
                dispatchEvent(new Event("emptyMessageChanged"));
            }
        }

        private var _paginator:Boolean;

        [Bindable(event="paginatorChanged")]
        /**
         * <p>PrimeFaces: <strong>paginator</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DataTable paginator="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:dataTable paginator="false"/&gt;</listing>
         */
        public function get paginator():Boolean
        {
            return _paginator;
        }

        public function set paginator(value:Boolean):void
        {
            if (_paginator != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "paginator", _paginator, value);
				
                _paginator = value;
                dispatchEvent(new Event("paginatorChanged"));
            }
        }
		
		[Bindable(event="resizableColumnsChanged")]
        /**
         * <p>PrimeFaces: <strong>resizableColumns</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;DataTable resizableColumns="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:dataTable resizableColumns="false"/&gt;</listing>
         */
		override public function set resizableColumns(value:Boolean):void
		{
			if (super.resizableColumns != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "resizableColumns", super.resizableColumns, value);
				
				super.resizableColumns = value;
				dispatchEvent(new Event("resizableColumnsChanged"));
			}
		}

        public function restorePropertyOnChangeReference(nameField:String, value:*):void
        {
            var deleteIndex:int;
            switch(nameField)
            {
                case "removeItemAt":
                    try
                    {
                        deleteIndex = _tableColumnDescriptor.getItemIndex(value.object);
                        _tableColumnDescriptor.removeItemAt(deleteIndex);
                        generateColumns(false, DataTable.GRID_ITEM_DELETE, deleteIndex);
                    }
                    catch(e:Error)
                    {
                        _tableColumnDescriptor.addItemAt(value.object, value.index);
                        generateColumns(true);
                    }

                    dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
                    break;
                case "addItemAt":
                    try
                    {
                        deleteIndex = _tableColumnDescriptor.getItemIndex(value);
                        _tableColumnDescriptor.removeItemAt(deleteIndex);
                        generateColumns(false, DataTable.GRID_ITEM_DELETE, deleteIndex);
                    }
                    catch(e:Error)
                    {
                        _tableColumnDescriptor.addItem(value);
                        generateColumns(true);
                    }

                    dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
                    break;
                case "updateItemAt":
                    DataProviderListItem(_tableColumnDescriptor[value.index]).updateItemWith(value.object);
                    generateColumns(false, DataTable.GRID_ITEM_EDIT, value.index);
                    break;
                default:
                    this[nameField.toString()] = value;
                    break;
            }
        }

        public function generateColumns(isAll:Boolean=false, updateType:String=null, itemIndex:int=-1):void
        {
            var tmpColumn:GridColumn;

            if (isAll)
            {
                columns = new ArrayList();
                for each (var i:DataProviderListItem in _tableColumnDescriptor)
                {
                    tmpColumn = new GridColumn();
                    tmpColumn.headerText = tmpColumn.dataField = i.label;
                    columns.addItem(tmpColumn);
                }

                this.invalidateDisplayList();
            }
            else
            {
                switch(updateType)
                {
                    case GRID_ITEM_ADD:
                    {
                        _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addItemAt", _tableColumnDescriptor[_tableColumnDescriptor.length - 1], _tableColumnDescriptor[_tableColumnDescriptor.length - 1]);

                        // item always added to last
                        tmpColumn = new GridColumn();
                        tmpColumn.headerText = tmpColumn.dataField = _tableColumnDescriptor[_tableColumnDescriptor.length - 1].label;
                        columns.addItem(tmpColumn);
                        dispatchEvent(new Event("itemAdded"));
                        break;
                    }
                    case GRID_ITEM_EDIT:
                    {
                        if (itemIndex != -1)
                        {
                            tmpColumn = columns.getItemAt(itemIndex) as GridColumn;
                            tmpColumn.headerText = tmpColumn.dataField = _tableColumnDescriptor[itemIndex].label;

                            // dispatch only if there are changes and user not just edit ended without makeing any change
                            if (!isUpdating && (_propertyChangeFieldReference.fieldLastValue.object.label != _tableColumnDescriptor[itemIndex].label ||
                                            _propertyChangeFieldReference.fieldLastValue.object.value != _tableColumnDescriptor[itemIndex].value))
                            {
                                registerClassAlias("DataProviderListItem", DataProviderListItem);
                                _propertyChangeFieldReference.fieldNewValue = {object:ObjectUtil.copy(_tableColumnDescriptor[itemIndex]), index:itemIndex};
                                dispatchEvent(new Event("itemUpdated"));
                            }
                        }
                        break;
                    }
                    case GRID_ITEM_DELETE:
                    {
                        if (itemIndex != -1)
                        {
                            if (!isUpdating)
                            {
                                var historyObject:Object = {object:_tableColumnDescriptor[itemIndex], index:itemIndex};
                                _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeItemAt", historyObject, historyObject);
                            }

                            columns.removeItemAt(itemIndex);
                            dispatchEvent(new Event("itemRemoved"));
                        }
                        break;
                    }
                }
            }
        }

        private var _tableColumnDescriptor:ArrayCollection;
        [Bindable("tableColumnDescriptorChanged")]
        public function get tableColumnDescriptor():ArrayCollection
        {
            return _tableColumnDescriptor;
        }
        public function set tableColumnDescriptor(value:ArrayCollection):void
        {
            if (_tableColumnDescriptor === value) return;

            _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "tableColumnDescriptor", _tableColumnDescriptor, value);

            _tableColumnDescriptor = value;
            dispatchEvent(new Event("tableColumnDescriptorChanged"));
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            xml.@paginator = this.paginator;
            xml.@resizableColumns = this.resizableColumns;
            xml.@emptyMessage = this.emptyMessage;
			xml.@['var'] = tableVar;
			xml.@value = tableValue;
			
			var column:XML;
			for each (var col:DataProviderListItem in tableColumnDescriptor)
			{
				column = new XML("<column/>");
				column.@headerText = col.label;
				column.@value = (col.value ||= '');
				xml.appendChild(column);
			}

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.paginator = xml.@paginator == "true";
            this.resizableColumns = xml.@resizableColumns == "true";
            this.emptyMessage = !xml.@emptyMessage ? NO_RECORDS_FOUND : xml.@emptyMessage;
			this.tableVar = xml.@['var'];
			this.tableValue = xml.@value;
			
			var tmpColumnVO:DataProviderListItem;
			_tableColumnDescriptor = new ArrayCollection();
			
			// re-generate column
			for each (var col:XML in xml.column)
			{
				tmpColumnVO = new DataProviderListItem();
				tmpColumnVO.label = col.@headerText;
				tmpColumnVO.value = col.@value;
				_tableColumnDescriptor.addItem(tmpColumnVO);
			}
			
			generateColumns(true);
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
			var hNamespace:Namespace = new Namespace("h", "http://xmlns.jcp.org/jsf/html");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            xml.@paginator = this.paginator;
            xml.@resizableColumns = this.resizableColumns;
            xml.@emptyMessage = this.emptyMessage;
			if (tableVar != "") xml.@['var'] = tableVar;
			if (tableValue != "") xml.@value = tableValue;
			
			var column:XML;
			var outputText:XML;
			for each (var col:DataProviderListItem in tableColumnDescriptor)
			{
				column = new XML("<column/>");
				column.addNamespace(primeFacesNamespace);
				column.setNamespace(primeFacesNamespace);
				column.@headerText = col.label;
				
				if (tableVar != "")
				{
					outputText = new XML("<outputText/>");
					outputText.addNamespace(hNamespace);
					outputText.setNamespace(hNamespace);
					outputText.@value = "#{"+ tableVar +"."+ (col.value ||= '') +"}";
					column.appendChild(outputText);
				}
				
				xml.appendChild(column);
			}

            return xml;
        }

        private function fillDataTable():void
        {
            _tableColumnDescriptor = new ArrayCollection();

            var tmpTableVO:DataProviderListItem = new DataProviderListItem();
            tmpTableVO.label = "Column 1";
            _tableColumnDescriptor.addItem(tmpTableVO);

            generateColumns(true);
        }
    }
}