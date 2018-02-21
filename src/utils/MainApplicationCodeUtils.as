package utils
{
    import view.EditingSurface;
    import view.interfaces.IFlexSurfaceComponent;
    import view.interfaces.ISurfaceComponent;
    import view.primeFaces.surfaceComponents.components.MainApplication;

    public class MainApplicationCodeUtils
	{

		public static function appendXMLMainTag(surface:EditingSurface):XML
		{
			var element:ISurfaceComponent = surface.numElements > 0 ? surface.getElementAt(0) as ISurfaceComponent : null;
			var isPrimeFacesMainApp:MainApplication = element as MainApplication;

            if (!isPrimeFacesMainApp && element === null)
			{
				var container:XML = new XML("<Container />");
                container.@percentWidth = "100";
				container.@percentHeight = "100";

				return container;
			}

			return null;
		}

		public static function getMainContainerTag(xml:XML):XML
		{
            var body:XMLList = xml.children();
            for each (var item:XML in body)
            {
                var itemName:String = item.name();
                if (itemName.lastIndexOf("body") > -1)
                {
                    return item.div[0];
                }
            }

			return null;
		}

		public static function getParentContent(surface:EditingSurface, title:String, width:Number, height:Number,
                                                percentWidth:Number, percentHeight:Number):XML
		{
            var element:ISurfaceComponent = surface.getElementAt(0) as ISurfaceComponent;
            var isPrimeFacesMainApp:MainApplication = element as MainApplication;

			if (!isPrimeFacesMainApp && element is IFlexSurfaceComponent)
			{
				return getFlexMainContainer(title, width, height);
			}
			
			return getPrimeFacesMainContainer(title, width, height, percentWidth, percentHeight);
		}
		
		private static function getFlexMainContainer(title:String, width:Number, height:Number):XML
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
		
		private static function getPrimeFacesMainContainer(title:String, width:Number, height:Number,
                                                           percentWidth:Number, percentHeight:Number):XML
		{
			var xml:XML = new XML("<html/>");

            var htmlNamespace:Namespace = new Namespace("", "http://www.w3.org/1999/xhtml");
            xml.addNamespace(htmlNamespace);
            xml.setNamespace(htmlNamespace);

			var hNamespace:Namespace = new Namespace("h", "http://xmlns.jcp.org/jsf/html");
			xml.addNamespace(hNamespace);

			var pNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
			xml.addNamespace(pNamespace);

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

            XMLCodeUtils.addSizeHtmlStyleToXML(mainDiv, width, height, percentWidth, percentHeight);
			
			bodyXML.appendChild(mainDiv);
			
			xml.appendChild(headXml);
			xml.appendChild(bodyXML);
			
			return xml;
		}
	}
}