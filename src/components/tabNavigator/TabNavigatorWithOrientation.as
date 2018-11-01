package components.tabNavigator
{
    import flash.events.Event;
    import flash.text.TextLineMetrics;
    
    import spark.components.ButtonBarButton;
    import spark.components.Label;
    import spark.components.NavigatorContent;
    import spark.containers.Navigator;
    
    import skins.tabNavigator.TabNavigatorWithOrientationSkin;

    public class TabNavigatorWithOrientation extends Navigator
	{
		public function TabNavigatorWithOrientation()
		{
			super();

			this.setStyle("skinClass", TabNavigatorWithOrientationSkin);
		}
		
		protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
		{
			throw new Error("needs to be override in an ISurfaceComponent class.");
		}

		[SkinPart(required=true)]
		public var tabBar:TabBarWithScroller;

		private var _orientation:String = "top";
		
		[Inspectable(enumeration="top,left,bottom,right", defaultValue="top")]
		[Bindable("orientationChanged")]
		public function get orientation():String
		{
			return _orientation;
		}
		
		public function set orientation(value:String):void
		{
			if (_orientation != value)
			{
				updatePropertyChangeReference("orientation", _orientation, value);
				
				_orientation = value;
				dispatchEvent(new Event("orientationChanged"));
				this.invalidateSkinState();
			}
		}
		
		private var _scrollable:Boolean;
		[Bindable("scrollableChanged")]
		public function get scrollable():Boolean
		{
			return _scrollable;	
		}		
		
		public function set scrollable(value:Boolean):void
		{
			if (_scrollable != value)
			{
				updatePropertyChangeReference("scrollable", _scrollable, value);
				
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

		public function setSelectedTabLabel(label:String):void
		{
			var selectedTab:NavigatorContent = (this.selectedItem as NavigatorContent);
			
			if (selectedTab.label != label)
			{
				var isLabelBlank:Boolean;
				var item:ButtonBarButton = tabBar.dataGroup.getElementAt(this.selectedIndex) as ButtonBarButton;
				
				updatePropertyChangeReference("label", [{field:selectedIndex, value:selectedTab.label}, {field:selectedIndex, value:item.label}], [{field:selectedIndex, value:label}, {field:selectedIndex, value:label}]);

				if (item.label == "") isLabelBlank = true;
				selectedTab.label = label;
				item.label = label;
				
				// Do not perform these action unless previous
				// label value was blank; for some reason when label is blank
				// item.labelDisplay starts with width/height 0/0
				if (isLabelBlank)
				{
					// note:
					// invalidateSize or invalidateDisplaylist doesn't seem affects at this pos.
					// as per usual behavior the tab is suppose to be widen based upon label width.
					// we need a way to determine the text length and update
					// the size to item.labelDisplay to properly sized
					item.labelDisplay['width'] = this.measureText(label).width + 10;
					item.labelDisplay['height'] = 20;
					item.invalidateDisplayList();
				}
				
				dispatchEvent(new Event("itemUpdated"));
			}
		}
	}
}