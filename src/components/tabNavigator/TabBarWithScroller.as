package components.tabNavigator
{
    import skins.tabNavigator.TabBarWithScrollerSkin;

    import spark.components.TabBar;
	import flash.events.Event;

	public class TabBarWithScroller extends TabBar 
	{
		public function TabBarWithScroller()
		{
			super();
			
			this.setStyle("skinClass", TabBarWithScrollerSkin);
		}
		
		private var _orientation:String = "top";
		
		[Inspectable(enumeration="top,left,bottom,right", defaultValue="top")]
		[Bindable(event="orientationChanged")]
		public function get orientation():String
		{
			return _orientation;
		}
		
		public function set orientation(value:String):void
		{
			if (_orientation != value)
			{
				_orientation = value;
				dispatchEvent(new Event("orientationChanged"));
				this.invalidateSkinState();
			}
		}
		
		private var _scrollable:Boolean;
		
		[Bindable(event="scrollableChanged")]
		public function get scrollable():Boolean
		{
			return _scrollable;
		}
		
		public function set scrollable(value:Boolean):void
		{
			if (_scrollable != value)
			{
				_scrollable = value;
				dispatchEvent(new Event("scrollableChanged"));
				this.invalidateSkinState();
			}
		}
		
		override protected function getCurrentSkinState():String
		{
			var state:String = super.getCurrentSkinState();
			
			if (this.scrollable)
			{
				if (this.orientation == "top" || 
				    this.orientation == "left" || 
				    this.orientation == "right")
				{
					state += "WithTopScroller";	
				}
				else if (this.orientation == "bottom")
				{
					state += "WithBottomScroller";
				}
			}			
			
			return state;
		}
	}
}