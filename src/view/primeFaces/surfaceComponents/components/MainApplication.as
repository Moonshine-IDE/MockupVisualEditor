package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import view.interfaces.IMainApplication;
    import view.interfaces.INonDeletableSurfaceComponent;
    import view.primeFaces.propertyEditors.WindowPropertyEditor;

    public class MainApplication extends Container implements INonDeletableSurfaceComponent, IMainApplication
	{
		public static const ELEMENT_NAME:String = "MainApplication";
		
		public function MainApplication()
		{
			super();

			this.setStyle("backgroundColor", "#FCFCFC");

			Container.ELEMENT_NAME = "MainApplication";
		}

        override public function get propertyEditorClass():Class
        {
            return WindowPropertyEditor;
        }

        private var _title:String;
        public function get title():String
        {
            return _title;
        }

        public function set title(value:String):void
        {
            if (_title != value)
            {
                _title = value;
                dispatchEvent(new Event("titleChanged"));
            }
        }
    }
}