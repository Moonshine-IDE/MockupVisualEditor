package utils
{
    import mx.core.IVisualElementContainer;
    import mx.core.UIComponent;
    import view.EditingSurface;
    import view.interfaces.ISurfaceComponent;

    public class EditingSurfaceWriter
	{
		public static function toXML(surface:EditingSurface, visualEditorType:String):XML
		{
			var xml:XML = <mockup/>;
            var primeFacesContainer:XML = null;
            if (visualEditorType == VisualEditorType.PRIME_FACES)
            {
                primeFacesContainer = surface.numElements == 0 ? MainApplicationCodeUtils.appendXMLMainTag(surface) : null;
            }

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

            if (primeFacesContainer)
            {
                xml.appendChild(primeFacesContainer);
            }
			return xml;
		}

		CONFIG::MOONSHINE
        {
            public static function toCode(surface:EditingSurface):XML
            {
                var element:ISurfaceComponent = surface.getElementAt(0) as ISurfaceComponent;
                var title:String = (element as UIComponent).hasOwnProperty("path") ? element["path"] : "";
                var xml:XML = MainApplicationCodeUtils.getParentContent(surface, title, element as UIComponent);
                var mainContainer:XML = MainApplicationCodeUtils.getMainContainerTag(xml);

                var container:IVisualElementContainer = surface;
                if (element is ISurfaceComponent)
                {
                    container = element as IVisualElementContainer;
                }

                var elementCount:int = 0;
                if (!container)
                {
                    elementCount = surface.numElements;
                    container = surface;
                }
                else
                {
                    elementCount = container.numElements;
                }

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
