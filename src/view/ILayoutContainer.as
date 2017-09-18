package view
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;

	/**
	 * Dispatched when the selectedIndex property changes.
	 * 
	 * @eventType spark.events.IndexChangeEvent.CHANGE
	 */
	[Event(name="change",type="spark.events.IndexChangeEvent")]

	public interface ILayoutContainer extends ISurfaceComponent
	{
		[Bindable("change")]
		function get backgroundColor():uint;
		function set backgroundColor(value:uint):void;
		
		[Bindable("change")]
		function get layoutType():String;
		function set layoutType(value:String):void;
		
		function get layoutTypes():ArrayList;
		
		[Bindable("change")]
		function get containerType():String;
		function set containerType(value:String):void;
		
		function get containerTypes():ArrayList;
		
		[Bindable("change")]
		function get containerStyles():Dictionary;
		function set containerStyles(value:Dictionary):void;
	}
}
