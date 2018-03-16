package components.tabNavigator
{
    import skins.tabNavigator.TabNavigatorWithOrientationSkin;

    import spark.containers.Navigator;
	import flash.events.Event;

	public class TabNavigatorWithOrientation extends Navigator 
	{
		public function TabNavigatorWithOrientation()
		{
			super();
			
			this.setStyle("skinClass", TabNavigatorWithOrientationSkin);
		}
		
		private var _orientation:String = "top";
		
		[Inspectable(enumeration="top,left,bottom,right", defaultValue="top")]
		[Bindable]
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
		
		[Bindable]
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
			
			if (state != "disabled")
			{
				switch (this.orientation)
				{
					case "top":
						state += "WithTopTabBar";
						break;
					case "left":
						state += scrollable ? "WithTopTabBar" : "WithLeftTabBar";
						break;
					case "right":
						state += scrollable ? "WithTopTabBar" : "WithRightTabBar";
						break;		
					case "bottom":
						state += "WithBottomTabBar";
						break;			
				}			
			}
			
			
			return state;
		}
	}
}