package utils
{
    import mx.core.IVisualElementContainer;

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
                var element:ISurfaceComponent = surface.getElementAt(0) as ISurfaceComponent;
                var elementCount:int = 0;
				var i:int = 0;
				var isMainApplication:Boolean = element is IMainApplication;
                var xml:XML = MainApplicationCodeUtils.getMainApplicationTag(element["title"], element.width, element.height);

                if (isMainApplication)
                {
                    elementCount = (element as IVisualElementContainer).numElements;
                    for (i = 0; i < elementCount; i++)
                    {
                        var mainWindowChild:ISurfaceComponent = (element as IVisualElementContainer).getElementAt(i) as ISurfaceComponent;
                        
						if (mainWindowChild === null)
						{
							continue;				
						}			
						
						var code:XML = mainWindowChild.toCode();
						if (mainWindowChild is IFlexSurfaceComponent)
                        {
                            xml.appendChild(code);
                        }
						else if (mainWindowChild is IPrimeFacesSurfaceComponent)
						{
							var body:XMLList = xml.children();
                        	var mainDiv:XML = null;

							for each (var item:XML in body)
                            {
                                var itemName:String = item.name();
                                if (itemName.lastIndexOf("body") > -1)
                                {
                                    mainDiv = item.div.(@id == 'mainDiv')[0];
                                    break;
                                }
                            }
							if (!mainDiv)
							{
								mainDiv = xml[0];
							}

                            mainDiv.appendChild(code);
						}
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
