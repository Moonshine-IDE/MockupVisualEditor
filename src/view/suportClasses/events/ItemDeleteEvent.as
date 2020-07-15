package view.suportClasses.events
{
	import flash.events.Event;
	
	public class ItemDeleteEvent extends Event
	{
		public static const DELETE_ITEM:String = "deleteItem";
		
		public var value:Object;
		
		public function ItemDeleteEvent(type:String, value:Object=null, _bubble:Boolean=false, _cancelable:Boolean=true)
		{
			this.value = value;
			super(type, _bubble, _cancelable);
		}
		
		override public function clone():Event
		{
			return new ItemDeleteEvent(type, value, bubbles, cancelable);
		}
	}
}
