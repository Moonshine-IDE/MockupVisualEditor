package data
{
	public class OrganizerItem
	{
		public var item:Object;
		public var children:Array;
		public var name:String;
		
		public function OrganizerItem(item:Object, name:String, children:Array=null)
		{
			this.item = item;
			this.children = children;
			this.name = name;
		}
	}
}