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
package view.primeFaces.supportClasses
{
    import flash.events.Event;

    import spark.components.BorderContainer;
    import spark.layouts.HorizontalLayout;
    import spark.layouts.VerticalLayout;
    
    import components.FlowLayout;

    [ExcludeClass("Container")]

    public class Container extends BorderContainer
    {
        public static const ELEMENT_NAME:String = "Container";

        public function Container()
        {
            super();

            if (this.wrap)
            {
                this.setFlowLayout();
            }
            else
            {
                this.setHoriztonalLayout();
            }
        }
		
		protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
		{
			throw new Error("needs to be override in an ISurfaceComponent class.");
		}
		
        private var _direction:String = "Horizontal";
        private var directionChanged:Boolean;
		
		[Bindable("directionChanged")]
        [Inspectable(enumeration="Horizontal,Vertical", defaultValue="Horizontal")]
        public function get direction():String
        {
            return _direction;
        }
		
        public function set direction(value:String):void
        {
            if (_direction != value)
            {
				updatePropertyChangeReference("direction", _direction, value);

                _direction = value;
                this.directionChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("directionChanged", true));
            }
        }

        protected var _wrap:Boolean;
        private var wrapChanged:Boolean;


        public function set borderWeight(value:int):void {
           super.setStyle("borderWeight",0);
        }
		
		[Bindable("wrapChanged")]
        public function get wrap():Boolean
        {
            return _wrap;
        }
        public function set wrap(value:Boolean):void
        {
            if (_wrap != value)
            {
				updatePropertyChangeReference("wrap", _wrap, value);
				
                _wrap = value;
                this.directionChanged = true;
                this.wrapChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("wrapChanged", true));
            }
        }

        private var _gap:int;
        private var gapChanged:Boolean;
		
		[Bindable("gapChanged")]
        [Inspectable(defaultValue="0")]
        public function get gap():int
        {
            return _gap;
        }

        public function set gap(value:int):void
        {
            if (_gap != value)
            {
				updatePropertyChangeReference("gap", _gap, value);
				
                _gap = value;
                this.gapChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("gapChanged", true));
            }
        }

        private var alignChanged:Boolean;

        private var _verticalAlign:String = "top";
		
		[Bindable("verticalAlignChanged")]
        [Inspectable(enumeration="top,bottom,middle", defaultValue="top")]
        public function get verticalAlign():String
        {
            return _verticalAlign;
        }

        public function set verticalAlign(value:String):void
        {
            if (_verticalAlign != value)
            {
				updatePropertyChangeReference("verticalAlign", _verticalAlign, value);
				
                _verticalAlign = value;
                this.alignChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("verticalAlignChanged", true));
            }
        }

        private var _horizontalAlign:String = "left"; // center, right
		
		[Bindable("horizontalAlignChanged")]
        [Inspectable(enumeration="left,right,center", defaultValue="left")]
        public function get horizontalAlign():String
        {
            return _horizontalAlign;
        }

        public function set horizontalAlign(value:String):void
        {
            if (_horizontalAlign != value)
            {
				updatePropertyChangeReference("horizontalAlign", _horizontalAlign, value);
				
                _horizontalAlign = value;
                this.alignChanged = true;

                this.invalidateDisplayList();
                this.dispatchEvent(new Event("horizontalAlignChanged", true));
            }
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (this.directionChanged && !this.wrap)
            {
                if (direction == ContainerDirection.HORIZONTAL_LAYOUT)
                {
                    this.setHoriztonalLayout();
                }
                else if (direction == ContainerDirection.VERTICAL_LAYOUT)
                {
                    this.setVerticalLayout();
                }
                this.directionChanged = false;
            }

            if (this.wrapChanged)
            {
                this.setFlowLayout();

                this.directionChanged = false;
                this.wrapChanged = false;
            }

            if (this.gapChanged)
            {
                this.setGapLayout();

                this.gapChanged = false;
            }

            if (this.alignChanged)
            {
                this.setLayoutAlign();

                this.alignChanged = false;
            }
        }

        protected function setHoriztonalLayout():void
        {
            var hLayout:HorizontalLayout = new HorizontalLayout();
            hLayout.gap = this.gap;

            this.layout = hLayout;

            this.setLayoutAlign();
        }

        protected function setVerticalLayout():void
        {
            var hLayout:VerticalLayout = new VerticalLayout();
            hLayout.gap = this.gap;

            this.layout = hLayout;

            this.setLayoutAlign();
        }

        private function setFlowLayout():void
        {
            if (!this.wrap) return;

            var flowLayout:FlowLayout = new FlowLayout();
            flowLayout.horizontalGap = this.gap;

            this.layout = flowLayout;

            this.setLayoutAlign();
        }

        private function setGapLayout():void
        {
            if (this.wrap)
            {
                (this.layout as FlowLayout).horizontalGap = this.gap;
            }
            else if (direction == ContainerDirection.HORIZONTAL_LAYOUT)
            {
                (this.layout as HorizontalLayout).gap = this.gap;
            }
            else if (direction == ContainerDirection.VERTICAL_LAYOUT)
            {
                (this.layout as VerticalLayout).gap = this.gap;
            }
        }

        private function setLayoutAlign():void
        {
            if (this.wrap)
            {
                (this.layout as FlowLayout).horizontalAlign = this.horizontalAlign;
                (this.layout as FlowLayout).verticalAlign = this.verticalAlign;
            }
            else if (direction == ContainerDirection.HORIZONTAL_LAYOUT)
            {
                (this.layout as HorizontalLayout).horizontalAlign = this.horizontalAlign;
                (this.layout as HorizontalLayout).verticalAlign = this.verticalAlign;
            }
            else if (direction == ContainerDirection.VERTICAL_LAYOUT)
            {
                (this.layout as VerticalLayout).horizontalAlign = this.horizontalAlign;
                (this.layout as VerticalLayout).verticalAlign = this.verticalAlign;
            }
        }
    }
}
