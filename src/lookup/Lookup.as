package lookup
{
	import interfaces.ILookup;

	public class Lookup
	{
        public static const DominoNonUILookup:ILookup = new lookup.DominoNonUILookup();
		public static const DominoUILookup:ILookup = new lookup.DominoUILookup();

		public static const FlexNonUILookup:ILookup = new lookup.FlexNonUILookup();
		public static const FlexUILookup:ILookup = new lookup.FlexUILookup();

		public static const PrimeFacesNonUILookup:ILookup = new lookup.PrimeFacesNonUILookup();
		public static const PrimeFacesUILookup:ILookup = new lookup.PrimeFacesUILookup();
	}
}
