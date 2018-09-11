package data
{
	public class OrganizerItem
	{
		public static const TYPE_CELL:String = "typeCell";
		public static const TYPE_COLUMN:String = "typeColumns";
		public static const TYPE_ROW:String = "typeRow";
		
		public var item:Object;
		public var children:Array;
		public var name:String;
		public var type:String;
		
		public function OrganizerItem(item:Object, name:String, children:Array=null, type:String=null)
		{
			this.item = item;
			this.children = children;
			this.name = name;
			this.type = type;
		}
	}
}