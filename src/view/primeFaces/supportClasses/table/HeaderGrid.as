////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2016-present Prominic.NET, Inc.
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
    import view.primeFaces.supportClasses.GridItem;
    import view.primeFaces.supportClasses.GridRow;
    import mx.core.IVisualElement;
    
    import spark.components.Label;
    
    import view.suportClasses.GridBase;
    import view.primeFaces.surfaceComponents.components.Div;

    public class HeaderGrid extends GridBase
    {
		public var updatePropertyChangeReference:Function;
		
        public function HeaderGrid()
        {
            super();

            this.setStyle("borderVisible", false);
            this.setStyle("verticalGap", -2);
            this.setStyle("horizontalGap", -2);
        }

        public function setTitle(title:String, selectedRowIndex:int = -1, selectedColumnIndex:int = -1):void
        {
            if (selectedRowIndex == -1)
            {
                selectedRowIndex = this.selectedRow;
            }

            if (selectedColumnIndex == -1)
            {
                selectedColumnIndex = this.selectedColumn;
            }
			
			
            var lbl:Label = getSelectedLabel(selectedRowIndex, selectedColumnIndex);
			if (lbl.text != title && updatePropertyChangeReference != null) updatePropertyChangeReference("titleChanged", {value:lbl.text, parent:lbl, index:selectedColumn}, {value:title, parent:lbl, index:selectedColumn});
            lbl.text = title;
        }

        public function getTitle(selectedRowIndex:int = -1, selectedColumnIndex:int = -1):String
        {
            if (selectedRowIndex == -1)
            {
                selectedRowIndex = this.selectedRow;
            }

            if (selectedColumnIndex == -1)
            {
                selectedColumnIndex = this.selectedColumn;
            }

            return getSelectedLabel(selectedRowIndex, selectedColumnIndex).text;
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

        override public function addColumn(rowIndex:int, dispatchChange:Boolean=true):GridItem
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

        private function getSelectedLabel(selectedRowIndex:int, selectedColumnIndex:int):Label
        {
            var rowItem:GridRow = this.getElementAt(selectedRowIndex) as GridRow;
            var colItem:GridItem = rowItem.getElementAt(selectedColumnIndex) as GridItem;

            var div:Div = colItem.getElementAt(0) as Div;
            return div.getElementAt(0) as Label;
        }
    }
}
