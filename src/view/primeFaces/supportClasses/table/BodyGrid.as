package view.primeFaces.supportClasses.table
{
    import view.primeFaces.supportClasses.*;
	import view.suportClasses.GridBase;

	public class BodyGrid extends GridBase
    {
        public function BodyGrid()
        {
            super();

            this.setStyle("borderVisible", false);
            this.setStyle("verticalGap", -2);
            this.setStyle("horizontalGap", -2);
        }
    }
}
