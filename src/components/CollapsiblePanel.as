package components
{

    import flash.events.*;

    import mx.effects.AnimateProperty;
    import mx.events.*;
    import mx.events.EffectEvent;

    import spark.components.Label;
    import spark.components.Panel;


    /**
     * The icon designating a "closed" state
     */
    [Style(name="closedIcon", type="Object")]

    /**
     * The icon designating an "open" state
     */
    [Style(name="openIcon", type="Object")]

    /**
     * This is a Panel that can be collapsed and expanded by clicking on the header.
     *
     * @author Ali Rantakari
     */
    public class CollapsiblePanel extends Panel
    {
        private var _open:Boolean = true;
        private var openChanged:Boolean;

        private var _openAnim:AnimateProperty;

        public function CollapsiblePanel(isOpen:Boolean = true):void
        {
            super();

            this.setStyle("dropShadowVisible", false);
            open = isOpen;
            this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }

        private function creationCompleteHandler(event:FlexEvent):void
        {
            this.removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);

            _openAnim = new AnimateProperty(this);
            _openAnim.addEventListener(EffectEvent.EFFECT_END, onOpenAnimEffectEnd);
            _openAnim.duration = 100;
            _openAnim.property = "height";


            titleDisplay.addEventListener(MouseEvent.CLICK, onTitleDisplayClick);
        }

        private function onTitleDisplayClick(event:MouseEvent):void
        {
            toggleOpen();
        }

        private function onOpenAnimEffectEnd(event:EffectEvent):void
        {
            contentGroup.visible = contentGroup.includeInLayout = this.open;
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

            return (titleDisplay as Label).height;
        }

        /**
         * sets the correct title icon
         */
        private function setTitleIcon():void
        {
            /*if (!_open)
            {
                this.titleIcon = getStyle("closedIcon");
            }
            else
            {
                this.titleIcon = getStyle("openIcon");
            }*/
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
                    _openAnim.toValue = openHeight;
                    _open = true;
                    dispatchEvent(new Event(Event.OPEN));
                }
                else
                {
                    _openAnim.toValue = _openAnim.target.closedHeight;
                    _open = false;
                    dispatchEvent(new Event(Event.CLOSE));
                }
                setTitleIcon();
                _openAnim.play();
            }
        }

        /**
         * Whether the block is in a expanded (open) state or not
         */
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
            if (_open && _openAnim && !_openAnim.isPlaying)
            {
                this.height = openHeight;
            }
        }
    }
}