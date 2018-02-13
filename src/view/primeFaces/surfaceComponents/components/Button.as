package view.primeFaces.surfaceComponents.components
{
	import spark.components.Button;
	import view.interfaces.IPrimeFacesSurfaceComponent;
	import view.primeFaces.propertyEditors.ButtonPropertyEditor;

	public class Button extends spark.components.Button implements IPrimeFacesSurfaceComponent
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "button";
		public static const ELEMENT_NAME:String = "button";
		
		public function Button()
		{
			super();
			
			_propertiesChangedEvents = [
					"widthChanged",
					"heightChanged",
					"explicitMinWidthChanged",
					"explicitMinHeightChanged"
			];
		}
		
		public function get propertyEditorClass():Class
		{
			return ButtonPropertyEditor;
		}		
		
		private var _propertiesChangedEvents:Array;
		public function get propertiesChangedEvents():Array
		{
			return _propertiesChangedEvents;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

			setCommonXMLAttributes(xml);

            xml.@value = this.label;

			return xml;
		}		
		
		public function fromXML(xml:XML, childFromXMLCallback:Function):void
		{
			this.width = xml.@width;
			this.height = xml.@height;
			this.label = xml.@value;
		}
		
		private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@width = this.width;
            xml.@height = this.height;
		}
	}
}