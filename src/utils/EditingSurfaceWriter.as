package utils
{
    import mx.core.IVisualElementContainer;

    import view.EditingSurface;
    import view.interfaces.IFlexSurfaceComponent;
    import view.interfaces.IMainApplication;
    import view.interfaces.ISurfaceComponent;

    public class EditingSurfaceWriter
	{
		public static function toXML(surface:EditingSurface):XML
		{
			var xml:XML = <mockup/>;
			var elementCount:int = surface.numElements;
			for(var i:int = 0; i < elementCount; i++)
			{
				var element:ISurfaceComponent = surface.getElementAt(i) as ISurfaceComponent;
				if(element === null)
				{
					continue;
				}
				var elementXML:XML = element.toXML();
				xml.appendChild(elementXML);
			}
			return xml;
		}

		CONFIG::MOONSHINE
        {
            public static function toCode(surface:EditingSurface):XML
            {
                var element:IFlexSurfaceComponent = surface.getElementAt(0) as IFlexSurfaceComponent;
                var elementCount:int = 0;
				var i:int = 0;
                var xml:XML = new XML("<WindowedApplication></WindowedApplication>");
                var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
                xml.addNamespace(sparkNamespace);
                xml.setNamespace(sparkNamespace);

                var fxNamespace:Namespace = new Namespace("fx", "http://ns.adobe.com/mxml/2009");
                xml.addNamespace(fxNamespace);

                if (element is IMainApplication)
                {
                    xml.@width = element.width;
                    xml.@height = element.height;
                    xml.@title = element["title"];

                    elementCount = (element as IVisualElementContainer).numElements;
                    for (i = 0; i < elementCount; i++)
                    {
                        var mainWindowChild:IFlexSurfaceComponent = (element as IVisualElementContainer).getElementAt(i) as IFlexSurfaceComponent;
                        if (mainWindowChild === null)
                        {
                            continue;
                        }
                        xml.appendChild(mainWindowChild.toCode());
                    }
                }
				else
				{
                    elementCount = surface.numElements;
                    for (i = 0; i < elementCount; i++)
                    {
                        element = surface.getElementAt(i) as IFlexSurfaceComponent;
                        if (element === null)
                        {
                            continue;
                        }
                        var elementXML:XML = element.toCode();
                        xml.appendChild(elementXML);
                    }
				}

				return xml;
            }
        }
	}
}
