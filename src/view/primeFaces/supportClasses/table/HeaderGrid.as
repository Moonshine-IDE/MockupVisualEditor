package view.primeFaces.supportClasses.table
{
    import view.primeFaces.supportClasses.*;

    public class HeaderGrid extends GridBase
    {
        public function HeaderGrid()
        {
            super();

            this.setStyle("borderVisible", false);
            this.setStyle("verticalGap", -2);
            this.setStyle("horizontalGap", -2);
        }

        override public function isEmpty():Boolean
        {
            return false;
        }
    }
}
