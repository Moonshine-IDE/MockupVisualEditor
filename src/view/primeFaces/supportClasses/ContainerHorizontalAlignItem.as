package view.primeFaces.supportClasses
{
    import spark.layouts.HorizontalAlign;

    public class ContainerHorizontalAlignItem
    {
        public var horiztonalAlign:String = HorizontalAlign.LEFT;

        public function ContainerHorizontalAlignItem(horizontalAlign:String = HorizontalAlign.LEFT)
        {
            this.horiztonalAlign = horizontalAlign;
        }
    }
}
