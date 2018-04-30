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

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (toggleImage)
            {
                toggleImage.source = selected ? this.getStyle("selectedIcon") : this.getStyle("unselectedIcon");
            }
        }
    }
}
