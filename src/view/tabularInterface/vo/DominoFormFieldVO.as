package view.tabularInterface.vo
{
	[Bindable] public class DominoFormFieldVO
	{
		public var name:String;
		public var label:String;
		public var description:String;
		public var type:String;
		public var editable:String;
		public var formula:String;
		public var sortOption:String;
		public var isMultiValue:Boolean;
		public var isIncludeInView:Boolean;
		
		public function DominoFormFieldVO()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC API
		//
		//--------------------------------------------------------------------------
		
		public function fromXML(value:XML, callback:Function=null):void
		{
			
		}
		
		public function toXML():XML
		{
			return null;
		}
		
		public function toCode():XML
		{
			return null;
		}
	}
}