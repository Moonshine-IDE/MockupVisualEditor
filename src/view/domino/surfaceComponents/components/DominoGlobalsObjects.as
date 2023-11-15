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

    import interfaces.IRoyaleComponentConverter;
    import view.interfaces.IIdAttribute;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IDominoSurfaceComponent;
    import interfaces.dominoComponents.IDominoGlobalsObjects
    import components.domino.DominoGlobalsObjects
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    public class DominoGlobalsObjects implements  IRoyaleComponentConverter
    {
        private var _initialize:String;
        private var _terminate:String;
        private var _options:String;
        private var _declarations:String;
        
        public static const ELEMENT_NAME:String = "dominoGlobalsObject";
        public static const DOMINO_ELEMENT_NAME:String = "dominoGlobalsObject";
        private var component:IDominoGlobalsObjects;
        public function DominoGlobalsObjects()
        {
            component = new components.domino.DominoGlobalsObjects();
        }


        public function get declarations():String {
            return _declarations;
        }

        public function set declarations(value:String):void {
            _declarations = value;
        }


        public function get initialize():String {
            return _initialize;
        }

        public function set initialize(value:String):void {
            _initialize = value;
        }

        public function get terminate():String {
            return _terminate;
        }

        public function set terminate(value:String):void {
            _terminate = value;
        }

        public function get options():String {
            return _options;
        }

        public function set options(value:String):void {
            _options = value;
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + DOMINO_ELEMENT_NAME +">")
            if(this.options){
                xml.@options=StringHelper.base64Encode(this.options)
            }
            if(this.terminate){
                xml.@terminate=StringHelper.base64Encode(this.terminate)
            }
            if(this.initialize){
                xml.@initialize=StringHelper.base64Encode(this.initialize)
            }
            if(this.declarations){
                xml.@declarations=StringHelper.base64Encode(this.declarations)
            }
            return xml;
        }

        public function fromXML(xml:XML,callback:Function, surface:ISurface, lookup:ILookup):void
        {
            var localSurface:ISurface = surface;            
            component.fromXML(xml,callback,surface,lookup);
            this.initialize=StringHelper.base64Decode(component.initialize);
            this.terminate=StringHelper.base64Decode(component.terminate);
            this.options=StringHelper.base64Decode(component.options);
            this.declarations=StringHelper.base64Decode(component.declarations);
        }
       

        public function toCode():XML
        {
			component.initialize = this.initialize;
            component.terminate = this.terminate;
            component.options = this.options;
            component.declarations = this.declarations;
            return component.toCode();
        }

        public function toRoyaleConvertCode():XML
        {
            return null;
        }
    }   
}