package view
{
	import mx.core.INavigatorContent;

	import spark.components.SkinnableContainer;

	/**
	 * Dispatched when the selectedIndex property changes.
	 * 
	 * @eventType spark.events.IndexChangeEvent.CHANGE
	 */
	[Event(name="change",type="spark.events.IndexChangeEvent")]

	public interface IMultiViewContainer extends ISurfaceComponent
	{
		[Bindable("change")]
		function get selectedView():SkinnableContainer;

		[Bindable("change")]
		function get selectedIndex():int;
		function set selectedIndex(value:int):void;

		function get numViews():int;

		function getViewAt(index:int):SkinnableContainer;
	}
}
