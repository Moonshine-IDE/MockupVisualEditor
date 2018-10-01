package view.primeFaces.surfaceComponents.components
{
    import view.interfaces.INonDeletableSurfaceComponent;

    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="updateDisplayList", kind="method")]
    
    /**
     * <p>This component is special representation of Div, which is root component for newly created file.</p>
     *
     * @see view.primeFaces.surfaceComponents.components.Div
     */
    public class RootDiv extends Div implements INonDeletableSurfaceComponent
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
