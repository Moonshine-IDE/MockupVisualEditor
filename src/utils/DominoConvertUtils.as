////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) STARTcloud, Inc. 2015-2022. All rights reserved.
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
    public class DominoConvertUtils
	{
        import flash.text.TextField;
        import flash.text.StyleSheet;
        import spark.components.gridClasses.GridColumn;

        public static function convertDominoCharacterWidthToPixelWidth(sizeNum:Number,fontName:String,fontWeight:String,charNum:Number):Number
        {
            
            var newStyle:StyleSheet =  setTextStyle(sizeNum,fontName,fontWeight) ; 
            var textFiled:TextField = new TextField();
            textFiled.styleSheet=newStyle;
            var labelText:String="";
            for (var i:int = 0; i < charNum; i++) {
                labelText=labelText+"X";
            }
            textFiled.htmlText=labelText;
            return textFiled.textWidth;

        }

        public static function convertPixelWidthToDominoCharacterWidth(sizeNum:Number,fontName:String,fontWeight:String,pixelWidth:Number):Number
        {
            var newStyle:StyleSheet =  setTextStyle(sizeNum,fontName,fontWeight) ; 
            var textFiled:TextField = new TextField();
            textFiled.styleSheet=newStyle;
            var labelText:String="X";
            textFiled.htmlText=labelText;
            var width:Number=textFiled.textWidth;
            var charNum:Number=Math.round(pixelWidth/width)+1;
            return charNum;

        }

        private static function setTextStyle(sizeNum:Number,fontName:String,fontWeight:String):StyleSheet{
            var newStyle:StyleSheet = new StyleSheet();
            var styleObj:Object = new Object();
                //normal and bold.
                styleObj.fontWeight = fontWeight;
                //Recognized values are normal and italic. -- fontStyle
                styleObj.fontSize = sizeNum;
                styleObj.fontFamily = fontName;
                newStyle.setStyle(".defStyle", styleObj);
                return   newStyle ;
        }

        // public static function resizeColumn(col:GridColumn, size:int):GridColumn
        // {
        //     var owner:* = col.mx_internal::owner
        //     col.mx_internal::owner = null;

        //     col.width = size;

        //     col.mx_internal::owner = owner;
        //     return col
        // }
        
    }
}