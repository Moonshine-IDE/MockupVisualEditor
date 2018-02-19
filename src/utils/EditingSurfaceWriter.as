package utils
{
    import mx.core.IVisualElementContainer;
    import mx.core.UIComponent;

    import utils.MainApplicationCodeUtils;

    import view.EditingSurface;
    import view.interfaces.IFlexSurfaceComponent;
    import view.interfaces.IMainApplication;
    import view.interfaces.ISurfaceComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;

    public class EditingSurfaceWriter
	{
		public static function toXML(surface:EditingSurface):XML
		{
			var xml:XML = <mockup/>;
            var primeFacesContainer:XML = MainApplicationCodeUtils.appendXMLMainTag(xml);
			var elementCount:int = surface.numElements;
			for(var i:int = 0; i < elementCount; i++)
			{
				var element:ISurfaceComponent = surface.getElementAt(i) as ISurfaceComponent;
				if(element === null)
				{
					continue;
				}
				var elementXML:XML = element.toXML();
                if (primeFacesContainer)
                {
                    primeFacesContainer.appendChild(elementXML);
                }
                else
                {
                    xml.appendChild(elementXML);
                }
			}
			return xml;
		}

		CONFIG::MOONSHINE
        {
            public static function toCode(surface:EditingSurface):XML
            {
                var element:ISurfaceComponent = surface.getElementAt(0) as ISurfaceComponent;
                var title:String = (element as UIComponent).hasOwnProperty("title") ? element["title"] : "";
                var xml:XML = MainApplicationCodeUtils.getParentContent(title, element.width, element.height,
                        element.percentWidth, element.percentHeight);
                var mainContainer:XML = MainApplicationCodeUtils.getMainContainerTag(xml);

                var container:IVisualElementContainer = surface;
                if (element is ISurfaceComponent)
                {
                    container = element as IVisualElementContainer;
                }

                var elementCount:int = container.numElements;
                for (var i:int = 0; i < elementCount; i++)
                {
                    element = container.getElementAt(i) as ISurfaceComponent;

                    if (element === null)
                    {
                        continue;
                    }

                    var code:XML = element.toCode();
                    if (mainContainer)
                    {
                        mainContainer.appendChild(code);
                    }
                    else
                    {
                        xml.appendChild(code);
                    }
                }

				return xml;
            }
        }
	}
}
