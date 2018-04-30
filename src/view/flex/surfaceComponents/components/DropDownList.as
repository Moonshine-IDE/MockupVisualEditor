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
package view.flex.surfaceComponents.components
{
    import data.DataProviderListItem;

    import flash.events.Event;

    import mx.collections.ArrayList;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import spark.components.DropDownList;

    import utils.MxmlCodeUtils;

    import view.interfaces.IDataProviderComponent;

    import view.interfaces.IFlexSurfaceComponent;

	import view.flex.propertyEditors.DropDownListPropertyEditor;
    import view.interfaces.ISelectableItemsComponent;

    public class DropDownList extends spark.components.DropDownList
		implements IFlexSurfaceComponent, IDataProviderComponent, ISelectableItemsComponent
	{
        private static const MXML_ELEMENT_NAME:String = "DropDownList";
		public static const ELEMENT_NAME:String = "dropdownlist";

		public function DropDownList()
		{
			this.mouseChildren = false;
			this.prompt = "Drop Down List";
            this.dataProvider = new ArrayList(
                    [
                        new DataProviderListItem("One"),
                        new DataProviderListItem("Two"),
                        new DataProviderListItem("Three"),
                        new DataProviderListItem("Four"),
                        new DataProviderListItem("Five")
                    ]);

			this.width = 120;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "dropDownListChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return DropDownListPropertyEditor;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
            if (dataProvider)
            {
                var dpCount:int = this.dataProvider.length;
                var dp:ArrayList = this.dataProvider as ArrayList;
                for(var i:int = 0; i < dpCount; i++)
                {
                    var item:XML = new XML("<item />");
                    var dropDownListItem:DataProviderListItem = dp.getItemAt(i) as DataProviderListItem;
                    item.@label = dropDownListItem.label;
                    xml.appendChild(item);
                }
            }

            setCommonXMLAttributes(xml);

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            this.x = xml.@x;
            this.y = xml.@y;
            this.width = xml.@width;
            this.height = xml.@height;

            var normalizedXml:XML = xml.normalize();
            var items:XMLList = normalizedXml.children();
            if (items.length() > 0)
            {
                this.dataProvider.removeAll();
            }

            for each (var item:XML in items)
            {
                dataProvider.addItem(new DataProviderListItem(item.@label));
            }
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

			setCommonXMLAttributes(xml);

            var dpMxml:XML = MxmlCodeUtils.getDataProviderMxml(this.dataProvider as ArrayList);
            if (dpMxml)
            {
                xml.appendChild(dpMxml);
            }

            return xml;
        }


        override protected function dataProvider_collectionChangeHandler(event:Event):void
        {
            super.dataProvider_collectionChangeHandler(event);

            if (event is CollectionEvent)
            {
                var ce:CollectionEvent = CollectionEvent(event);

                if (ce.kind == CollectionEventKind.ADD || ce.kind == CollectionEventKind.REMOVE)
                {
                    dispatchEvent(new Event("dropDownListChanged"));
                }
            }
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
		}
    }
}
