////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) STARTcloud, Inc. 2015-2022. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the Server Side Public License, version 1,
//  as published by MongoDB, Inc.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  Server Side Public License for more details.
//
//  You should have received a copy of the Server Side Public License
//  along with this program. If not, see
//
//  http://www.mongodb.com/licensing/server-side-public-license
//
//  As a special exception, the copyright holders give permission to link the
//  code of portions of this program with the OpenSSL library under certain
//  conditions as described in each individual source file and distribute
//  linked combinations including the program with the OpenSSL library. You
//  must comply with the Server Side Public License in all respects for
//  all of the code used other than as permitted herein. If you modify file(s)
//  with this exception, you may extend this exception to your version of the
//  file(s), but you are not obligated to do so. If you do not wish to do so,
//  delete this exception statement from your version. If you delete this
//  exception statement from all source files in the program, then also delete
//  it in the license file.
//
////////////////////////////////////////////////////////////////////////////////
package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    import flash.events.MouseEvent;

    import interfaces.IComponentSizeOutput;
	import interfaces.ILookup;
	import interfaces.ISurface;

	import view.primeFaces.supportClasses.GridItem;
    import view.primeFaces.supportClasses.GridRow;
    import mx.core.IVisualElement;
    import mx.core.ScrollPolicy;

    import mx.controls.Alert;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.primeFaces.propertyEditors.GridPropertyEditor;
    import view.suportClasses.GridBase;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;
    import interfaces.components.IGrid;
	import components.primeFaces.Grid;
	
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
     * &lt;p:outputPanel
     * <b>Attributes</b>
     * style="width:110px;height:120px;"&gt;
     *  &lt;div class="ui-g"&gt;
     *      &lt;div class="ui-g-12 ui-lg-12 ui-sm-6 ui-md-6 ui-xl-12"&gt;
     *          &lt;div style="width:100%;height:100%;"/&gt;
     *      &lt;/div&gt;
     *  &lt;/div&gt;
     * &lt;/p:outputPanel&gt;
     * </pre>
     */
    public class Grid extends GridBase implements IGetChildrenSurfaceComponent, IHistorySurfaceCustomHandlerComponent, IComponentSizeOutput
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "outputPanel";
        public static const ELEMENT_NAME:String = "Grid";
		public static const EVENT_CHILDREN_UPDATED:String = "eventChildrenUpdated";

		private var component:IGrid;
		
        public function Grid()
        {
            super();
			
			component = new components.primeFaces.Grid(this);
			
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

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

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

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

            var elementsXML:XMLList = xml.elements();
            if (elementsXML.length() > 0)
            {
                this.removeAllElements();
            }

			component.fromXML(xml, callback, localSurface, lookup);

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

        public function toCode():XML
        {
            component.isSelected = this.isSelected;
			(component as components.primeFaces.Grid).width = this.width;
			(component as components.primeFaces.Grid).height = this.width;
			(component as components.primeFaces.Grid).percentWidth = this.percentWidth;
			(component as components.primeFaces.Grid).percentHeight = this.percentHeight;

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
			var componentsArray:Array = [];
			var organizerItem:OrganizerItem;
			var element:IGetChildrenSurfaceComponent;
			var gridRow:GridRow;
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
			// parse back items inside gridRow
			function parseRowItems(grid:Grid, rowIndex:int):void
			{
				gridRow = grid.getElementAt(rowIndex) as GridRow;
				for (var col:int = 0; col < gridRow.numElements; col++)
				{
					gridCol = gridRow.getElementAt(col) as GridItem;
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
