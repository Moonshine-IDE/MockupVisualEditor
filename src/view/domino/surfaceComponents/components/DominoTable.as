////////////////////////////////////////////////////////////////////////////////
// Copyright 2022 Prominic.NET, Inc.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software 
// distributed under the License is distributed on an "AS IS" BASIS, 
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and 
// limitations under the License
// 
// Author: Prominic.NET, Inc.
// No warranty of merchantability or fitness of any kind. 
// Use this software at your own risk.
////////////////////////////////////////////////////////////////////////////////
package view.domino.surfaceComponents.components
{
    import flash.events.Event;
    import flash.events.MouseEvent;

    import interfaces.IComponentSizeOutput;
	import interfaces.IRoyaleComponentConverter;

	import view.primeFaces.supportClasses.GridItem;
    import view.primeFaces.supportClasses.GridRow;
    import mx.core.IVisualElement;
    import mx.core.ScrollPolicy;
    
    import data.OrganizerItem;
    import utils.XMLCodeUtils;

    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.primeFaces.supportClasses.GridBase;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;
    import interfaces.dominoComponents.IDominoTable;
    import components.domino.DominoTable;
    import view.interfaces.IDominoSurfaceComponent;
    import view.primeFaces.surfaceComponents.components.Div;
	import view.domino.propertyEditors.DominoTablePropertyEditor;
	
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
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="removeAllElements", kind="method")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="widthOutput", kind="property")]
    [Exclude(name="heightOutput", kind="property")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]


    public class DominoTable extends GridBase implements IDominoSurfaceComponent,
			IHistorySurfaceCustomHandlerComponent, IComponentSizeOutput, IRoyaleComponentConverter
    {
        public static const ELEMENT_NAME:String = "Grid";
		public static const EVENT_CHILDREN_UPDATED:String = "eventChildrenUpdated";

		private var component:IDominoTable;
		
        public function DominoTable()
        {
            super();
			
			component = new components.domino.DominoTable(this);
			
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
				"removedAll",
				"itemAdded",
                "columnWidthAttributeChanged"
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

        private var _widthtype:String;
		public function get widthtype():String
		{
			return _widthtype;
		}
		public function set widthtype(value:String):void
		{
			_widthtype = value;
		}


        private var _leftmargin:String;
		public function get leftmargin():String
		{
			return _leftmargin;
		}
		public function set leftmargin(value:String):void
		{
			_leftmargin = value;
		}

        private var _rightmargin:String;
		public function get rightmargin():String
		{
			return _rightmargin;
		}
		public function set rightmargin(value:String):void
		{
			_rightmargin = value;
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

        public function get propertyEditorClass():Class
        {
            return DominoTablePropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
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

        override public function set width(value:Number):void
        {
            super.width=value;
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
                this.percentWidth = 100;
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
				case "removeRowAt":
					try
					{
						deleteIndex = this.getElementIndex(value.object);
						this.removeElementAt(deleteIndex);
						_selectedRow--;
					} 
					catch(e:Error)
					{
						this.addElementAt(value.object, value.index);
						_selectedRow++;
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				case "addRowAt":
					try
					{
						deleteIndex = this.getElementIndex(value);
						this.removeElementAt(deleteIndex);
						_selectedRow--;
					} 
					catch(e:Error)
					{
						this.addElement(value);
						_selectedRow++;
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				case "removeColumnAt":
					try
					{
						deleteIndex = value.parent.getElementIndex(value.object);
						value.parent.removeElementAt(deleteIndex);
						_selectedColumn--;
					} 
					catch(e:Error)
					{
						value.parent.addElementAt(value.object, value.index);
						_selectedColumn++;
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				case "addColumnAt":
					try
					{
						deleteIndex = value.parent.getElementIndex(value.object);
						value.parent.removeElementAt(deleteIndex);
						_selectedColumn--;
					} 
					catch(e:Error)
					{
						value.parent.addElement(value.object);
						_selectedColumn++;
					}
					
					dispatchEvent(new Event(EVENT_CHILDREN_UPDATED));
					break;
				default:
					this[nameField.toString()] = value;
					break;
			}
		}


        private var _columnProperties:String;
        [Bindable(event="columnWidthAttributeChanged")]
		public function get columnProperties():String
		{
			return _columnProperties;
		}
		public function set columnProperties(value:String):void
		{
            if (_columnProperties != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "columnProperties", _columnProperties, value);
				_columnProperties = value;
                dispatchEvent(new Event("columnWidthAttributeChanged"))
            }
			
		}

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if(this.columnProperties){
                xml.@columsProperty = this.columnProperties;
            }

            if(this.leftmargin){
                xml.@leftmargin = this.leftmargin;
            }

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

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
                    colXML["@class"] = this.getClassNameBasedOnColumns(gridColumnNumElements);

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

            if(xml.@refwidth!=null){
               delete xml.@refwidth;
            }

            if(xml.@leftmargin!=null){
                this.leftmargin=xml.@leftmargin;
            }

            if(xml.@columsProperty!=null){
                this.columnProperties=xml.@columsProperty;
            }

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);
  
            var elementsXML:XMLList = xml.elements();
           
            if (elementsXML.length() > 0)
            {
                this.removeAllElements();
            }

			component.fromXML(xml, callback);

            if (elementsXML.length() > 0)
            {
                var childCount:int = elementsXML.length();

                for(var row:int = 0; row < childCount; row++)
                {
                    var rowXML:XML = elementsXML[row];
                    var colListXML:XMLList = rowXML.elements();

                    var colCount:int = colListXML.length();
                    for (var col:int = 0; col < colCount; col++)
                    {
                        var colXML:XML = colListXML[col];
                        if (colXML.length() > 0)
                        {
                           
                            var div:Div = getDiv(row, col);
                            if(div==null){
                                //Alert.show("div is null 467");
                            }else{
                                div.percentWidth = div.percentHeight = 100;
                                div.setStyle("borderColor", _columnBorderColor);
                                div.addEventListener(MouseEvent.ROLL_OVER, onDivRollOver);
                                div.addEventListener(MouseEvent.ROLL_OUT, onDivRollOut);
                                div.addEventListener(MouseEvent.CLICK, onDivClick);
                            }
                            
                        }
                    }
                }
            }
        }

        public function toCode():XML
        {
            component.isSelected = this.isSelected;
            (component as components.domino.DominoTable).leftmargin = this.leftmargin;
            (component as components.domino.DominoTable).rightmargin = this.rightmargin;
            (component as components.domino.DominoTable).widthtype = this.widthtype;
	        (component as components.domino.DominoTable).width = this.width;
			(component as components.domino.DominoTable).height = this.height;
			(component as components.domino.DominoTable).percentWidth = this.percentWidth;
			(component as components.domino.DominoTable).percentHeight = this.percentHeight;
            (component as components.domino.DominoTable).columnProperties = this.columnProperties;

            return component.toCode();
        }

        public	function toRoyaleConvertCode():XML
		{
			return new XML("");
		}
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			var componentsArray:Array = [];
			var organizerItem:OrganizerItem;
			var element:IGetChildrenSurfaceComponent;
			var tableRow:GridRow;
			var gridCol:GridItem;
			
			// returning particular tab index item
			if (params.length > 0)
			{
				if (params[0] == "addRowAt")
				{
					parseRowItems(this, this.getElementIndex(params[1] as GridRow));
				}
				else if (params[0] == "addColumnAt")
				{
					gridCol = params[1] as GridItem;
					element = gridCol.getElementAt(0) as IGetChildrenSurfaceComponent;
					organizerItem = element.getComponentsChildren();
					
					if (organizerItem) 
					{
						organizerItem.name = "R"+ (params[2]+1) +":C"+ (params[3]+1);
						organizerItem.type = OrganizerItem.TYPE_CELL;
					}
					
					return organizerItem;
				}
			}
			else
			{
				// return usual component reference
				for (var row:int = 0; row < this.numElements; row++)
				{
					parseRowItems(this, row);
				}
			}
			
			
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, (componentsArray.length > 0) ? componentsArray : []));
			
			// @local
			// parse back items inside tableRow
			function parseRowItems(dominoTable:DominoTable, rowIndex:int):void
			{
				tableRow = dominoTable.getElementAt(rowIndex) as GridRow;
				for (var col:int = 0; col < tableRow.numElements; col++)
				{
					gridCol = tableRow.getElementAt(col) as GridItem;
					element = gridCol.getElementAt(0) as IGetChildrenSurfaceComponent;
					
					organizerItem = element.getComponentsChildren();
					if (organizerItem) 
					{
						organizerItem.name = "R"+ (rowIndex+1) +":C"+ (col+1);
						organizerItem.type = OrganizerItem.TYPE_CELL;
						componentsArray.push(organizerItem);
					}
				}
			}
		}

        override public function addRow():IVisualElement
        {
            var row:IVisualElement = super.addRow();

            _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addRowAt", row, row);
            dispatchEvent(new Event("itemAdded"));

            return row;
        }

        override public function removeRow(index:int, dispatchChange:Boolean=true):IVisualElement
        {
            var removedElement:IVisualElement = super.removeRow(index, false);

            if (removedElement)
            {
                var historyObject:Object = {object: removedElement, index: index};
                _propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeRowAt", historyObject, historyObject);
				dispatchEvent(new Event("itemRemoved"));
            }

            return removedElement;
        }

        override public function addColumn(rowIndex:int, dispatchChange:Boolean=true):GridItem
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            var gridItem:GridItem = null;
            if (gridRow && gridRow.numElements < maxColumnCount)
            {
                gridItem = super.addColumn(rowIndex, false);
				var historyObject:Object = {object:gridItem, parent:gridRow, rowIndex:rowIndex, colIndex:gridRow.numChildren-1};
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addColumnAt", historyObject, historyObject);
				dispatchEvent(new Event("itemAdded"));
            }

            return gridItem;
        }

        override public function removeColumn(rowIndex:int, columnIndex:int, dispatchChange:Boolean=true):IVisualElement
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            if (gridRow && gridRow.numElements > MIN_COLUMN_COUNT)
            {
                var removedColumn:IVisualElement = super.removeColumn(rowIndex, columnIndex, false);
				
				var historyObject:Object = {object:removedColumn, parent:gridRow, index:columnIndex};
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeColumnAt", historyObject, historyObject);
				dispatchEvent(new Event("itemRemoved"));
				
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

        private function getClassNameBasedOnColumns(coulumnCountInRow:int):String
        {
            var columnFactor:int = maxColumnCount / coulumnCountInRow;

            var uigDefault:String = "ui-g-" + columnFactor;
            var uigDesktop:String = "ui-lg-" + columnFactor;

            var uigPhones:String = "ui-sm-" + columnFactor;
            var uigTablets:String = "ui-md-" + columnFactor;
            var uigBigScreens:String = "ui-xl-" + columnFactor;

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

        private function removeHeightFromInternalDiv(div:XML):XML
        {
            delete div.@height;
            delete div.@percentHeight;
            div.@style = "width:100%;";

            return div;
        }
    }
}
