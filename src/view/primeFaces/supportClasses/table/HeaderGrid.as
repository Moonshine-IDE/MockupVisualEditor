package view.primeFaces.supportClasses.table
{
    import mx.containers.GridItem;
    import mx.containers.GridRow;
    import mx.core.IVisualElement;

    import spark.components.Label;

    import view.primeFaces.supportClasses.*;
    import view.primeFaces.surfaceComponents.components.Div;

    public class HeaderGrid extends GridBase
    {
        public function HeaderGrid()
        {
            super();

            this.setStyle("borderVisible", false);
            this.setStyle("verticalGap", -2);
            this.setStyle("horizontalGap", -2);
        }

        override public function isEmpty():Boolean
        {
            return false;
        }

        override public function addRow():IVisualElement
        {
            var rowItem:GridRow = super.addRow() as GridRow;
            var colItem:GridItem = rowItem.getElementAt(0) as GridItem;
            var div:Div = colItem.getElementAt(0) as Div;

            addLabelToCell(div);
            
            return rowItem;
        }

        override public function addColumn(rowIndex:int):GridItem
        {
            var gridItem:GridItem = super.addColumn(rowIndex);
            var div:Div = gridItem.getElementAt(0) as Div;

            addLabelToCell(div);

            return gridItem;
        }

        private function addLabelToCell(div:Div):void
        {
            var lbl:Label = new Label();
            lbl.percentWidth = 100;
            lbl.text = "Title";

            div.addElement(lbl);
        }
    }
}
