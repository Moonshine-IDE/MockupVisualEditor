package view.dominoFormBuilder.impl
{
	import flash.filesystem.File;
	
	import interfaces.IConverterLibraryBridge;
	
	import utils.MoonshineBridgeUtils;
	
	public class IConverterLibraryBridgeImp implements IConverterLibraryBridge
	{
		public function read(file:File):String
		{
			return MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.read(file);
		}
		
		public function readAsync(file:File, onSuccess:Function, onFault:Function=null):void
		{
			MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.readAsync(file, onSuccess, onFault);
		}
		
		public function getDominoFieldTemplateFile(path:String):File
		{
			return MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile(path);
		}
	}
}