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
package view.suportClasses
{
    import view.primeFaces.supportClasses.*;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import mx.containers.Grid;
    import mx.core.IVisualElement;
    import mx.core.IVisualElementContainer;
    
    import view.primeFaces.surfaceComponents.components.Div;
    import view.suportClasses.events.SurfaceComponentEvent;

    import flash.utils.getQualifiedClassName;

    public class GridBase extends Grid
    {
        protected static const MIN_COLUMN_COUNT:int = 1;
        protected static const MIN_ROW_COUNT:int = 1;

        protected var maxColumnCount:int = 12;
        protected var _columnBorderColor:String = "#7096ab";
		protected var _columnBorderAlpha:int = 1;
        private var columnBorderColorChanged:Boolean;
		private var columnBorderAlphaChanged:Boolean;

        protected var selectionChanged:Boolean;

        public function GridBase()
        {
            super();
        }

        public function set columnBorderColor(value:String):void
        {
            if (_columnBorderColor != value)
            {
                this._columnBorderColor = value;
                this.columnBorderColorChanged = true;

                this.invalidateDisplayList();
            }
        }
		
		public function set columnBorderAlpha(value:int):void
		{
			if (_columnBorderAlpha != value)
			{
				this._columnBorderAlpha = value;
				this.columnBorderAlphaChanged = true;
				
				this.invalidateDisplayList();
			}
		}

        protected var _selectedRow:int = -1;

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
                selectionChanged = true;

                invalidateProperties();

                dispatchEvent(new GridEvent(GridEvent.SELECTED_ROW_CHANGED, value));
            }
        }

        protected var _selectedColumn:int = -1;

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
                selectionChanged = true;

                invalidateProperties();

                dispatchEvent(new GridEvent(GridEvent.SELECTED_COLUMN_CHANGED, value));
            }
        }
		
		public function getNumRows():int
		{
			return this.numElements;
		}
		
		public function getNumColumns(row:int):int
		{
			if (row > (this.numElements - 1)) return -1;
			return (this.getElementAt(row) as IVisualElementContainer).numElements;
		}

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (columnBorderColorChanged || columnBorderAlphaChanged)
            {
                refreshColumnBorderColor();
            }
        }

        public function addRow():IVisualElement
        {
            var gridRow:GridRow = this.ensureCreateInitialRowWithColumn();
            var gridItem:GridItem = gridRow.getElementAt(0) as GridItem;
            var addedElements:Array = [gridItem.getElementAt(0)];

            dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentAdded, addedElements));

            this.selectedRow += 1;
            this.selectedColumn = 0;

            return gridRow;
        }

        public function removeRow(index:int, dispatchChange:Boolean=true):IVisualElement
        {
            if (this.numElements > MIN_ROW_COUNT)
            {
                var removedElement:GridRow = this.getElementAt(index) as GridRow;

                var removedItems:Array = [];
                var numRemovedElements:int = removedElement.numElements;
                for (var row:int = 0; row < numRemovedElements; row++)
                {
                    var gridItem:GridItem = removedElement.getElementAt(row) as GridItem;
                    var div:Div = gridItem.getElementAt(0) as Div;
                    div.removeEventListener(MouseEvent.ROLL_OVER, onDivRollOver);
                    div.removeEventListener(MouseEvent.ROLL_OUT, onDivRollOut);
                    div.removeEventListener(MouseEvent.CLICK, onDivClick);

                    removedItems.push(div);
                }

                removedElement = this.removeElement(removedElement) as GridRow;
                if (removedElement)
                {
                    dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentRemoved, removedItems));
                }

                var selRow:int = this.selectedRow - 1;
                this.selectedRow = selRow == -1 ? 0 : selRow;
                if (dispatchChange) dispatchEvent(new Event("itemRemoved"));

                return removedElement;
            }

            return null;
        }

        public function addColumn(rowIndex:int, dispatchChange:Boolean=true):GridItem
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            if (gridRow)
            {
                gridRow.percentWidth = gridRow.percentHeight = 100;

                var gridItem:GridItem = this.ensureCreateColumn(gridRow);
                var div:Div = gridItem.getElementAt(0) as Div;

                if (gridRow.numElements > this.selectedColumn + 1)
                {
                    this.selectedColumn += 1;
                }

                dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentAdded, [div]));
                if (dispatchChange) dispatchEvent(new Event("itemAdded"));

                return gridItem;
            }

            return null;
        }

        public function removeColumn(rowIndex:int, columnIndex:int, dispatchChange:Boolean=true):IVisualElement
        {
            var gridRow:GridRow = this.getElementAt(rowIndex) as GridRow;
            if (gridRow && gridRow.numElements > MIN_COLUMN_COUNT)
            {
                var removedColumn:IVisualElement = gridRow.removeElementAt(columnIndex);

                var gridItem:GridItem = removedColumn as GridItem;
                if (gridItem)
                {
                    var div:Div = gridItem.getElementAt(0) as Div;
                    div.removeEventListener(MouseEvent.ROLL_OVER, onDivRollOver);
                    div.removeEventListener(MouseEvent.ROLL_OUT, onDivRollOut);
                    div.removeEventListener(MouseEvent.CLICK, onDivClick);
                }

                var selColumn:int = this.selectedColumn - 1;
                this.selectedColumn = selColumn == -1 ? 0 : selColumn;

                if (dispatchChange) dispatchEvent(new Event("itemRemoved"));

                return removedColumn;
            }

            return null;
        }

        public function isEmpty():Boolean
        {
            var rowNumElements:int = this.numElements;
            for (var i:int = 0; i < rowNumElements; i++)
            {
                var gridRow:GridRow = this.getElementAt(i) as GridRow;
                var columnNumElements:int = gridRow.numElements;
                for (var j:int = 0; j < columnNumElements; j++)
                {
                    var gridItem:GridItem = gridRow.getElementAt(j) as GridItem;
                    var div:Div = gridItem.getElementAt(0) as Div;
                    if (div.numElements > 0)
                    {
                        return false;
                    }
                }
            }

            return true;
        }

        override public function addElement(element:IVisualElement):IVisualElement
        {
             var className:String = getQualifiedClassName(element);
                if (element is GridRow)
                {
                    //Alert.show("element is GridRow");
                    return super.addElement(element);
                }
                else
                {
                    

                    var gridRow:GridRow = this.getElementAt(selectedRow) as GridRow;
                    var gridItem:GridItem = gridRow.getElementAt(selectedColumn) as GridItem;
                  
                    if (gridItem.numElements > 0)
                    {
                        var div:Div = gridItem.getElementAt(0) as Div;
                        if (div)
                        {
                            return div.addElement(element);
                        }
                        else
                        {
                            return gridItem.addElement(element);
                        }
                    }
                    else
                    {
                        return gridItem.addElement(element);
                    }
                }
            
        }

        protected function ensureCreateColumn(row:GridRow):GridItem
        {
            var gridItem:GridItem = new GridItem();
            gridItem.percentWidth = gridItem.percentHeight = 100;

            var div:Div = new Div();
            div.percentWidth = div.percentHeight = 100;
            div.setStyle("borderColor", _columnBorderColor);
			div.setStyle("borderAlpha", _columnBorderAlpha);
            div.addEventListener(MouseEvent.ROLL_OVER, onDivRollOver);
            div.addEventListener(MouseEvent.ROLL_OUT, onDivRollOut);
            div.addEventListener(MouseEvent.CLICK, onDivClick);

            gridItem.addElement(div);
            row.addElement(gridItem);

            return gridItem;
        }

        protected function ensureCreateInitialRowWithColumn():GridRow
        {
            var gridRow:GridRow = new GridRow();
            gridRow.percentWidth = gridRow.percentHeight = 100;

            this.ensureCreateColumn(gridRow);
            this.addElement(gridRow);

            return gridRow;
        }

        protected function onDivRollOver(event:MouseEvent):void
        {
            var target:Div = event.currentTarget as Div;
            if (target)
            {
                if (!isDivSelected(target))
                {
                    target.setStyle("backgroundColor", this.getStyle("themeColor"));
                    target.setStyle("backgroundAlpha", 0.2);
                }
            }
        }

        protected function onDivRollOut(event:MouseEvent):void
        {
            var target:Div = event.currentTarget as Div;
            if (target)
            {
                if (!isDivSelected(target))
                {
                    target.setStyle("backgroundColor", "#FFFFFF");
                    target.setStyle("backgroundAlpha", 1);
                }
            }
        }

        protected function onDivClick(event:MouseEvent):void
        {
            var target:Div = event.currentTarget as Div;
            if (target)
            {
                if (!isDivSelected(target))
                {
                    resetSelectionColorForSelectedItem(this.selectedRow, this.selectedColumn);
                }

                var rowNumElements:int = this.numElements;
                for (var i:int = 0; i < rowNumElements; i++)
                {
                    var gridRow:GridRow = this.getElementAt(i) as GridRow;
                    var columnNumElements:int = gridRow.numElements;
                    for (var j:int = 0; j < columnNumElements; j++)
                    {
                        var gridItem:GridItem = gridRow.getElementAt(j) as GridItem;
                        var div:Div = gridItem.getElementAt(0) as Div;
                        if (target == div)
                        {
                            this.selectedRow = i;
                            this.selectedColumn = j;
                            break;
                        }
                    }
                }
            }
        }

        protected function isDivSelected(div:Div):Boolean
        {
            if (this.selectedRow == -1 || this.selectedRow == -1) return false;
            var selectedDiv:Div = getDiv(this.selectedRow, this.selectedColumn);

            return selectedDiv == div;
        }

        protected function getDiv(selectedRowIndex:int, selectedColumnIndex:int):Div
        {
            if (selectedRowIndex == -1 || selectedColumnIndex == -1) return null;
            if (selectedRowIndex >= this.numElements) return null;

            var gridRow:GridRow = this.getElementAt(selectedRowIndex) as GridRow;
            if (gridRow.numElements > selectedColumnIndex)
            {
                var gridItem:GridItem = gridRow.getElementAt(selectedColumnIndex) as GridItem;
                return gridItem.getElementAt(0) as Div;
            }

            return null;
        }

        private function refreshColumnBorderColor():void
        {
            for (var row:int = 0; row < this.numElements; row++)
            {
                var gridRow:GridRow = this.getElementAt(row) as GridRow;
                for (var col:int = 0; col < gridRow.numElements; col++)
                {
                    var gridItem:GridItem = gridRow.getElementAt(col) as GridItem;
                    var div:Div = gridItem.getElementAt(0) as Div;
                    div.setStyle("borderColor", _columnBorderColor);
					div.setStyle("borderAlpha", _columnBorderAlpha);
                }
            }
        }

        protected function resetSelectionColorForSelectedItem(selectedRowIndex:int, selectedColumnIndex:int):Div
        {
            var div:Div = getDiv(selectedRowIndex, selectedColumnIndex);
            if (div)
            {
                div.setStyle("backgroundColor", "#FFFFFF");
                div.setStyle("backgroundAlpha", 1);
            }

            return div;
        }
    }
}
