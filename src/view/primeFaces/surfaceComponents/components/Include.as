package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import mx.graphics.SolidColor;
    
    import spark.components.BorderContainer;
    import spark.components.Button;
    import spark.components.Label;
    import spark.layouts.VerticalLayout;
    
    import utils.MoonshineBridgeUtils;
    import utils.XMLCodeUtils;
    
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.IncludePropertyEditor;

    public class Include extends BorderContainer implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "include";
        public static var ELEMENT_NAME:String = "Include";
		
		private var includeLabel:Label;
		private var includeButton:spark.components.Button;
		
        public function Include()
        {
            super();

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged"
            ];
			
			backgroundFill = new SolidColor(0xFCFCFC);
			
            var vLayout:VerticalLayout = new VerticalLayout();
			vLayout.horizontalAlign = "center";
			vLayout.verticalAlign = "middle";
			vLayout.gap = 10;
            layout = vLayout;
			
			toolTip = "";
			width = 110;
			height = 100;
        }

        public function get propertyEditorClass():Class
        {
            return IncludePropertyEditor;
        }

        private var _title:String;
		
		[Bindable("change")]
        public function get title():String
        {
            return _title;
        }

        public function set title(value:String):void
        {
			if (_title == value) return;
			
			includeLabel.text = _title = value;
			dispatchEvent(new Event("change"));
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
			xml.@src = this.title;
            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
			XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
			
			this.title = xml.@src;
        }

        public function toCode():XML
        {
			var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
			var primeFacesNamespace:Namespace = new Namespace("ui", "http://xmlns.jcp.org/jsf/facelets");
			xml.addNamespace(primeFacesNamespace);
			xml.setNamespace(primeFacesNamespace);
			
			XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);
			
			xml.@src = this.title;
			return xml;
        }
		
        protected function setCommonXMLAttributes(xml:XML):void
        {
            if (!isNaN(this.percentWidth))
            {
                xml.@percentWidth = this.percentWidth;
            }
            else
            {
                xml.@width = this.width;
            }

            if (!isNaN(this.percentHeight))
            {
                xml.@percentHeight = this.percentHeight;
            }
            else
            {
                xml.@height = this.height;
            }
        }
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			includeLabel = new Label();
			includeLabel.maxDisplayedLines = 2;
			includeLabel.showTruncationTip = true;
			includeLabel.percentWidth = 90;
			includeLabel.text = "File Name";
			includeLabel.setStyle("textAlign", "center");
			includeLabel.setStyle("fontSize", 12);
			includeLabel.setStyle("fontWeight", "bold");
			includeLabel.setStyle("textDecoration", "underline");
			addElement(includeLabel);
			
			includeButton = new spark.components.Button();
			includeButton.label = "Open in editor";
			includeButton.addEventListener(MouseEvent.CLICK, onIncludeButtonClicked, false, 0, true);
			addElement(includeButton);
		}
		
		private function onIncludeButtonClicked(event:MouseEvent):void
		{
			MoonshineBridgeUtils.moonshineBridge.openXhtmlFile(title);
		}
    }
}
