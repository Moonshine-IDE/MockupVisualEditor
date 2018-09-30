package view.primeFaces.surfaceComponents.components
{
    import view.interfaces.INonDeletableSurfaceComponent;

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
    }
}
