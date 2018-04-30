package view.interfaces
{
	// place all methods to communicate with Moonshine
	public interface IVisualEditorLibraryBridge
	{
		function getXhtmlFileUpdates(updateHandler:Function=null):void;
		function openXhtmlFile(path:String):void;
	}
}