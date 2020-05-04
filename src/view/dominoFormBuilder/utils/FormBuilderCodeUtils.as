package view.dominoFormBuilder.utils
{
	import flash.filesystem.File;
	
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
			XML.ignoreWhitespace = true;
			
			var form:String = DominoTemplatesManager.getFormTemplate();
			var par:String = DominoTemplatesManager.getFormParTemplate();
			
			var formBody:String = par.replace(/%value%/i, formObject.viewName);
			formBody += formObject.toCode();
			
			form = form.replace(/%formname%/i, formObject.formName);
			form = form.replace(/%frombody%/i, formBody);
			
			return XML(form);
		}
		
		public static function toViewCode(formObject:DominoFormVO):XML
		{
			XML.ignoreWhitespace = true;
			
			var view:String = DominoTemplatesManager.getViewTemplate();
			view = view.replace(/%viewname%/i, formObject.viewName);
			view = view.replace(/%formname%/i, formObject.formName);
			view = view.replace(/%columns%/i, formObject.toViewColumnsCode());
			
			return XML(view);
		}
	}
}