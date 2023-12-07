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

package view.domino.surfaceComponents.components
{
    import view.interfaces.ICDATAInformation;
    import interfaces.ISurface;
    import interfaces.ILookup;
    import utils.StringHelper;
    import flash.utils.Dictionary;
    import interfaces.IRoyaleComponentConverter;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IDominoSurfaceComponent;
    import mx.controls.Alert;

    public class DominoFormObjects

    {
        public static const DOMINO_ELEMENT_NAME:String = "dominoFormObject";
        
        private var _formula:String;
        private var _lotusscript:String;
        private var _javascript:String;
        private var _commonjavascript:String;
        private var _isCustomFunction:Boolean =false

        public function DominoFormObjects()
        {

        }

        public function get isCustomFunction():Boolean {
            return _isCustomFunction;
        }

        public function set isCustomFunction(value:Boolean):void {
            this._isCustomFunction = value;
        }

        public function get formula():String {
            return _formula;
        }

        public function set formula(value:String):void {
            this._formula = value;
        }

        public function get lotusscript():String {
            return _lotusscript;
        }

        public function set lotusscript(value:String):void {
            this._lotusscript = value;
        }

        public function get javascript():String {
            return _javascript;
        }

        public function set javascript(value:String):void {
            this._javascript = value;
        }

        public function initalJavaScript(value:String):void {
            this._javascript = value;
        }

        public function get commonjavascript():String {
            return _commonjavascript;
        }

        public function set commonjavascript(value:String):void {
            this._commonjavascript = value;
        }
        public static function toXML(op:Dictionary):XML
        {
            var xml:XML = new XML("<dominoFormObject />")
                               
            if(op!=null){
                for (var key:Object in op) {
                    if(op[key]!=undefined&& op[key]!=null){
                        if(key.indexOf("global")>=0){
                            //this global options
                        }else{
                            var obj: DominoFormObjects= op[key] as DominoFormObjects;
                            if(obj==null){
								obj=new DominoFormObjects();
                                obj.isCustomFunction=false;
							}

                            if(obj.isCustomFunction==false){
                                var formOptions:XML=new XML("<"+key+" />");
                                //Alert.show("formOptions:"+formOptions.toXMLString());
                                if(obj.formula){
                                    formOptions.@formula=StringHelper.base64Encode(obj.formula)
                                }
                                if(obj.lotusscript){
                                    formOptions.@lotusscript=StringHelper.base64Encode(obj.lotusscript)
                                }
                                if(obj.javascript){
                                    formOptions.@javascript=StringHelper.base64Encode(obj.javascript)
                                }
                                if(obj.commonjavascript){
                                    formOptions.@commonjavascript=StringHelper.base64Encode(obj.commonjavascript)
                                }
                                if(obj.isCustomFunction){
                                    formOptions.@isCustomFunction="true"
                                }else{
                                    formOptions.@isCustomFunction="false"
                                }
                                
                                //Alert.show("formOptions 140:"+formOptions.toXMLString());
                                xml.appendChild(formOptions)
                                //Alert.show("xml 142:"+xml.toXMLString());
                            }
                        }   
                    };
                }
            }
            return xml;
        }

        public static function toCustomXML(op:Dictionary):XML
        {
            var xml:XML = new XML("<dominoCustomObject />")
            if(op!=null){
                for (var key:Object in op) {
                    var keyString:String=key.toString()
                    if(op[keyString]!=undefined&& op[keyString]!=null){
                         
                        if(keyString.indexOf("global")>=0){
                            //this global options
                        }else{
                            var obj: DominoFormObjects= op[keyString] as DominoFormObjects;
                            if(obj!=null&& obj.isCustomFunction==true){
                              
                                var formOptions:XML=new XML("<"+keyString+" />");
                                if(obj.formula){
                                    formOptions.@formula=StringHelper.base64Encode(obj.formula)
                                }
                                if(obj.lotusscript){
                                    formOptions.@lotusscript=StringHelper.base64Encode(obj.lotusscript)
                                }
                                if(obj.javascript){
                                    formOptions.@javascript=StringHelper.base64Encode(obj.javascript)
                                }
                                if(obj.commonjavascript){
                                    formOptions.@commonjavascript=StringHelper.base64Encode(obj.commonjavascript)
                                }
                                if(obj.isCustomFunction){
                                    formOptions.@isCustomFunction="true"
                                }else{
                                    formOptions.@isCustomFunction="false"
                                }
                                xml.appendChild(formOptions)

                                
                            }

                       
                           
                        
                        }   
                    };
                }
            }
            //Alert.show("toCustomxml:"+xml.toXMLString());
            return xml;
        }

       

        public function toCode(op:Dictionary):XML
        {

            var xml:XML = new XML("<item />")
            xml.@name="$$FormScript"
            xml.@summary="false"
            xml.@sign="true"



            var textXml:XML = new XML("<text />");
            return xml;

        }
    }
}