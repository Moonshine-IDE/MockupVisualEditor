package view.dominoFormBuilder.utils
{
	import flash.filesystem.File;
	
	import utils.MainApplicationCodeUtils;
	import utils.MoonshineBridgeUtils;
	
	import view.dominoFormBuilder.vo.DominoFormVO;

	public class FormBuilderCodeUtils
	{
		public static function loadFromFile(path:File, toFormObject:DominoFormVO, onSuccess:Function=null):void
		{
			if (path.exists)
			{
				var fileXML:XML = XML(MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.read(path));
				toFormObject.fromXML(fileXML, onSuccess);
			}
			else if (onSuccess != null)
			{
				onSuccess();
			}
		}
		
		public static function toDominoCode(formObject:DominoFormVO):XML
		{
			// @note
			// conversion logic as per EditingSurfaceWriter
			var xml:XML = MainApplicationCodeUtils.getDominoParentContent(formObject.formName);
			var mainContainer:XML = MainApplicationCodeUtils.getDominMainContainerTag(xml);
			
			XML.ignoreComments = false;
			var code:XML = formObject.toCode();
			
			// patch-fix?
			if (code.name() == "div")
			{
				code.setName("richtext");
			}
			
			if (mainContainer)
			{
				mainContainer.appendChild(code); // What 'mainContainer' does finally!?
			}
			else
			{
				xml.appendChild(code);
			}
			
			return MainApplicationCodeUtils.fixDominField(xml);
		}
	}
}