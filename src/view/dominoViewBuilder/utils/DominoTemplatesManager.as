package view.dominoFormBuilder.utils
{
	import flash.filesystem.File;
	
	import utils.MoonshineBridgeUtils;

	public class DominoTemplatesManager
	{
		public static function getFormTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("form.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getFormParTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("form-par.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getTableTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("table.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getTableRowTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("table-row.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getTableCellTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("table-cell.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getFieldTemplate(type:String, multivalue:Boolean, editable:String):String
		{
			var fileName:String = "field_"+ type.toLowerCase() +"_";
			fileName += (multivalue ? "m" : "s") +"_";
			switch(editable)
			{
				case "Editable":
					fileName += "e";
					break;
				case "Computed":
					fileName += "c";
					break;
				case "Compute on compose":
					fileName += "cwc";
					break;
				case "Compute for display":
					fileName += "cfd";
					break;
			}
			
			// since we have file-access problem within library project
			// we'll request the file available in main application sandbox
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile(fileName +".dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getViewTemplate():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("view.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		public static function getViewColumn():String
		{
			var templateFile:File = MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.getDominoFieldTemplateFile("view-column.dxl");
			if (templateFile.exists)
			{
				return readAndReturnAsString(templateFile);
			}
			
			return null;
		}
		
		private static function readAndReturnAsString(path:File):String
		{
			return MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.read(path);
		}
	}
}