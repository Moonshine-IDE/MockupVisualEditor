package data
{
    import mx.collections.ArrayList;

    [Bindable]
    public class GridListItem
    {
        public var label:String;
        public var value:int = 1;
        public var columns:ArrayList = new ArrayList();

        public function GridListItem(label:String, value:int = 1)
        {
            this.label = label;
            this.value = value;
        }
    }
}
