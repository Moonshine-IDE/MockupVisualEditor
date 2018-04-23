package view.primeFaces.supportClasses.events
{
    import flash.events.Event;

    import view.primeFaces.surfaceComponents.components.Div;

    public class GridEvent extends Event
    {
        public static const GridElementAdded:String = "gridElementAdded";
        public static const GridElementRemoved:String = "gridElementRemoved";

        private var _items:Array;

        public function GridEvent(type:String, items:Array)
        {
            super(type, false, false);

            this._items = items;
        }

        public function get items():Array
        {
            return this._items;
        }
    }
}
