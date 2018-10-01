package view.primeFaces.surfaceComponents.components
{
    import view.interfaces.INonDeletableSurfaceComponent;
    import view.interfaces.IPercentSizeValues;

    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="updateDisplayList", kind="method")]
    [Exclude(name="widthPercent", kind="property")]
    [Exclude(name="heightPercent", kind="property")]

    /**
     * <p>This component is special representation of Div, which is root component for newly created file.</p>
     *
     * @see view.primeFaces.surfaceComponents.components.Div
     */
    public class RootDiv extends Div implements INonDeletableSurfaceComponent, IPercentSizeValues
    {
        public static var ELEMENT_NAME:String = "RootDiv";

        public function RootDiv()
        {
            super();
        }

        override public function toXML():XML
        {
            mainXML = new XML("<RootDiv/>");

            return this.internalToXML();
        }

        private var _widthPercent:Number;

        public function get widthPercent():Number
        {
            return _widthPercent;
        }

        private var  _heightPercent:Number;

        public function get heightPercent():Number
        {
            return _heightPercent;
        }

        override public function set percentHeight(value:Number):void
        {
            if (isNaN(value))
            {
                if (super.percentHeight != value)
                {
                    _heightPercent = super.percentHeight;
                }
            }
            super.percentHeight = value;
        }

        override public function set percentWidth(value:Number):void
        {
            if (isNaN(value))
            {
                if (super.percentWidth != value)
                {
                    _widthPercent = super.percentWidth;
                }
            }
            super.percentWidth = value;
        }

        override public function fromXML(xml:XML, callback:Function):void
        {
            super.fromXML(xml, callback);

            contentChanged = true;
            this.invalidateDisplayList();
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (contentChanged)
            {
                resetPercentWidthHeightBasedOnLayout();
                contentChanged = false;
            }
        }
    }
}
