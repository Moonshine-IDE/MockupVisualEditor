package view.primeFaces.supportClasses
{
    public class ContainerDirectionItem
    {
        public var direction:String = ContainerDirection.HORIZONTAL_LAYOUT;
        public var wrap:Boolean;
        public var gap:int;

        public function ContainerDirectionItem(direction:String = "Horizontal",
                                               gap:int = 0, wrap:Boolean = false)
        {
            this.direction = direction;
            this.gap = gap;
            this.wrap = wrap;
        }
    }
}
