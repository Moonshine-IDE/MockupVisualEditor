package view.suportClasses.events
{
	import flash.events.Event;
	
	public class ItemEditedEvent extends Event
	{
		public static const ITEM_EDITED:String = "editedItem";
		
		public var oldValue:Object;
		public var newValue:Object;
		
		public function ItemEditedEvent(type:String, nvalue:Object, ovalue:Object=null, _bubble:Boolean=false, _cancelable:Boolean=true)
		{
			this.oldValue = ovalue;
			this.newValue = nvalue;
			super(type, _bubble, _cancelable);
		}
		
		override public function clone():Event
		{
			return new ItemEditedEvent(type, newValue, oldValue, bubbles, cancelable);
		}
	}
}
