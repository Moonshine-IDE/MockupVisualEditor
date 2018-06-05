package view.interfaces
{
	import view.VisualEditor;

	// place all methods to communicate with Moonshine
	public interface IVisualEditorLibraryBridge
	{
		function getXhtmlFileUpdates(updateHandler:Function=null):void;
		function openXhtmlFile(path:String):void;
		function getVisualEditorComponent():VisualEditor;
		function getCustomTooltipFunction():Function;
		function getPositionTooltipFunction():Function;
	}
}