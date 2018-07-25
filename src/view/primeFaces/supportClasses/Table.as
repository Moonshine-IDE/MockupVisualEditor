package view.primeFaces.supportClasses
{
    import mx.containers.GridRow;

    import view.primeFaces.surfaceComponents.components.Container;

    public class Table extends Container
	{
		private var header:GridBase;
		private var body:GridBase;
		
		public function Table()
		{
            super.direction = ContainerDirection.VERTICAL_LAYOUT;
		}
		
		override public function set direction(value:String):void { }
		override public function set wrap(value:Boolean):void { }
		override public function set gap(value:int):void { }
		override public function set verticalAlign(value:String):void { }
		override public function set horizontalAlign(value:String):void { }
		
		private var _headerRowCount:int;
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
		
		private var _columnCount:int;
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

        private var _rowCount:int;
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

		override protected function createChildren():void
		{
			super.createChildren();

			this.header = new GridBase();
			this.header.setStyle("verticalGap", 0);
            this.header.setStyle("horizontalGap", 0);
			this.header.percentWidth = 100;
			this.header.percentHeight = Number.NaN;

			this.addElement(header);
			
			this.body = new GridBase();
            this.body.setStyle("verticalGap", 0);
            this.body.setStyle("horizontalGap", 0);
            this.body.percentHeight = this.body.percentWidth = 100;
			this.addElement(body);

            headerRowCount = 1;
			columnCount = 1;
			rowCount = 1;
		}

        override protected function commitProperties():void
        {
			super.commitProperties();

			if (header && headerRowCountChanged)
			{
                this.headerRowCountChanged = false;

				addHeaders();
			}

			if (header && headerHeightChanged)
			{
				this.headerHeightChanged = false;

				updateHeadersHeight();
			}

			if (body && columnCountChanged)
			{
				this.columnCountChanged = false;

				addRowsWithColumnsToBody();
			}
        }

        private function addRowsWithColumnsToBody():void
        {
			this.body.removeAllElements();

			for (var i:int = 0; i < this.rowCount; i++)
            {
                var gridRow:GridRow = this.body.addRow() as GridRow;
				if (columnCount > 1)
                {
                    for (var j:int = 0; j < columnCount; j++)
                    {
                        this.body.addColumn(this.body.selectedRow);
                    }
                }
            }
        }

        private function addHeaders():void
        {
            for (var i:int = 0; i < this.headerRowCount; i++)
            {
                var gridRow:GridRow = this.header.addRow() as GridRow;
                gridRow.percentHeight = Number.NaN;
				gridRow.percentWidth = 100;
                gridRow.height = this.headerHeight;
            }
        }

        private function updateHeadersHeight():void
        {
            for (var i:int = 0; i < this.headerRowCount; i++)
            {
                var gridRow:GridRow = this.header.getElementAt(i) as GridRow;
                gridRow.percentHeight = Number.NaN;
                gridRow.percentWidth = 100;
                gridRow.height = this.headerHeight;
            }
        }
    }
}