package view.primeFaces.surfaceComponents.components
{
	import view.interfaces.IMainApplication;

	public class MainApplication extends Container implements IMainApplication
	{
		public static const ELEMENT_NAME:String = "MainApplication";
		
		public function MainApplication()
		{
			super();

			this.setStyle("backgroundColor", "#FCFCFC");

			Container.ELEMENT_NAME = "MainApplication";
		}
	}
}