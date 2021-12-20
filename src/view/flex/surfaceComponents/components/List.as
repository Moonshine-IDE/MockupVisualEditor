package view.flex.surfaceComponents.components
{
	import data.DataProviderListItem;

    import flash.events.Event;

    import mx.collections.ArrayList;
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;

    import spark.components.List;

    import utils.MxmlCodeUtils;

    import view.flex.surfaceComponents.skins.ListSkin;

    import view.interfaces.IDataProviderComponent;
    import view.interfaces.IFlexSurfaceComponent;

    import view.interfaces.ISelectableItemsComponent;

	import view.flex.propertyEditors.ListPropertyEditor;

	public class List extends spark.components.List
		implements IFlexSurfaceComponent, IDataProviderComponent, ISelectableItemsComponent
	{
        private static const MXML_ELEMENT_NAME:String = "List";
		public static const ELEMENT_NAME:String = "list";

		public function List()
		{
            super();

            this.setStyle("skinClass", ListSkin);
            this.setStyle("color", "#6A6A6A");
            this.setStyle("fontSize", 12);

			this.mouseChildren = false;
			this.dataProvider = new ArrayList(
			[
				new DataProviderListItem("One"),
				new DataProviderListItem("Two"),
				new DataProviderListItem("Three"),
				new DataProviderListItem("Four"),
				new DataProviderListItem("Five")
			]);
			this.width = 120;
			this.height = 120;
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
			return ListPropertyEditor;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }
		
		private var _isSelected:Boolean;
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
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
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");
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

        public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
        public function toRora():XML
        {
            return null;
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
