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

        private function fillDataTable():void
        {
			_tableColumnDescriptor = new ArrayCollection();
			
			var tmpTableVO:DataProviderListItem = new DataProviderListItem();
			tmpTableVO.label = "Column 1";
			_tableColumnDescriptor.addItem(tmpTableVO);
			
			generateColumns(true);
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
		
		private var _tableVar:String = "";
		[Bindable("tableVarChanged")]
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

        private var _emptyMessage:String = NO_RECORDS_FOUND;

        [Bindable(event="emptyMessageChanged")]
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
		override public function set resizableColumns(value:Boolean):void
		{
			if (super.resizableColumns != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "resizableColumns", super.resizableColumns, value);
				
				super.resizableColumns = value;
				dispatchEvent(new Event("resizableColumnsChanged"));
			}
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
    }
}