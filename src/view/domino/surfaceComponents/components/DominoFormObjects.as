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
    import com.adobe.utils.StringUtil;

    public class DominoFormObjects

    {
        public static const DOMINO_ELEMENT_NAME:String = "dominoFormObject";
        
        private var _formula:String;
        private var _lotusscript:String;
        private var _javascript:String;
        private var _commonjavascript:String;
        private var _cachelotusscript:String;
        private var _clientType:String;
        private var _isCustomFunction:Boolean =false

        public function DominoFormObjects()
        {

        }

        public function get clientType():String {
            return _clientType;
        }

        public function set clientType(value:String):void {
            this._clientType = value;
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
        //_cachelotusscript
        public function get cachelotusscript():String {
            return _cachelotusscript;
        }

        public function set cachelotusscript(value:String):void {
            this._cachelotusscript = value;
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
                            if(obj==null || obj==undefined){
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
                                    formOptions.@type="Formula";
                                    formOptions.@iconType="Formula";
                                }
                                if(obj.lotusscript){
                                    formOptions.@lotusscript=StringHelper.base64Encode(obj.lotusscript)
                                    formOptions.@type="LotusScript";
                                    formOptions.@iconType="LotusScript";

                                }
                                if(obj.javascript){
                                    formOptions.@javascript=StringHelper.base64Encode(obj.javascript)
                                    formOptions.@type="JavaScript";
                                    formOptions.@iconType="JavaScript";
                                }
                                if(obj.commonjavascript){
                                    formOptions.@commonjavascript=StringHelper.base64Encode(obj.commonjavascript);
                                    formOptions.@type="JavaScript";
                                    formOptions.@iconType="JavaScript";
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


        public  function toFormulaXML(op:Dictionary,dxl:XML):XML
        {
            
            var titleXml:XML=null;
            var body:XMLList = dxl.children();
            for each (var item:XML in body)
            {
                var itemName:String = item.name();
                if (itemName=="http://www.lotus.com/dxl::item" && item.@name=="$TITLE")
                {
                    titleXml = item;
                }
            }

            if(op!=null){
                for (var key:Object in op) {
                    var keyString:String=key.toString()
                    if(op[keyString]!=undefined&& op[keyString]!=null){
                         
                        if(keyString.indexOf("global")>=0){
                            //this global options
                        }else{
                            var obj: DominoFormObjects= op[keyString] as DominoFormObjects;
                            if(obj!=null){
                                var itemName:String=getFormulaItemName(keyString);
                                itemName="$"+itemName;

                                for each (var item:XML in body)
                                {
                                    var oldItemName:String = item.name();
                                    if (oldItemName=="http://www.lotus.com/dxl::item" && item.@name==itemName)
                                    {
                                       delete item.parent().children()[item.childIndex()];
                                    }
                                }
                                
                                var newFormulaItem:XML=new XML("<item/>");
                                newFormulaItem.@name=itemName;
                                newFormulaItem.@sign='true';
                                if(obj.formula!=null&&obj.formula.length>0){
                                    var formula:XML=new XML("<formula>"+obj.formula+"</formula>");
                                    newFormulaItem.appendChild(formula);
                                   // Alert.show("newFormulaItem:"+newFormulaItem.toXMLString());
                                    titleXml.parent().insertChildAfter(titleXml,newFormulaItem);
                                }
                              
                               
                                
                            }
                        }
                    }
                }
            }

            return dxl;
        }

        private  function getFormulaItemName(keyString:String):String
        {
            keyString = keyString.charAt(0).toUpperCase() + keyString.slice(1);
            keyString=keyString.replace("Html","HTML");
            keyString=keyString.replace("Web","WEB");
            
            return keyString;
        }
        private static const OPTOIN_HEADER="'++LotusScript Development Environment:2:5:(Options):0:74"
        private static const FORWARD_HEADER="'++LotusScript Development Environment:2:5:(Forward):0:1"
        private static const DECLARATIONS_HEADER="Declare"
        private static const DECLARATIONS_LS_HEADER="'++LotusScript Development Environment:2:5:(Declarations):0:10"
        private static const BIND_HEADER="'++LotusScript Development Environment:2:2:BindEvents:1:129"
        private static const BIND_FUNCTION_HEADER="Private Sub BindEvents(Byval Objectname_ As String)";
        private static const BIND_FUNCTION_HEADER_2="         Static Source As NOTESUIDOCUMENT"
        private static const BIND_FUNCTION_HEADER_3="         Set Source = Bind(Objectname_)"
        private static const BIND_FUNCTION_TEMPLATE="         On Event function_name From Source Call function_name"
        private static const FUNCTION_HEADER="'++LotusScript Development Environment:2:2:function_name:1:12"

        
        public function toCode(op:Dictionary):XML
        {

            var xml:XML = new XML("<item />")
            xml.@name="$$FormScript"
            xml.@summary="false"
            xml.@sign="true"
            var txt:String="";
            txt=OPTOIN_HEADER+"\n";
            var formObject:DominoFormObjects=op["options"];
            if(formObject!=undefined&& formObject!=null)
            {
                if(formObject.lotusscript&&formObject.lotusscript.toString().length>0)
                {
                    txt=txt+formObject.lotusscript+"\n";
                }

            } 
            txt=txt+FORWARD_HEADER+"\n";
            var declarString:String="";
            var functionString:String="";
            var sourceDeclar:String="";

            for (var key:Object in op) {
                var keyString:String=key.toString()
                
                if(op[keyString]!=undefined&& op[keyString]!=null){
                        
                    if(keyString.indexOf("global")>=0){
                        //this global options
                    }else{
                       
                        if(keyString!="options"&&keyString!="declarations"){
                            var obj: DominoFormObjects= op[keyString] as DominoFormObjects;
                            if(obj!=undefined&& obj.isCustomFunction==false){
                                var lotusscript:String=obj.lotusscript
                                if(lotusscript&& lotusscript.length>0){
                                      var txtArray:Array=lotusscript.split("\n");
                                      var functionName:String
                                      if(txtArray.length>0){
                                        if(txtArray[0].toString().indexOf("Sub")>=0)
                                        {
                                            declarString=declarString+DECLARATIONS_HEADER+" "+txtArray[0].toString()+"\n";
                                            functionName=getLotusScirptFunctionName(txtArray[0].toString());
                                            var sourceString:String="";
                                            if(functionName&&functionName.length>0){
                                                sourceString=  BIND_FUNCTION_TEMPLATE.replace("function_name",functionName);
                                            }
                                            sourceString=  sourceString.replace("function_name",functionName)
                                            sourceDeclar=sourceDeclar+sourceString+"\n";
                                        }
                                        
                                      }
                                    if(functionName&&functionName.length>0){
                                      var headerFunction:String=FUNCTION_HEADER.replace("function_name",functionName)
                                      functionString=functionString+headerFunction+"\n";
                                      functionString=functionString+lotusscript+"\n";
                                    }
                                     

                                }
                              
                                
                            }
                        }
                    }
                }    
            }


            txt=txt+declarString+"\n";
            txt=txt+DECLARATIONS_LS_HEADER+"\n";

            if(op["declarations"]!=undefined && op["declarations"]!=null) 
            {
                var lotusscript:String=op["declarations"].lotusscript;
                if(op["declarations"].lotusscript&&op["declarations"].lotusscript.toString().length>0)
                {
                    txt=txt+op["declarations"].lotusscript+"\n";
                }

            }

            txt=txt+BIND_HEADER+"\n";
            txt=txt+BIND_FUNCTION_HEADER+"\n";
            txt=txt+BIND_FUNCTION_HEADER_2+"\n";
            txt=txt+BIND_FUNCTION_HEADER_3+"\n";
            txt=txt+sourceDeclar+"\n";
            txt=txt+"End Sub"+"\n";


            txt=txt+functionString+"\n";
            txt=StringUtil.trim(txt);
            var textXml:XML = new XML("<text>"+txt+"</text>");
            var breakXml:XML = new XML("<break/>")
            textXml.appendChild(breakXml);
            xml.appendChild(textXml)
           
            return xml;

        }

        public function toJavascriptDxl(op:Dictionary):String
        {
            var xml:String="";
            for (var key:Object in op) {
                var keyString:String=key.toString()
                
                if(op[keyString]!=undefined&& op[keyString]!=null){
                        
                    if(keyString.indexOf("global")>=0){
                        //this global options
                    }else{
                          if(keyString!="options"&&keyString!="declarations"){
                            var obj: DominoFormObjects= op[keyString] as DominoFormObjects;
                                if(obj!=undefined&& obj.isCustomFunction==false){
                                    var javascript:String=obj.javascript
                                    if(javascript&& javascript.length>0){
                                        var codeXml:XML=new XML("<code />");
                                        if(keyString!="jsHeader"){
                                            codeXml.@event=keyString;
                                        }else{
                                            codeXml.@event="jsheader";
                                        }
                                       
                                        if(obj.clientType){
                                            codeXml["@for"] =obj.clientType;
                                        }else{
                                            codeXml["@for"] ="web";
                                        }

                                        var javascriptXml:XML=new XML("<javascript>"+javascript+"</javascript>");
                                        codeXml.appendChild(javascriptXml);
                                        xml=xml+codeXml.toXMLString()+"\n";
                                        
                                    }
                                }
                       
                            }
                    }
                }
            
            }
            return xml;
        }

        private function getLotusScirptFunctionName(line:String):String 
        {
            var subName:String="";
            if(line.indexOf("Sub")>=0 && line.indexOf("(")>=0)
            {
                line=line.replace("Sub ","");
                subName=line.substring(0, line.indexOf("("));
            }
           
            return subName;
        }
    }
}