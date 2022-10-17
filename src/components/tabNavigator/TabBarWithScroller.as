////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2016-present Prominic.NET, Inc.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the Server Side Public License, version 1,
//  as published by MongoDB, Inc.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  Server Side Public License for more details.
//
//  You should have received a copy of the Server Side Public License
//  along with this program. If not, see
//
//  http://www.mongodb.com/licensing/server-side-public-license
//
//  As a special exception, the copyright holders give permission to link the
//  code of portions of this program with the OpenSSL library under certain
//  conditions as described in each individual source file and distribute
//  linked combinations including the program with the OpenSSL library. You
//  must comply with the Server Side Public License in all respects for
//  all of the code used other than as permitted herein. If you modify file(s)
//  with this exception, you may extend this exception to your version of the
//  file(s), but you are not obligated to do so. If you do not wish to do so,
//  delete this exception statement from your version. If you delete this
//  exception statement from all source files in the program, then also delete
//  it in the license file.
//
////////////////////////////////////////////////////////////////////////////////
package components.tabNavigator
{
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;

    import skins.tabNavigator.TabBarWithScrollerSkin;

    import spark.components.ButtonBarButton;

    import spark.components.TabBar;
	import flash.events.Event;

	public class TabBarWithScroller extends TabBar 
	{
        private var _maxElementCountWithoutScroller:int;

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
                this.refreshMaxElementCountWithoutScroller();
                this.invalidateSkinState();
            }
        }

        override protected function getCurrentSkinState():String
        {
            var state:String = super.getCurrentSkinState();

            if (this.scrollable)
            {
                if (this.dataGroup && _maxElementCountWithoutScroller < this.dataGroup.numElements)
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
                else
                {
                    state = "normal";
                }
            }
            else if (this.orientation == "left" || this.orientation == "right")
            {
                state = "normalWithLeftRightNoScroller";
            }

            return state;
        }

        override protected function measure():void
        {
            super.measure();

            this.refreshMaxElementCountWithoutScroller();
        }

        override protected function dataProvider_collectionChangeHandler(event:Event):void
        {
            super.dataProvider_collectionChangeHandler(event);

            var collectionEvent:CollectionEvent = event as CollectionEvent;
            if (collectionEvent.kind == CollectionEventKind.ADD || collectionEvent.kind == CollectionEventKind.REMOVE)
            {
                this.invalidateSkinState();
            }
        }

        private function refreshMaxElementCountWithoutScroller():void
        {
            if (this.dataGroup && this.scrollable)
            {
                var typicalItem:ButtonBarButton = this.dataGroup.getElementAt(0) as ButtonBarButton;
                if (typicalItem && _maxElementCountWithoutScroller == 0)
                {
                    _maxElementCountWithoutScroller = this.measuredWidth / typicalItem.measuredWidth;
                    this.invalidateSkinState();
                }
            }
        }
    }
}