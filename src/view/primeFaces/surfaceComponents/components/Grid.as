package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.containers.Grid;
    import mx.containers.GridItem;
    import mx.containers.GridRow;
    import mx.core.IVisualElement;
    import mx.core.ScrollPolicy;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.GridPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;
    import view.suportClasses.events.SurfaceComponentEvent;

    [Exclude(name="selectedColumn", kind="property")]
    [Exclude(name="selectedRow", kind="property")]
    [Exclude(name="addColumn", kind="method")]
    [Exclude(name="addRow", kind="method")]
    [Exclude(name="removeColumn", kind="method")]
    [Exclude(name="removeRow", kind="method")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="updateDisplayList", kind="method")]
    [Exclude(name="EVENT_CHILDREN_UPDATED", kind="property")]

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="div", kind="property")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]

    /**
     * <p>Representation of PrimeFaces Grid CSS component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;Grid
     * <b>Attributes</b>
     * width="110"
     * height="120"&gt;
     * &lt;Row&gt;
     *  &lt;Column class="ui-g-12 ui-lg-12 ui-sm-6 ui-md-6 ui-xl-12"&gt;
     *      &lt;Div percentWidth="100" percentHeight="100"/&gt;
     *  &lt;/Column&gt;
     * &lt;/Row&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;div
     * <b>Attributes</b>
     * style="width:110px;height:120px;"&gt;
     *  &lt;div class="ui-g"&gt;
     *      &lt;div class="ui-g-12 ui-lg-12 ui-sm-6 ui-md-6 ui-xl-12"&gt;
     *          &lt;div style="width:100%;height:100%;"/&gt;
     *      &lt;/div&gt;
     *  &lt;/div&gt;
     * &lt;/div&gt;
     * </pre>
     */
    public class Grid extends mx.containers.Grid implements IPrimeFacesSurfaceComponent, IHistorySurfaceCustomHandlerComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "div";
        public static const ELEMENT_NAME:String = "Grid";
		public static const EVENT_CHILDREN_UPDATED:String = "eventChildrenUpdated";

        private static const MAX_COLUMN_COUNT:int = 12;
        private static const MIN_COLUMN_COUNT:int = 1;
        private static const MIN_ROW_COUNT:int = 1;

        private static const COLUMN_BORDER_COLOR:String = "#7096ab";

        public function Grid()
        {
            super();

            this.width = 120;
            this.height = 120;
            this.minWidth = 20;
            this.minHeight = 20;

            this.setStyle("verticalGap", 1);
            this.setStyle("horizontalGap", 1);
            this.setStyle("verticalScrollPolicy", ScrollPolicy.OFF);
            this.setStyle("horizontalScrollPolicy", ScrollPolicy.OFF);

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "requestedColumnCountChanged",
                "requestedRowCountChanged",
				"itemRemoved",
				"itemAdded"
            ];

            this.ensureCreateInitialColumn();
			this.hookDivEventBypassing();
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

        public function get propertyEditorClass():Class
        {
            return GridPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        private var _selectedRow:int;

        [Bindable]
        public function get selectedRow():int
        {
            return _selectedRow;
        }

        public function set selectedRow(value:int):void
        {
            if (_selectedRow != value && value != -1)
            {
                _selectedRow = value;
            }
        }

        private var _selectedColumn:int;

        [Bindable]
        public function get selectedColumn():int
        {
            return _selectedColumn;
        }

        public function set selectedColumn(value:int):void
        {
            if (_selectedColumn != value && value != -1)
            {
                _selectedColumn = value;
            }
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
         * <listing version="3.0">&lt;Grid width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:120px;height:120px;"/&gt;</listing>
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
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Grid height="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:120px;height:120px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        public function restorePropertyOnChangeReference(nameField:String, value:*):void
		{
			var deleteIndex:int;
			switch(nameField)
			{
				case "removeItemAt":
					try
					{
						deleteIndex = this.getElementIndex(value.object);
						this.removeElementAt(deleteIndex);
					} 
					catch(e:Error)
					{
						this.addElementAt(value.object, value.index);
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				case "addItemAt":
					try
					{
						deleteIndex = this.getElementIndex(value);
						this.removeElementAt(deleteIndex);
					} 
					catch(e:Error)
					{
						this.addElement(value);
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				case "removeColumnAt":
					try
					{
						deleteIndex = value.parent.getElementIndex(value.object);
						value.parent.removeElementAt(deleteIndex);
					} 
					catch(e:Error)
					{
						value.parent.addElementAt(value.object, value.index);
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				case "addColumnAt":
					try
					{
						deleteIndex = value.parent.getElementIndex(value.object);
						value.parent.removeElementAt(deleteIndex);
					} 
					catch(e:Error)
					{
						value.parent.addElement(value.object);
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				default:
					this[nameField.toString()] = value;
					break;
			}
		}

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            var gridRowNumElements:int = this.numElements;
            for (var row:int = 0; row < gridRowNumElements; row++)
            {
                var rowXML:XML = new XML("<Row />");
                rowXML["@class"] = "ui-g";

                var gridRow:GridRow = this.getElementAt(row) as GridRow;
                var gridColumnNumElements:int = gridRow.numElements;
                for (var col:int = 0; col < gridColumnNumElements; col++)
                {
                    var gridCol:GridItem = gridRow.getElementAt(col) as GridItem;
                    var div:Div = gridCol.getElementAt(0) as Div;

                    var colXML:XML = new XML("<Column />");
                    colXML["@class"] = this.getClassNameBasedOnColumns(gridRow);

                    colXML.appendChild(div.toXML());

                    rowXML.appendChild(colXML);
                }

                xml.appendChild(rowXML);
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            var elementsXML:XMLList = xml.elements();
            if (elementsXML.length() > 0)
            {
                this.removeAllElements();

                var childCount:int = elementsXML.length();
                for(var row:int = 0; row < childCount; row++)
                {
                    var rowXML:XML = elementsXML[row];
                    var colListXML:XMLList = rowXML.elements();

                    var gridRow:GridRow = new GridRow();
                    gridRow.percentWidth = gridRow.percentHeight = 100;

                    var colCount:int = colListXML.length();
                    for (var col:int = 0; col < colCount; col++)
                    {
                        var colXML:XML = colListXML[col];
                        if (colXML.length() > 0)
                        {
                            var gridItem:GridItem = new GridItem();
                            gridItem.setStyle("backgroundColor", "#a8a8a8");
                            gridItem.percentWidth = gridItem.percentHeight = 100;

                            var divXMLList:XMLList = colXML.elements();
                            var divXML:XML = divXMLList[0];

                            var div:Div = new Div();
                            div.percentWidth = div.percentHeight = 100;

                            div.setStyle("borderColor", COLUMN_BORDER_COLOR);

                            gridItem.addElement(div);
                            gridRow.addElement(gridItem);

                            div.fromXML(divXML, callback);
                        }
                    }

                    this.addElement(gridRow);
                }
            }
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            var gridRowNumElements:int = this.numElements;
            for (var row:int = 0; row < gridRowNumElements; row++)
            {
                var rowXML:XML = new XML("<div />");
                rowXML["@class"] = "ui-g";

                var gridRow:GridRow = this.getElementAt(row) as GridRow;
                var gridColumnNumElements:int = gridRow.numElements;
                for (var col:int = 0; col < gridColumnNumElements; col++)
                {
                    var gridCol:GridItem = gridRow.getElementAt(col) as GridItem;
                    var div:Div = gridCol.getElementAt(0) as Div;

                    var colXML:XML = new XML("<div />");
                    colXML["@class"] = this.getClassNameBasedOnColumns(gridRow);

                    colXML.appendChild(div.toCode());

                    rowXML.appendChild(colXML);
                }

                xml.appendChild(rowXML);
            }

            return xml;
        }

        public function addRow():void
        {
            var gridItem:GridItem = this.ensureCreateInitialColumn();
            var addedElements:Array = [gridItem.getElementAt(0)];
			
            dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentAdded, addedElements));

            this.selectedRow += 1;
            this.selectedColumn = 0;
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addItemAt", this.getElementAt(selectedRow), this.getElementAt(selectedRow));
			dispatchEvent(new Event("itemAdded"));
        }

        public function removeRow(index:int):IVisualElement
        {
            if (this.numElements > MIN_ROW_COUNT)
            {
                var removedElement:GridRow = this.getElementAt(index) as GridRow;

                var removedItems:Array = [];
                var numRemovedElements:int = removedElement.numElements;
                for (var row:int = 0; row < numRemovedElements; row++)
                {
                    var gridItem:GridItem = removedElement.getElementAt(row) as GridItem;
                    removedItems.push(gridItem.getElementAt(0));
                }

                removedElement = this.removeElement(removedElement) as GridRow;
				
				var historyObject:Object = {object:removedElement, index:index};
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeItemAt", historyObject, historyObject);
                
				if (removedElement)
                {
                    dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentRemoved, removedItems));
                }

                var selRow:int = this.selectedRow - 1;
                this.selectedRow = selRow == -1 ? 0 : selRow;
				dispatchEvent(new Event("itemRemoved"));

                return removedElement;
            }

            return null;
        }

        public function addColumn(rowIndex:int):void
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            if (gridRow && gridRow.numElements < MAX_COLUMN_COUNT)
            {
                gridRow.percentWidth = gridRow.percentHeight = 100;

                var gridItem:GridItem = new GridItem();
                gridItem.setStyle("backgroundColor", "#a8a8a8");
                gridItem.percentWidth = gridItem.percentHeight = 100;

                var div:Div = new Div();
                div.percentWidth = div.percentHeight = 100;
                div.setStyle("borderColor", COLUMN_BORDER_COLOR);

                gridItem.addElement(div);
                gridRow.addElement(gridItem);

                this.selectedColumn += 1;

                dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentAdded, [div]));
				
				var historyObject:Object = {object:gridItem, parent:gridRow};
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addColumnAt", historyObject, historyObject);
				dispatchEvent(new Event("itemAdded"));
            }
        }

        public function removeColumn(rowIndex:int, columnIndex:int):IVisualElement
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            if (gridRow && gridRow.numElements > MIN_COLUMN_COUNT)
            {
                var removedColumn:IVisualElement = gridRow.removeElementAt(columnIndex);

                var selColumn:int = this.selectedColumn - 1;
                this.selectedColumn = selColumn == -1 ? 0 : selColumn;
				
				var historyObject:Object = {object:removedColumn, parent:gridRow, index:columnIndex};
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeColumnAt", historyObject, historyObject);
				dispatchEvent(new Event("itemRemoved"));

                return removedColumn;
            }

            return null;
        }

        private function ensureCreateInitialColumn():GridItem
        {
            var gridRow:GridRow = new GridRow();
            gridRow.percentWidth = gridRow.percentHeight = 100;
            var gridItem:GridItem = new GridItem();
            gridItem.setStyle("backgroundColor", "#a8a8a8");
            gridItem.percentWidth = gridItem.percentHeight = 100;

            var div:Div = new Div();
            div.percentWidth = div.percentHeight = 100;
            div.setStyle("borderColor", COLUMN_BORDER_COLOR);

            gridItem.addElement(div);
            gridRow.addElement(gridItem);

            this.addElement(gridRow);

            return gridItem;
        }
		
		private function hookDivEventBypassing():void
		{
			var gridRow:GridRow = this.getElementAt(0) as GridRow;
			var div:Div = (gridRow.getElementAt(0) as GridItem).getElementAt(0) as Div;
			var propertiesChangedEventsCount:int = div.propertiesChangedEvents.length;
			for(var i:int = 0; i < propertiesChangedEventsCount; i++)
			{
				if ((div.propertiesChangedEvents[i] as String).toLowerCase().indexOf("width") == -1 && (div.propertiesChangedEvents[i] as String).toLowerCase().indexOf("height") == -1) 
				{
					_propertiesChangedEvents.push(div.propertiesChangedEvents[i]);
				}
			}
		}

        private function getClassNameBasedOnColumns(gridRow:GridRow):String
        {
            var uigDefaultValue:int = Math.ceil(MAX_COLUMN_COUNT / gridRow.numElements);
            var uigDefault:String = "ui-g-" + uigDefaultValue;
            var uigDesktop:String = "ui-lg-" + uigDefaultValue;

            var uigOtherScreensValue:int = Math.ceil(uigDefaultValue / 2);
            var uigPhones:String = "ui-sm-" + uigOtherScreensValue;
            var uigTablets:String = "ui-md-" + uigOtherScreensValue;
            var uigBigScreens:String = "ui-xl-" + uigDefaultValue;

            return uigDefault + " " + uigDesktop + " " + uigPhones + " " + uigTablets + " " + uigBigScreens;
        }
    }
}
