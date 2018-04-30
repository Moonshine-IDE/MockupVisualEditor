package view.suportClasses.events
{
    import flash.events.Event;

    import view.primeFaces.surfaceComponents.components.Div;

    public class SurfaceComponentEvent extends Event
    {
        public static const ComponentAdded:String = "componentAdded";
        public static const ComponentRemoved:String = "componentRemoved";

        private var _items:Array;

        public function SurfaceComponentEvent(type:String, items:Array)
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
