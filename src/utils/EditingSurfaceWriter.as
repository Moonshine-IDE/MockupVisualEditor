package utils
{
	import view.EditingSurface;
	import view.ISurfaceComponent;

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
            public static function toMXML(surface:EditingSurface):XML
            {
                var xml:XML = <mockup/>;
                var elementCount:int = surface.numElements;
                for (var i:int = 0; i < elementCount; i++)
                {
                    var element:ISurfaceComponent = surface.getElementAt(i) as ISurfaceComponent;
                    if (element === null)
                    {
                        continue;
                    }
                    var elementXML:XML = element.toMXML();
					if (elementXML)
                    {
                        xml.appendChild(elementXML);
                    }
                }
                return xml;
            }
        }
	}
}
