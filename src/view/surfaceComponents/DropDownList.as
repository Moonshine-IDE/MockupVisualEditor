package view.surfaceComponents
{
    import data.DataProviderListItem;

    import flash.events.Event;

    import mx.collections.ArrayList;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import spark.components.DropDownList;

	import view.ISurfaceComponent;
	import view.propertyEditors.DropDownListPropertyEditor;

	public class DropDownList extends spark.components.DropDownList
		implements ISurfaceComponent, IDataProviderComponent
	{
        private static const MXML_ELEMENT_NAME:String = "DropDownList";
		public static const ELEMENT_NAME:String = "dropdownlist";

		public function DropDownList()
		{
			this.mouseChildren = false;
			this.prompt = "Drop Down List";
            this.dataProvider = new ArrayList([new DataProviderListItem("One")]);
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

        public function toMXML():XML
        {
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

			setCommonXMLAttributes(xml);

            var dpCount:int = 0;
            if (this.dataProvider)
            {
                dpCount = this.dataProvider.length;
            }

            if (dpCount > 0)
            {
                var dpMxml:XML = new XML("<dataProvider/>");
                dpMxml.addNamespace(sparkNamespace);
                dpMxml.setNamespace(sparkNamespace);

                var arrayListMxml:XML = new XML("<ArrayList/>");
                arrayListMxml.addNamespace(sparkNamespace);
                arrayListMxml.setNamespace(sparkNamespace);

                var fxNamespace:Namespace = new Namespace("fx", "http://ns.adobe.com/mxml/2009");
                var arrayMxml:XML = new XML("<Array/>");
                arrayMxml.addNamespace(fxNamespace);
                arrayMxml.setNamespace(fxNamespace);

                var dp:ArrayList = this.dataProvider as ArrayList;
                for(var i:int = 0; i < dpCount; i++)
                {
                    var itemMxml:XML = new XML("<Object/>");
                    itemMxml.addNamespace(fxNamespace);
                    itemMxml.setNamespace(fxNamespace);

                    var dropDownListItem:DataProviderListItem = dp.getItemAt(i) as DataProviderListItem;
                    itemMxml.@label = dropDownListItem.label;

                    arrayMxml.appendChild(itemMxml);
                }

                arrayListMxml.appendChild(arrayMxml);
                dpMxml.appendChild(arrayListMxml);
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
