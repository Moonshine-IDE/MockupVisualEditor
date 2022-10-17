////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2016-present Prominic.NET, Inc.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the Server Side Public License, version 1,
//  as published by MongoDB, Inc.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  Server Side Public License for more details.
//
//  You should have received a copy of the Server Side Public License
//  along with this program. If not, see
//
//  http://www.mongodb.com/licensing/server-side-public-license
//
//  As a special exception, the copyright holders give permission to link the
//  code of portions of this program with the OpenSSL library under certain
//  conditions as described in each individual source file and distribute
//  linked combinations including the program with the OpenSSL library. You
//  must comply with the Server Side Public License in all respects for
//  all of the code used other than as permitted herein. If you modify file(s)
//  with this exception, you may extend this exception to your version of the
//  file(s), but you are not obligated to do so. If you do not wish to do so,
//  delete this exception statement from your version. If you delete this
//  exception statement from all source files in the program, then also delete
//  it in the license file.
//
////////////////////////////////////////////////////////////////////////////////
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
