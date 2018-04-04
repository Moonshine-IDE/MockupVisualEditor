package view.primeFaces.supportClasses
{
    import spark.layouts.HorizontalAlign;

    public class ContainerHorizontalAlignItem
    {
        public var horizontalAlign:String = HorizontalAlign.LEFT;

        public function ContainerHorizontalAlignItem(horizontalAlign:String = HorizontalAlign.LEFT)
        {
            this.horizontalAlign = horizontalAlign;
        }
    }
}
