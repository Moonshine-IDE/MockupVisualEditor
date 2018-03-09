package components
{
    import skins.ToggleImageButtonSkin;

    import spark.components.Image;
    import spark.components.ToggleButton;

    [Style(name="selectedIcon", type="Object")]
    [Style(name="unselectedIcon", type="Object")]

    public class ToggleImageButton extends ToggleButton
    {
        public function ToggleImageButton()
        {
            super();

            this.setStyle("skinClass", ToggleImageButtonSkin);
        }

        [SkinPart(required=true)]
        public var toggleImage:Image;

        override protected function partAdded(partName:String, instance:Object):void
        {
            super.partAdded(partName, instance);

            if (instance == toggleImage)
            {
                toggleImage.source = selected ? this.getStyle("selectedIcon") : this.getStyle("unselectedIcon");
            }
        }

        override protected function buttonReleased():void
        {
            super.buttonReleased();

            toggleImage.source = selected ? this.getStyle("selectedIcon") : this.getStyle("unselectedIcon");
        }
    }
}
