package view.dominoFormBuilder.utils
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import view.dominoFormBuilder.vo.DominoFormVO;

	public class DominoFormBuilderImporter
	{
		public static function loadFromFile(path:File, toFormObject:DominoFormVO, onSuccess:Function=null):void
		{
			if (path.exists)
			{
				var fileXML:XML;
				var stream:FileStream = new FileStream();
				stream.open(path, FileMode.READ);
				fileXML = XML(stream.readUTFBytes(stream.bytesAvailable));
				stream.close();
				
				toFormObject.fromXML(fileXML, onSuccess);
			}
			else if (onSuccess != null)
			{
				onSuccess();
			}
		}
	}
}