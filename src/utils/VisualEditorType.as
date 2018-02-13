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
			_instance = this;
	    }
	
		public var value:String;
		
	    public static function getInstance(type:VisualEditorType = null):VisualEditorType
		{
	        if(!_instance)
	        {
	            _instance = type;
	        } 
	        return _instance;
	    }

		public static function get instance():VisualEditorType 
		{
			return _instance;
		}		
	}
}