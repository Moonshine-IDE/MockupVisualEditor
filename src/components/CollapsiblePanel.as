////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) STARTcloud, Inc. 2015-2022. All rights reserved.
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
package components
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import mx.effects.AnimateProperty;
    import mx.events.EffectEvent;
    import mx.events.FlexEvent;
    
    import spark.components.Label;
    import spark.components.Panel;

    /**
     * This is a Panel that can be collapsed and expanded by clicking on the header.
     */
    public class CollapsiblePanel extends Panel
    {
        private var _open:Boolean = true;
        private var openChanged:Boolean;

        private var _openAnim:AnimateProperty;
        private var _duration:Number = 200;
        private var durationChanged:Boolean;

        protected var isCollapsible:Boolean = true;

        public function CollapsiblePanel(isOpen:Boolean = true):void
        {
            super();

            open = isOpen;
            this.addEventListener(FlexEvent.CREATION_COMPLETE, onCollapsiblePanelCreationComplete);
        }
		
		protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
		{
			throw new Error("needs to be override in an ISurfaceComponent class.");
		}
		
		protected function updateIsUpdating(value:Boolean):void
		{
			throw new Error("needs to be override in an ISurfaceComponent class.");
		}

        protected function onTitleDisplayClick(event:MouseEvent):void
        {
            toggleOpen();
        }

        private function onOpenAnimEffectEnd(event:EffectEvent):void
        {
            contentGroup.visible = contentGroup.includeInLayout = this.open;
			updateIsUpdating(false);
        }
		
		public function get isAnimationPlaying():Boolean
		{
			return _openAnim.isPlaying;
		}

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        override public function get height():Number
        {
            if (!open && _openAnim && !_openAnim.isPlaying)
            {
                return _openAnim.toValue;
            }

            return super.height;
        }

        /**
         * the height that the component should be when open
         */
        protected function get openHeight():Number
        {
            return measuredHeight;
        }

        /**
         * the height that the component should be when closed
         */
        private function get closedHeight():Number
        {
            if (!titleDisplay) return Number.NaN;

            return (titleDisplay as Label).height + 5;
        }

        /**
         * Collapses / expands this block (with animation)
         */
        public function toggleOpen():void
        {
            if (!contentGroup) return;

            if (!_openAnim.isPlaying)
            {
				updatePropertyChangeReference("open", _open, !_open);
				
                _openAnim.fromValue = _openAnim.target.height;
                if (!_open)
                {
                    _openAnim.toValue = this.openHeight;
                    _open = true;
                    dispatchEvent(new Event(Event.OPEN));
                }
                else
                {
                    _openAnim.toValue = _openAnim.target.closedHeight;
                    _open = false;
                    dispatchEvent(new Event(Event.CLOSE));
                }

				dispatchEvent(new Event("openChanged"));
                _openAnim.play();
            }
        }

        [Inspectable(defaultValue="200")]
		[Bindable(event="durationChanged")]
        public function get duration():Number
        {
            return _duration;
        }

        public function set duration(value:Number):void
        {
            if (_duration != value)
            {
				updatePropertyChangeReference("duration", _duration, value);
				
                _duration = value;
                durationChanged = true;
                invalidateProperties();
				
				dispatchEvent(new Event("durationChanged"));
            }
        }

        /**
         * Whether the block is in a expanded (open) state or not
         */
        [Bindable(event="openChanged")]
        public function get open():Boolean
        {
            return _open;
        }

        /**
         * @private
         */
        public function set open(value:Boolean):void
        {
            if (_open != value)
            {
				updateIsUpdating(true);
                openChanged = true;
                invalidateProperties();
            }
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (this.openChanged)
            {
                toggleOpen();
                this.openChanged = false;
            }

            if (this.durationChanged)
            {
                if (_openAnim && !_openAnim.isPlaying)
                {
                    _openAnim.duration = this.duration;
                }
                this.durationChanged = false;
            }
        }
        /**
         * @private
         */
        override public function invalidateSize():void
        {
            super.invalidateSize();
            if (_openAnim && !_openAnim.isPlaying)
            {
                if (_open && isCollapsible)
                {
                    this.height = openHeight;
                }
            }
        }

        protected function onCollapsiblePanelCreationComplete(event:FlexEvent):void
        {
            this.removeEventListener(FlexEvent.CREATION_COMPLETE, onCollapsiblePanelCreationComplete);

            _openAnim = new AnimateProperty(this);
            _openAnim.addEventListener(EffectEvent.EFFECT_END, onOpenAnimEffectEnd, false, 0, true);
            _openAnim.duration = this.duration;
            _openAnim.property = "height";

            titleDisplay.addEventListener(MouseEvent.CLICK, onTitleDisplayClick);
        }
    }
}