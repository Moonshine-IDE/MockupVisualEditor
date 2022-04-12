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
			if(visualEditorType == VisualEditorType.DOMINO)
			{
				classLookup = Lookup.DominoUILookup;
            	DominoConverter.fromXML(surface, Lookup.DominoUILookup, xml);
			}
			else if (visualEditorType == VisualEditorType.FLEX)
			{
				classLookup = Lookup.FlexUILookup;
				PrimeFacesConverter.fromXML(surface, Lookup.FlexUILookup, xml);
			}
         	else
			{
				classLookup = Lookup.PrimeFacesUILookup;
				PrimeFacesConverter.fromXML(surface, Lookup.PrimeFacesUILookup, xml);
			}
		}

		public static function fromXMLAutoConvert(xml:XML):SurfaceMockup
		{
			classLookup = Lookup.DominoNonUILookup;
			var surfaceModel:SurfaceMockup =  DominoConverter.fromXMLOnly(Lookup.DominoNonUILookup, xml);
			return surfaceModel;
		}
	}
}
