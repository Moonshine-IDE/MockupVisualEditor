package utils
{
	public class MainApplicationCodeUtils  
	{
		
		public static function getMainApplicationTag(title:String, width:Number, height:Number):XML
		{
			if (VisualEditorType.FLEX == VisualEditorType.instance)
			{
				return getFlexMainApplicationTag(title, width, height);
			}
			
			return getPrimeFacesMainApplicationTag(title, width, height);
		}
		
		private static function getFlexMainApplicationTag(title:String, width:Number, height:Number):XML
		{
			var xml:XML = new XML("<WindowedApplication></WindowedApplication>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);
			
            var fxNamespace:Namespace = new Namespace("fx", "http://ns.adobe.com/mxml/2009");
            xml.addNamespace(fxNamespace);
			xml.@title = title;
			xml.@width = width;
			xml.@height = height;
			
			return xml;
		}
		
		private static function getPrimeFacesMainApplicationTag(title:String, width:Number, height:Number):XML
		{
			var xml:XML = new XML("<html/>");
            var htmlNamespace:Namespace = new Namespace(null, "http://www.w3.org/1999/xhtml");
            xml.addNamespace(htmlNamespace);
            xml.setNamespace(htmlNamespace);
			
			var hNamespace:Namespace = new Namespace("h", "http://xmlns.jcp.org/jsf/html");
			xml.addNamespace(hNamespace);
            xml.setNamespace(hNamespace);

			var pNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
			xml.addNamespace(pNamespace);
            xml.setNamespace(pNamespace);

			var headXml:XML = new XML("<head/>");
			headXml.addNamespace(hNamespace);
			headXml.setNamespace(hNamespace);
	
			if (!title)
			{
				title = "";
			}		
			
			var titleXML:XML = new XML("<title>" + title + "</title>");
			headXml.appendChild(titleXML);
			
			var bodyXML:XML = new XML("<body/>");
			bodyXML.addNamespace(hNamespace);
			bodyXML.setNamespace(hNamespace);

			var mainDiv:XML = new XML("<div/>");
			mainDiv.@id = "mainDiv";
			var styleDiv:String = "";
			if (!isNaN(width))
			{
				styleDiv += "width = " + String(width) + "px;";
			}
			
			if (!isNaN(height))
			{
				styleDiv += "height = " + String(height) + "px;";
			}
			
			mainDiv.@style = styleDiv;
			
			bodyXML.appendChild(mainDiv);
			
			xml.appendChild(headXml);
			xml.appendChild(bodyXML);
			
			return xml;
		}
	}
}