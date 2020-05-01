package utils
{
    import 	mx.utils.Base64Encoder;
    import  mx.utils.Base64Decoder;
    import  flash.utils.ByteArray;
    
    public class StringHelper
    {
        public function trim(str:String, char:String):String
        {
            return trimBack(trimFront(str, char), char);
        }

        public function trimFront(str:String, char:String):String
        {
            char = stringToCharacter(char);
            if (str.charAt(0) == char)
            {
                str = trimFront(str.substring(1), char);
            }
            return str;
        }

        public function trimBack(str:String, char:String):String
        {
            char = stringToCharacter(char);
            if (str.charAt(str.length - 1) == char)
            {
                str = trimBack(str.substring(0, str.length - 1), char);
            }
            return str;
        }

        public function stringToCharacter(str:String):String
        {
            if (str.length == 1)
            {
                return str;
            }
            return str.slice(0, 1);
        }

        public static function base64Encode(str:String, charset:String = "UTF-8"):String{
			if((str==null)){
				return "";
			}
			var base64:Base64Encoder = new Base64Encoder();
			base64.insertNewLines = false;
			var byte:ByteArray = new ByteArray();
			byte.writeMultiByte(str, charset);
			base64.encodeBytes(byte);
			return base64.toString();
		}
		
		public static function base64Decode(str:String, charset:String = "UTF-8"):String{
			if((str==null)){
				return "";
			}
			var base64:Base64Decoder = new Base64Decoder();
			base64.decode(str);
			var byteArray:ByteArray = base64.toByteArray();
			return byteArray.readMultiByte(byteArray.length, charset);;
		}
	

    }
}
