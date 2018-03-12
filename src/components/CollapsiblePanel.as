package components
{
    import flash.events.*;

    import mx.effects.AnimateProperty;
    import mx.events.*;
    import mx.events.EffectEvent;

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

        public function CollapsiblePanel(isOpen:Boolean = true):void
        {
            super();

            open = isOpen;
            this.addEventListener(FlexEvent.CREATION_COMPLETE, onCollapsiblePanelCreationComplete);
        }

        protected function onTitleDisplayClick(event:MouseEvent):void
        {
            toggleOpen();
        }

        private function onOpenAnimEffectEnd(event:EffectEvent):void
        {
            contentGroup.visible = contentGroup.includeInLayout = this.open;
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
        private function get openHeight():Number
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
                _openAnim.fromValue = _openAnim.target.height;
                if (!_open)
                {
                    _openAnim.toValue = this.openHeight;
                    _open = true;
                    dispatchEvent(new Event("openChanged"));
                    dispatchEvent(new Event(Event.OPEN));
                }
                else
                {
                    _openAnim.toValue = _openAnim.target.closedHeight;
                    _open = false;
                    dispatchEvent(new Event("openChanged"));
                    dispatchEvent(new Event(Event.CLOSE));
                }
                _openAnim.play();
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
                _open = value;
                openChanged = true;
                dispatchEvent(new Event("openChanged"));
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
        }
        /**
         * @private
         */
        override public function invalidateSize():void
        {
            super.invalidateSize();
            if (_openAnim && !_openAnim.isPlaying)
            {
                if (_open)
                {
                    this.height = openHeight;
                }
            }

        }

        protected function onCollapsiblePanelCreationComplete(event:FlexEvent):void
        {
            this.removeEventListener(FlexEvent.CREATION_COMPLETE, onCollapsiblePanelCreationComplete);

            _openAnim = new AnimateProperty(this);
            _openAnim.addEventListener(EffectEvent.EFFECT_END, onOpenAnimEffectEnd);
            _openAnim.duration = 100;
            _openAnim.property = "height";

            titleDisplay.addEventListener(MouseEvent.CLICK, onTitleDisplayClick);
        }
    }
}