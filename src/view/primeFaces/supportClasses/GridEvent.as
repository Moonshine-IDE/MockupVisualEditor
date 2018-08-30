package view.primeFaces.supportClasses
{
    import flash.events.Event;

    public class GridEvent extends Event
    {
        public static const SELECTED_COLUMN_CHANGED:String = "selectedColumnChanged";
        public static const SELECTED_ROW_CHANGED:String = "selectedRowChanged";

        private var _selectedIndex:int;

        public function GridEvent(type:String, selectedIndex:int)
        {
            super(type);

            this._selectedIndex = selectedIndex;
        }

        public function get selectedIndex():int
        {
            return _selectedIndex;
        }

        override public function clone():Event
        {
            return new GridEvent(this.type, this.selectedIndex);
        }
    }
}
