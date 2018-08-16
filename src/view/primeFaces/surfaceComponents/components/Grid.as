package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import mx.containers.GridItem;
    import mx.containers.GridRow;
    import mx.core.IVisualElement;
    import mx.core.ScrollPolicy;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.IComponentSizeOutput;

    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.GridPropertyEditor;
    import view.primeFaces.supportClasses.GridBase;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;

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
     * height="120"
     * percentWidth="80"
     * percentHeight="80"&gt;
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
    public class Grid extends GridBase implements IPrimeFacesSurfaceComponent, IHistorySurfaceCustomHandlerComponent, IComponentSizeOutput
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "div";
        public static const ELEMENT_NAME:String = "Grid";
		public static const EVENT_CHILDREN_UPDATED:String = "eventChildrenUpdated";

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
				"itemRemoved",
				"itemAdded"
            ];

            this.ensureCreateInitialRowWithColumn();
			this.hookDivEventBypassing();
        }

        private var _widthOutput:Boolean = true;
        private var widthOutputChanged:Boolean;

        [Bindable]
        public function get widthOutput():Boolean
        {
            return _widthOutput;
        }

        public function set widthOutput(value:Boolean):void
        {
            if (_widthOutput != value)
            {
                _widthOutput = value;

                if (!value)
                {
                    widthOutputChanged = true;
                    this.invalidateProperties();
                }
            }
        }

        private var _heightOutput:Boolean = true;
        private var heightOutputChanged:Boolean;

        [Bindable]
        public function get heightOutput():Boolean
        {
            return _heightOutput;
        }

        public function set heightOutput(value:Boolean):void
        {
            if (_heightOutput != value)
            {
                _heightOutput = value;

                if (!value)
                {
                    heightOutputChanged = true;
                    this.invalidateProperties();
                }
            }
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
		
		[Exclude(name="isSelected", kind="property")]
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
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

        override public function set selectedRow(value:int):void
        {
            if (selectedRow != value && value != -1)
            {
                resetSelectionColorForSelectedItem(selectedRow, selectedColumn);

                super.selectedRow = value;
            }
        }

        override public function set selectedColumn(value:int):void
        {
            if (selectedColumn != value && value != -1)
            {
                resetSelectionColorForSelectedItem(selectedRow, selectedColumn);

                super.selectedColumn = value;
            }
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Grid percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;Grid width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:120px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;Grid percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="height:80%;"/&gt;</listing>
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

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (selectionChanged)
            {
                setColorForSelectedItem(this.selectedRow, this.selectedColumn);
                selectionChanged = false;
            }

            if (this.widthOutputChanged)
            {
                this.percentWidth = Number.NaN;
                this.width = Number.NaN;
                this.widthOutputChanged = false;
            }

            if (this.heightOutputChanged)
            {
                this.percentHeight = Number.NaN;
                this.height = Number.NaN;
                this.heightOutputChanged = false;
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
                            gridItem.percentWidth = gridItem.percentHeight = 100;

                            var divXMLList:XMLList = colXML.elements();
                            var divXML:XML = divXMLList[0];

                            var div:Div = new Div();
                            div.percentWidth = div.percentHeight = 100;
                            div.setStyle("borderColor", _columnBorderColor);
                            div.addEventListener(MouseEvent.ROLL_OVER, onDivRollOver);
                            div.addEventListener(MouseEvent.ROLL_OUT, onDivRollOut);
                            div.addEventListener(MouseEvent.CLICK, onDivClick);

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
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this);

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

        override public function addRow():IVisualElement
        {
            var row:IVisualElement = super.addRow();

            _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addItemAt", this.getElementAt(selectedRow), this.getElementAt(selectedRow));
            dispatchEvent(new Event("itemAdded"));

            return row;
        }

        override public function removeRow(index:int):IVisualElement
        {
            var removedElement:IVisualElement = super.removeRow(index);

            if (removedElement)
            {
                var historyObject:Object = {object: removedElement, index: index};
                _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeItemAt", historyObject, historyObject);
            }

            return removedElement;
        }

        override public function addColumn(rowIndex:int):GridItem
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            var gridItem:GridItem = null;
            if (gridRow && gridRow.numElements < maxColumnCount)
            {
                gridItem = super.addColumn(rowIndex);
				var historyObject:Object = {object:gridItem, parent:gridRow};
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addColumnAt", historyObject, historyObject);
            }

            return gridItem;
        }

        override public function removeColumn(rowIndex:int, columnIndex:int):IVisualElement
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            if (gridRow && gridRow.numElements > MIN_COLUMN_COUNT)
            {
                var removedColumn:IVisualElement = super.removeColumn(rowIndex, columnIndex);
				
				var historyObject:Object = {object:removedColumn, parent:gridRow, index:columnIndex};
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeColumnAt", historyObject, historyObject);

                return removedColumn;
            }

            return null;
        }

        override public function removeAllElements():void
        {
            super.removeAllElements();

            this._selectedRow = -1;
            this._selectedColumn = -1;
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
            var uigDefaultValue:int = Math.ceil(maxColumnCount / gridRow.numElements);
            var uigDefault:String = "ui-g-" + uigDefaultValue;
            var uigDesktop:String = "ui-lg-" + uigDefaultValue;

            var uigOtherScreensValue:int = Math.ceil(uigDefaultValue / 2);
            var uigPhones:String = "ui-sm-" + uigOtherScreensValue;
            var uigTablets:String = "ui-md-" + uigOtherScreensValue;
            var uigBigScreens:String = "ui-xl-" + uigDefaultValue;

            return uigDefault + " " + uigDesktop + " " + uigPhones + " " + uigTablets + " " + uigBigScreens;
        }

        private function setColorForSelectedItem(selectedRowIndex:int, selectedColumnIndex:int):void
        {
            var div:Div = getDiv(selectedRowIndex, selectedColumnIndex);
            if (div)
            {
                div.setStyle("backgroundColor", this.getStyle("themeColor"));
                div.setStyle("backgroundAlpha", 0.4);
            }
        }
    }
}
