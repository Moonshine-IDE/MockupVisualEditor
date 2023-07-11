/**
 * https://github.com/rbrn/apache-flex-drag-drop-columndatagrid/tree/master
 */

package view.domino.viewEditor.grid
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.geom.Point;
    import flash.utils.Timer;

    import mx.core.DragSource;
    import mx.core.IFactory;
    import mx.core.IFlexDisplayObject;
    import mx.core.UIComponent;
    import mx.events.DragEvent;
    import mx.events.FlexEvent;
    import mx.managers.DragManager;

    import spark.components.DataGrid;
    import spark.components.gridClasses.GridColumn;
    import spark.components.gridClasses.IGridItemRenderer;
    import spark.events.GridEvent;
    import view.suportClasses.events.DominoViewColumnDragDropCompleteEvent;

    public class DragAndDropGrid extends DataGrid
    {

        private var dragColumn:GridColumn;
        private var dropIndex:int;
        private var columnMoveDropIndicator:DisplayObject;
        private var lastXMousePosition:int;
        private var dragTimer:Timer = new Timer(100, 1000);

        /**
         * horizontal scroll position back variable
         * after drop column the scroll position is lost
         * and is set back by setScrollBackWhereItWas in the callLater method trigger
         */

        protected var _horizontalScrollBeforeDrop:int;

        public function DragAndDropGrid()
        {
            super();
            this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(event:FlexEvent):void
        {
            addEventListener(GridEvent.GRID_MOUSE_DRAG, gridMouseDragHandler);
        }

        /**
         *  handler the column header dragging
         */
        protected function gridMouseDragHandler(event:GridEvent):void
        {
            if (DragManager.isDragging)
                return;
            if (isDraggingColumn(event))
            {
                startColumnDragDrop(event);
            }
        }

        /**
         * Verifies if the dragging item is a column and not a cell
         *
         * @param event GridEvent
         * @return True if is a GridColumn, false otherwise
         */
        private function isDraggingColumn(event:GridEvent):Boolean
        {
            return event.column && event.rowIndex == -1;
        }

        private function startColumnDragDrop(event:GridEvent):void
        {
            dragColumn = event.column;
            var ds:DragSource = new DragSource();
            ds.addData(dragColumn, "spark.components.gridClasses.GridColumn");
            var factory:IFactory = dragColumn.headerRenderer;
            if (!factory)
                factory = this.columnHeaderGroup.headerRenderer;
            var renderer:IGridItemRenderer = IGridItemRenderer(factory.newInstance());
            renderer.visible = true;
            renderer.column = dragColumn;
            renderer.label = dragColumn.headerText;
            var currentRenderer:IGridItemRenderer = this.columnHeaderGroup.getHeaderRendererAt(event.columnIndex);
            renderer.width = currentRenderer.width;
            renderer.height = currentRenderer.height;
            renderer.prepare(false);
            var pt:Point = new Point(0, 0);
            pt = DisplayObject(currentRenderer).localToGlobal(pt);
            pt = DisplayObject(this).globalToLocal(pt);
            DragManager.doDrag(this as UIComponent, ds, event, renderer as IFlexDisplayObject, -pt.x, -pt.y);
            renderer.owner = this;

            this.columnHeaderGroup.addEventListener(DragEvent.DRAG_ENTER, columnDragEnterHandler);
            this.columnHeaderGroup.addEventListener(DragEvent.DRAG_COMPLETE, columnDragCompleteHandler);
            this.addEventListener(DragEvent.DRAG_COMPLETE, columnDragCompleteHandler);
            dragTimer.addEventListener(TimerEvent.TIMER, timerActivityHandler);
            dragTimer.start();

        }

        protected function timerActivityHandler(event:TimerEvent):void
        {
            if (stage.mouseX < 130)
            {
                if (stage.mouseX > 90)
                {
                    grid.horizontalScrollPosition -= 150;
                }
                else
                    grid.horizontalScrollPosition -= 90;
                this.invalidateDisplayList();
            }
            else if (stage.mouseX > stage.stageWidth - 130)
            {
                if (stage.mouseX > stage.stageWidth - 90)
                {
                    grid.horizontalScrollPosition += 150;
                }
                else
                    grid.horizontalScrollPosition += 90;
            }
            ;
        }

        private function stopDragTimer(str:String = null):void
        {
            dragTimer.stop();
        }

        /**
         *
         * @param event
         * Stops the scrolling timer when a column gets dropped on the data grid
         *
         */
        private function parentGridDragCompleteHandler(event:Event):void
        {
            stopDragTimer("parentGridDragCompleteHandler");
        }

        private function columnDragEnterHandler(event:DragEvent):void
        {
            if (event.dragSource.hasFormat("spark.components.gridClasses.GridColumn"))
            {
                this.columnHeaderGroup.addEventListener(DragEvent.DRAG_OVER, columnDragOverHandler);
                this.columnHeaderGroup.addEventListener(DragEvent.DRAG_EXIT, columnDragExitHandler);
                this.columnHeaderGroup.addEventListener(DragEvent.DRAG_DROP, columnDragDropHandler);
            }
            // remove this condition if you want cross table drag and drop
            if (DataGrid(event.dragInitiator).columnHeaderGroup == this.columnHeaderGroup)
            {
                showColumnDropFeedback(event);
                DragManager.acceptDragDrop(this.columnHeaderGroup);
            }
        }

        private function columnDragOverHandler(event:DragEvent):void
        {
            showColumnDropFeedback(event);
            DragManager.acceptDragDrop(this.columnHeaderGroup);
        }

        private function columnDragExitHandler(event:DragEvent):void
        {
            this.columnHeaderGroup.removeEventListener(DragEvent.DRAG_OVER, columnDragOverHandler);
            this.columnHeaderGroup.removeEventListener(DragEvent.DRAG_EXIT, columnDragExitHandler);
            this.columnHeaderGroup.removeEventListener(DragEvent.DRAG_DROP, columnDragDropHandler);
            cleanUpDropIndicator();
        }

        private function columnDragDropHandler(event:DragEvent):void
        {
            this.columnHeaderGroup.removeEventListener(DragEvent.DRAG_OVER, columnDragOverHandler);
            this.columnHeaderGroup.removeEventListener(DragEvent.DRAG_EXIT, columnDragExitHandler);
            this.columnHeaderGroup.removeEventListener(DragEvent.DRAG_DROP, columnDragDropHandler);
            dropColumn(event);
        }

        private function columnDragCompleteHandler(event:DragEvent):void
        {
            this.columnHeaderGroup.removeEventListener(DragEvent.DRAG_ENTER, columnDragEnterHandler);
            cleanUpDropIndicator();
            stopDragTimer("columndragcomplete");
        }

        private function cleanUpDropIndicator():void
        {
            if (columnMoveDropIndicator)
            {
                dropIndex == -1;
                this.columnHeaderGroup.overlay.removeDisplayObject(columnMoveDropIndicator);
                columnMoveDropIndicator = null;
            }

        }

        private function showColumnDropFeedback(event:DragEvent):void
        {
            var pt:Point = new Point(event.stageX, event.stageY);
            pt = this.columnHeaderGroup.globalToLocal(pt);
            var newDropIndex:int = this.columnHeaderGroup.getHeaderIndexAt(pt.x, pt.y);
            if (newDropIndex != -1)
            {
                var renderer:IGridItemRenderer = this.columnHeaderGroup.getHeaderRendererAt(newDropIndex);
                if (!columnMoveDropIndicator)
                {
                    columnMoveDropIndicator = new DragDropIndicator;
                    this.columnHeaderGroup.overlay.addDisplayObject(columnMoveDropIndicator);
                }
                if (pt.x < renderer.x + renderer.width / 2)
                    columnMoveDropIndicator.x = renderer.x - columnMoveDropIndicator.width / 2;
                else
                {
                    columnMoveDropIndicator.x = renderer.x + renderer.width - columnMoveDropIndicator.width / 2;
                    newDropIndex++;
                }
                dropIndex = newDropIndex;
            }
            else
            {
                cleanUpDropIndicator();
            }
        }

        /**
         *
         * @param event
         * Backup the horizontalScrollPosition
         */
        protected function saveScrollPositionForCallLater(event:DragEvent):void
        {
            _horizontalScrollBeforeDrop = this.grid.horizontalScrollPosition;

        }

        /**
         * Sets the scroll to the initial value
         * before the columnDrop as it looses it during the reordering
         */
        protected function setScrollBackWhereItWas():void
        {
            this.grid.horizontalScrollPosition = _horizontalScrollBeforeDrop;
        }

        private function dropColumn(event:DragEvent):void
        {
            if (dropIndex != dragColumn.columnIndex)
            {
                var oldIndex:int = dragColumn.columnIndex;
                this.columns.removeItemAt(dragColumn.columnIndex);
                if (dropIndex > oldIndex)
                    dropIndex--;
                this.columns.addItemAt(dragColumn, dropIndex);

                saveScrollPositionForCallLater(event);
                callLater(setScrollBackWhereItWas);
            }
            cleanUpDropIndicator();
            stopDragTimer("dropColumn");

            //action 
            this.dispatchEvent(new DominoViewColumnDragDropCompleteEvent(DominoViewColumnDragDropCompleteEvent.COLUMN_DROP_COMPLETE,true, true) );

        }

        /**
         *  @private
         *  Used to sort the selected indices during drag and drop operations.
         */
        private function compareValues(a:int, b:int):int
        {
            return a - b;
        }

        /**
         *  @private
         */
        private function copySelectedItemsForDragDrop():Vector.<Object>
        {
            // Copy the vector so that we don't modify the original
            // since selectedIndices returns a reference.
            var draggedIndices:Vector.<int> = this.selectedIndices.slice(0, this.selectedIndices.length);
            var result:Vector.<Object> = new Vector.<Object>(draggedIndices.length);

            // Sort in the order of the data source
            draggedIndices.sort(compareValues);

            // Copy the items
            var count:int = draggedIndices.length;
            for (var i:int = 0; i < count; i++)
                result[i] = this.dataProvider.getItemAt(draggedIndices[i]);
            return result;
        }
    }
}

import spark.components.Group;

class DragDropIndicator extends Group
{
    /*
     * Default constructor for the drop indicator
     */
    public function DragDropIndicator()
    {
        this.graphics.beginFill(0);
        this.graphics.drawRect(0, 0, 4, 20);
        this.graphics.endFill();
        this.width = 4;
    }
}