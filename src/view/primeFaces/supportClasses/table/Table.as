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
package view.primeFaces.supportClasses.table
{
    import mx.containers.GridItem;
    import mx.containers.GridRow;
    import mx.core.IVisualElement;

    import view.primeFaces.supportClasses.Container;
    import view.primeFaces.supportClasses.ContainerDirection;
    import view.suportClasses.GridBase;
    import view.primeFaces.supportClasses.skins.OneSideBorderContainerSkin;
    import view.primeFaces.surfaceComponents.components.Div;

    public class Table extends Container
	{
		public function Table()
		{
            super.direction = ContainerDirection.VERTICAL_LAYOUT;

            this.headerRowCount = 1;
            this.rowCount = 1;
            this.columnCount = 1;
		}

		private var bordersChanged:Boolean;

		override public function set direction(value:String):void { }
		override public function set wrap(value:Boolean):void { }
		override public function set gap(value:int):void { }
		override public function set verticalAlign(value:String):void { }
		override public function set horizontalAlign(value:String):void { }

        private var _header:HeaderGrid;
        public function get header():HeaderGrid
        {
            return _header;
        }

        private var _body:BodyGrid;
        public function get body():BodyGrid
        {
            return _body;
        }

        protected var _headerRowCount:int = -1;
		private var headerRowCountChanged:Boolean;
		
		public function get headerRowCount():int
		{
			return _headerRowCount;
		}
		
		public function set headerRowCount(value:int):void
		{
			if (_headerRowCount != value)
			{
				_headerRowCount = value;
				
				this.headerRowCountChanged = true;
				this.invalidateProperties();
			}
		}
		
		private var _headerRowTitles:Array;
		protected function get headerRowTitles():Array
		{
			return _headerRowTitles;
		}
		protected function set headerRowTitles(value:Array):void
		{
			_headerRowTitles = value;
		}
		
		protected var _columnCount:int;
		private var columnCountChanged:Boolean;

		public function get columnCount():int
		{
			return _columnCount;
		}
		
		public function set columnCount(value:int):void
		{
			if (_columnCount != value)
			{
				_columnCount = value;
				
				this.columnCountChanged = true;
				this.invalidateProperties();
			}
		}

        protected var _rowCount:int;
        private var rowCountChanged:Boolean;

        public function get rowCount():int
        {
            return _rowCount;
        }

        public function set rowCount(value:int):void
        {
            if (_rowCount != value)
            {
                _rowCount = value;

                this.rowCountChanged = true;
                this.invalidateProperties();
            }
        }

		private var _headerHeight:Number = 30;
		private var headerHeightChanged:Boolean;

		public function get headerHeight():Number
		{
			return _headerHeight;
		}

		public function set headerHeight(value:Number):void
		{
			if (_headerHeight != value)
			{
				_headerHeight = value;
				headerRowCountChanged = true;

				this.invalidateProperties();
			}
		}

		public function get hasHeader():Boolean
		{
			return this.headerRowCount > 0;
		}

		public function invalidateBorders():void
		{
			bordersChanged = true;
			this.invalidateDisplayList();
		}

        override protected function createChildren():void
		{
			super.createChildren();

			if (!_header)
            {
                this._header = new HeaderGrid();
				this._header.updatePropertyChangeReference = this.updatePropertyChangeReference;
                this._header.columnBorderColor = "#000000";
                this._header.percentWidth = 100;
                this._header.percentHeight = Number.NaN;
				this._header.visible = this._header.includeInLayout = false;

                this.addElement(_header);
            }

			if (!_body)
            {
                this._body = new BodyGrid();
                this._body.columnBorderColor = "#000000";
                this._body.percentHeight = this._body.percentWidth = 100;

                this.addElement(_body);
            }
		}

        override public function addElement(element:IVisualElement):IVisualElement
        {
			if (element is HeaderGrid || element is BodyGrid)
            {
                return super.addElement(element);
            }
			else
			{
				return this._body.addElement(element);
			}
        }

        override protected function commitProperties():void
        {
			super.commitProperties();

			if (_header && headerRowCountChanged)
			{
                this.headerRowCountChanged = false;

				addHeaders();
                drawHeaderBorders();
			}

			if (_header && headerHeightChanged)
			{
				this.headerHeightChanged = false;

				updateHeadersHeight();
			}

			if (_body && columnCountChanged)
			{
				this.columnCountChanged = false;

				addRowsWithColumnsToBody();
                drawBodyBorders();
			}
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

			if (bordersChanged)
			{
				drawHeaderBorders();
				drawBodyBorders();

				bordersChanged = false;
			}
        }

        private function drawHeaderBorders():void
        {
			var row:int;
			var col:int;

            for (row = 0; row < this.headerRowCount; row++)
            {
                var gridRow:GridRow = _header.getElementAt(row) as GridRow;

				var gridRowCount:int = gridRow.numElements;
				var itemLastColIndex:int = gridRowCount - 1;
                for (col = 0; col < gridRowCount; col++)
                {
					var gridItem:GridItem = gridRow.getElementAt(col) as GridItem;
					var div:Div = gridItem.getElementAt(0) as Div;
					div.setStyle("borderTopVisible", true);
					div.setStyle("borderLeftVisible", true);
					div.setStyle("borderBottomVisible", false);
					div.setStyle("borderRightVisible", itemLastColIndex == col);

                    div.invalidateSkinState();
                }
            }
        }

        private function drawBodyBorders():void
        {
            var row:int;
            var col:int;
			var rowCount:int = this._body.numElements;
			var lastRowIndex:int = rowCount - 1;

            for (row = 0; row < rowCount; row++)
            {
                var gridRow:GridRow = _body.getElementAt(row) as GridRow;

                var gridColCount:int = gridRow.numElements;
                var itemLastColIndex:int = gridColCount - 1;
                for (col = 0; col < gridColCount; col++)
                {
                    var gridItem:GridItem = gridRow.getElementAt(col) as GridItem;
                    var div:Div = gridItem.getElementAt(0) as Div;
                    div.setStyle("borderTopVisible", true);
                    div.setStyle("borderBottomVisible", lastRowIndex == row);
                    div.setStyle("borderLeftVisible", true);
					div.setStyle("borderRightVisible", itemLastColIndex == col);

					div.invalidateSkinState();
                }
            }
        }

        protected function addRowsWithColumnsToBody():void
        {
			this.body.removeAllElements();

			for (var i:int = 0; i < this.rowCount; i++)
            {
                this.body.addRow();
                addColumnToRow(this._body, i, columnCount - 1);
            }
        }

        private function addHeaders():void
        {
			this.header.removeAllElements();
			this.header.visible = this.header.includeInLayout = this.hasHeader;

            for (var i:int = 0; i < this.headerRowCount; i++)
            {
                var gridRow:GridRow = this.header.addRow() as GridRow;
                gridRow.percentHeight = Number.NaN;
				gridRow.percentWidth = 100;
                gridRow.height = this.headerHeight;

                addColumnToRow(this.header, i, columnCount - 1);
            }
			
			// once the header columns created by their own way
			// update the title values by those loaded during
			// editor loads XML
			updateHeaderTitlesFromXML();
        }
		
		private function updateHeaderTitlesFromXML():void
		{
			if (!headerRowTitles) return;
			
			for (var row:int = 0; row < headerRowCount; row++)
			{
				for (var col:int = 0; col < columnCount; col++)
				{
					this.header.setTitle(headerRowTitles[row][col], row, col);
				}
			}
			
			headerRowTitles = null;
		}

        private function updateHeadersHeight():void
        {
            for (var i:int = 0; i < this.headerRowCount; i++)
            {
                var gridRow:GridRow = this._header.getElementAt(i) as GridRow;
                gridRow.percentHeight = Number.NaN;
                gridRow.percentWidth = 100;
                gridRow.height = this.headerHeight;
            }
        }

		protected function addColumnToRow(grid:GridBase, rowIndex:int, rowColumnCount:int = 1):Array
		{
			var gridRow:GridRow = grid.getElementAt(rowIndex) as GridRow;
            var gridItem:GridItem = gridRow.getElementAt(0) as GridItem;
			setDivSkin(gridItem);
			
			var tmpArr:Array = [];
			for (var i:int = 0; i < rowColumnCount; i++)
			{
				gridItem = grid.addColumn(rowIndex);
				setDivSkin(gridItem);
				
				tmpArr.push({object:gridItem, parent:gridRow});
			}
			
			return tmpArr;
		}

        private function setDivSkin(gridItem:GridItem):void
        {
            var div:Div = gridItem.getElementAt(0) as Div;
            div.setStyle("skinClass", OneSideBorderContainerSkin);
        }
    }
}