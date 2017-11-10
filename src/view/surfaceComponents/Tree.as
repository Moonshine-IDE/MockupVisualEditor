package view.surfaceComponents
{
	import mx.collections.IList;
	import mx.controls.Tree;
	import mx.events.FlexEvent;

	import view.ISurfaceComponent;

	public class Tree extends mx.controls.Tree implements ISurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "Tree";
		public static const ELEMENT_NAME:String = "tree";

		public function Tree()
		{
			this.mouseChildren = false;
			var data:Array =
			[
				{
					label: "A",
					children:
					[
						{ label: "A-1" },
						{ label: "A-2" }
					]
				},
				{
					label: "B",
					children:
					[
						{ label: "B-1" }
					]
				}
			];
			this.dataProvider = data;
			this.width = 120;
			this.height = 120;
			this.minWidth = 20;
			this.minHeight = 20;
			this.addEventListener(FlexEvent.CREATION_COMPLETE, tree_creationCompleteHandler);

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return null;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			setCommonXMLAttributes(xml);

			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
		}

		private function tree_creationCompleteHandler(event:FlexEvent):void
		{
			var dataProvider:IList = IList(this.dataProvider);
			var childCount:int = dataProvider.length;
			for(var i:int = 0; i < childCount; i++)
			{
				var item:Object = dataProvider.getItemAt(i);
				this.expandItem(item, true);
			}
		}

        public function toMXML():XML
        {
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");
            var mxNamespace:Namespace = new Namespace("mx", "library://ns.adobe.com/flex/mx");
            xml.addNamespace(mxNamespace);
            xml.setNamespace(mxNamespace);

            setCommonXMLAttributes(xml);

            return xml;
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
