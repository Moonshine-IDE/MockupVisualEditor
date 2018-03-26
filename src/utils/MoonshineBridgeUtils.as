package utils
{
	import mx.collections.IList;
	
	import view.interfaces.IVisualEditorLibraryBridge;

	public class MoonshineBridgeUtils
	{
		public static var filesList:IList;
		public static var moonshineBridge:IVisualEditorLibraryBridge;
		
		public static function onXHtmlFilesUpdated(value:IList):void
		{
			filesList = value;
		}
	}
}