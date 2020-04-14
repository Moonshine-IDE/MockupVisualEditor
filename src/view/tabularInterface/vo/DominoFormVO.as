package view.tabularInterface.vo
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;

	[Bindable] 
	public class DominoFormVO extends EventDispatcher
	{
		public var formName:String;
		public var viewName:String;
		public var isWebForm:Boolean;
		public var fields:ArrayCollection = new ArrayCollection();
		
		/**
		 * CONSTRUCTOR
		 */
		public function DominoFormVO()
		{
		}
		
		public function tempGenerateFields():void
		{
			var tmpVO:DominoFormFieldVO = new DominoFormFieldVO();
			tmpVO.name = "udgandu";
			fields.addItem(tmpVO);
			
			tmpVO = new DominoFormFieldVO();
			tmpVO.name = "tiledhemna";
			fields.addItem(tmpVO);
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