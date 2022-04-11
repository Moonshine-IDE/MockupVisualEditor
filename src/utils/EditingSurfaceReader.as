package utils
{
	import converter.DominoConverter;
	import converter.PrimeFacesConverter;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import lookup.Lookup;

	import surface.SurfaceMockup;

    public class EditingSurfaceReader
	{
        public static var classLookup:ILookup;

		public static function fromXML(surface:ISurface, xml:XML, visualEditorType:String):void
		{
			setCurrentLookup(visualEditorType);
			if(visualEditorType == VisualEditorType.DOMINO)
			{
            	DominoConverter.fromXML(surface, Lookup.DominoUILookup, xml);
			}
			else if (visualEditorType == VisualEditorType.FLEX)
			{
				PrimeFacesConverter.fromXML(surface, Lookup.FlexUILookup, xml);
			}
         	else
			{
				PrimeFacesConverter.fromXML(surface, Lookup.PrimeFacesUILookup, xml);
			}
		}

		public static function fromXMLAutoConvert(xml:XML):SurfaceMockup
		{
			setCurrentLookup(VisualEditorType.DOMINO);
			var surfaceModel:SurfaceMockup =  DominoConverter.fromXMLOnly(Lookup.DominoNonUILookup, xml);
			return surfaceModel;
		}

		private static function setCurrentLookup(visualEditorType:String):void
		{
			if (visualEditorType == VisualEditorType.DOMINO)
			{
				classLookup = Lookup.DominoUILookup;
			}
			else if (visualEditorType == VisualEditorType.FLEX)
			{
				classLookup = Lookup.FlexUILookup;
            }
			else
            {
				classLookup = Lookup.PrimeFacesUILookup;
            }
		}
	}
}
