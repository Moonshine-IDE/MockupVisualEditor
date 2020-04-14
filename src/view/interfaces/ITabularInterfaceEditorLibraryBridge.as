package view.interfaces
{
	import spark.components.TitleWindow;
	
	import view.tabularInterface.DominoTabularForm;

	public interface ITabularInterfaceEditorLibraryBridge
	{
		function getTabularEditorInterfaceWrapper():DominoTabularForm;
		function getNewMoonshinePopup():TitleWindow;
	}
}