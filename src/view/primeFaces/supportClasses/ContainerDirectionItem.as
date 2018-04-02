package view.primeFaces.supportClasses
{
    public class ContainerDirectionItem
    {
        public var direction:String = ContainerDirection.HORIZONTAL_LAYOUT;
        public var wrap:Boolean;
        public var gap:int = 0;

        public function ContainerDirectionItem(direction:String = ContainerDirection.HORIZONTAL_LAYOUT,
                                               gap:int = 0, wrap:Boolean = false)
        {
            this.direction = direction;
            this.gap = gap;
            this.wrap = wrap;
        }
    }
}
