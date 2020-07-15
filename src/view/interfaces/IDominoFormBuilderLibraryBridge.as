package view.interfaces
{
	import flash.filesystem.File;
	
	import spark.components.TitleWindow;
	
	import view.dominoFormBuilder.DominoTabularForm;

	public interface IDominoFormBuilderLibraryBridge
	{
		function getTabularEditorInterfaceWrapper():DominoTabularForm;
		function getNewMoonshinePopup():TitleWindow;
		function read(file:File):String;
		function readAsync(file:File, onSuccess:Function, onFault:Function=null):void;
		function getDominoFieldTemplateFile(path:String):File;
	}
}