package view.interfaces
{
	import spark.components.TitleWindow;
	
	import view.dominoFormBuilder.DominoTabularForm;

	public interface IDominoFormBuilderLibraryBridge
	{
		function getTabularEditorInterfaceWrapper():DominoTabularForm;
		function getNewMoonshinePopup():TitleWindow;
	}
}