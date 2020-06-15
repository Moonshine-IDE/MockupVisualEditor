package view.suportClasses.events
{
    import flash.events.Event;

    public class VisualEditorEvent extends Event
    {
        public static const SAVE_CODE:String = "saveCode";
		public static const GENERATE_ROYALE_CRUD:String = "generateRoyaleCRUDApplication";

        public function VisualEditorEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new VisualEditorEvent(this.type);
        }
    }
}
