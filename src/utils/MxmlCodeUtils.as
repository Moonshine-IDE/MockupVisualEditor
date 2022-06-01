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
package utils
{
    import mx.collections.ArrayList;
    import mx.utils.ObjectUtil;
    
    import view.interfaces.ISurfaceComponent;
    import view.primeFaces.supportClasses.ContainerDirection;

    public class MxmlCodeUtils
    {
        public static function getDataProviderMxml(dataProvider:ArrayList):XML
        {
            var dpCount:int = 0;
            if (dataProvider)
            {
                dpCount = dataProvider.length;
            }

            if (dpCount == 0) return null;
            
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            var fxNamespace:Namespace = new Namespace("fx", "http://ns.adobe.com/mxml/2009");

            var dpMxml:XML = new XML("<dataProvider/>");
            dpMxml.addNamespace(sparkNamespace);
            dpMxml.setNamespace(sparkNamespace);

            var arrayListMxml:XML = new XML("<ArrayList/>");
            arrayListMxml.addNamespace(sparkNamespace);
            arrayListMxml.setNamespace(sparkNamespace);

            var arrayMxml:XML = new XML("<Array/>");
            arrayMxml.addNamespace(fxNamespace);
            arrayMxml.setNamespace(fxNamespace);

            for(var i:int = 0; i < dpCount; i++)
            {
                var itemMxml:XML = new XML("<Object/>");
                itemMxml.addNamespace(fxNamespace);
                itemMxml.setNamespace(fxNamespace);

                var item:Object = dataProvider.getItemAt(i);
                var itemInfo:Object = ObjectUtil.getClassInfo(item);
                for each (var property:QName in itemInfo.properties)
                {
                    itemMxml.@[property.localName] = item[property.localName];
                }
                arrayMxml.appendChild(itemMxml);
            }

            arrayListMxml.appendChild(arrayMxml);
            dpMxml.appendChild(arrayListMxml);

            return dpMxml;
        }
		
		public static function getMXMLTagNameWithSelection(component:ISurfaceComponent, rootElementName:String):String
		{
			return (component.isSelected ? "_moonshineSelected_"+ rootElementName : rootElementName);
		}

        public static function getInfoContainerDirection(component:ISurfaceComponent):String
        {
            var directionInfo:String = "";
            var direction:String = component["direction"];

            if (direction == ContainerDirection.HORIZONTAL_LAYOUT)
            {
                directionInfo = "Container has horizontal direction";
            }
            else
            {
                directionInfo = "Container has vertical direction";
            }

            return directionInfo;
        }
    }
}
