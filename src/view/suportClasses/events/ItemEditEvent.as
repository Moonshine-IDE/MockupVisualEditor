package view.suportClasses.events
{
	import flash.events.Event;
	
	public class ItemEditEvent extends Event
	{
		public static const EDIT_ITEM:String = "editItem";
		
		public var value:Object;
		
		public function ItemEditEvent(type:String, value:Object=null, _bubble:Boolean=false, _cancelable:Boolean=true)
		{
			this.value = value;
			super(type, _bubble, _cancelable);
		}
		
		override public function clone():Event
		{
			return new ItemEditEvent(type, value, bubbles, cancelable);
		}
	}
}
