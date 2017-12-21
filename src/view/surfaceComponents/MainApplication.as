////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package view.surfaceComponents
{
    import view.IMainApplication;
    import view.INonDeletableSurfaceComponent;

    public class MainApplication extends Window implements INonDeletableSurfaceComponent, IMainApplication
    {
        public static const ELEMENT_NAME:String = "MainApplication";
        
        public function MainApplication():void
        {
            super();
            this.title = "Main Window";
        }

        override public function fromXML(xml:XML, callback:Function):void
        {
            this.id = xml.@id;
            super.fromXML(xml, callback);
        }
    }
}
