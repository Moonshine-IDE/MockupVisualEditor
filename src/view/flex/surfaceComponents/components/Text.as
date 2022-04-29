package view.flex.surfaceComponents.components
{
    import flash.events.Event;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import spark.components.Label;
    
    import utils.MxmlCodeUtils;
    
    import view.flex.propertyEditors.TextPropertyEditor;
    import view.interfaces.IFlexSurfaceComponent;
	import mx.controls.Alert;

	public class Text extends Label implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "Label";
		public static const ELEMENT_NAME:String = "text";

		public function Text()
		{
			this.text = "This is some text";
			this.toolTip = "";
			this.percentWidth = 100;
			this.height = 15;
			this.minWidth = 10;
			this.minHeight = 10;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"textChanged"
            ];
		}

		public function get propertyEditorClass():Class
		{
			return TextPropertyEditor;
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

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override public function set text(value:String):void
        {
			if (super.text != value)
			{
				dispatchEvent(new Event("textChanged"));
			}

            super.text = value;
        }

        public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			setCommonXMLAttributes(xml);

			return xml;
		}

		public function fromXML(xml:XML, callback:Function, surface:ISurface,  lookup:ILookup):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			this.text = xml.@text;
		}

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            setCommonXMLAttributes(xml);

            return xml;
        }

		public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
		public function toRora():XML
        {
			Alert.show("Mock toRoyaleConvertCode execute2");
            return null;
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
            xml.@text = this.text;
		}
    }
}
