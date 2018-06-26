package utils
{
    import mx.collections.ArrayCollection;
	
	import view.VisualEditor;
	import view.interfaces.IVisualEditorLibraryBridge;

	public class MoonshineBridgeUtils
	{
		public static var currentFilePath:String;
		public static var moonshineBridge:IVisualEditorLibraryBridge;

        private static var _filesList:ArrayCollection;

		public static function get filesList():ArrayCollection
		{
			if (_filesList)
            {
                _filesList.refresh();
            }

			return _filesList;
		}

		public static function onXHtmlFilesUpdated(value:ArrayCollection):void
		{
			if (_filesList != value)
			{
                _filesList = value;
				if (value)
				{
					value.filterFunction = function(item:Object):Boolean {
						var path:String = item.resourcePathWithoutRoot.replace(item.resourceExtension, "xml");
						return currentFilePath.indexOf(path) == -1;
                    }
				}
			}
		}
		
		public static function getVisualEditorComponent():VisualEditor
		{
			return moonshineBridge.getVisualEditorComponent();
		}
	}
}