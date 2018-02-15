package utils
{
	public class VisualEditorType  
	{
		public static const FLEX:VisualEditorType = new VisualEditorType("flex");
		public static const PRIME_FACES:VisualEditorType = new VisualEditorType("primeFaces");
		
		private static var _instance:VisualEditorType;	
		
		public function VisualEditorType(value:String)
		{
			this.value = value;
	    }
	
		public var value:String;
		
	    public static function setInstance(type:VisualEditorType = null):void
		{
            _instance = type;
	    }

		public static function get instance():VisualEditorType 
		{
			return _instance;
		}		
	}
}