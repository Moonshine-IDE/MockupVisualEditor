package view.dominoFormBuilder.utils
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import view.dominoFormBuilder.vo.DominoFormVO;

	public class DominoFormBuilderExporter
	{
		public static function writeToFile(file:File, formObject:DominoFormVO):void
		{
			if (!file.exists)
			{
				file = createNewFile(file.nativePath);
			}
			
			var data:XML = <root/>;
			XML.ignoreComments = false;
			
			data.appendChild(formObject.toXML());
			
			var tempFileStream:FileStream = new FileStream();
			tempFileStream.open(file, FileMode.WRITE);
			tempFileStream.writeUTFBytes("<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"+ data.toXMLString());
			tempFileStream.close();
		}
		
		private static function createNewFile(filePath:String):File
		{
			var tempFile:File = new File(filePath);
			if (!tempFile.exists)
			{
				var tmpValue:String = '<?xml version="1.0" encoding="utf-8"?>' +
					'<root><form/></root>';
				var tempFileStream:FileStream = new FileStream();
				tempFileStream.open(tempFile, FileMode.WRITE);
				tempFileStream.writeUTFBytes(tmpValue);
				tempFileStream.close();
			}
			
			return tempFile;
		}
	}
}