package view.primeFaces.supportClasses
{
    import spark.layouts.VerticalAlign;

    public class ContainerVerticalAlignItem
    {
        public var verticalAlign:String = VerticalAlign.TOP;

        public function ContainerVerticalAlignItem(verticalAlign:String = VerticalAlign.TOP)
        {
            this.verticalAlign = verticalAlign;
        }
    }
}
