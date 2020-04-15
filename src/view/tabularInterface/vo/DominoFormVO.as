package view.tabularInterface.vo
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	
	[Bindable] 
	public class DominoFormVO extends EventDispatcher
	{
		public static const ELEMENT_NAME:String = "form";
		
		public var formName:String;
		public var viewName:String;
		public var hasWebAccess:Boolean;
		public var fields:ArrayCollection = new ArrayCollection();
		
		/**
		 * CONSTRUCTOR
		 */
		public function DominoFormVO()
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
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			xml.@hasWebAccess = hasWebAccess.toString();
			xml.@name = formName;
			
			var tempXML:XML = <viewName/>;
			tempXML.appendChild(new XML("\<![CDATA[" + viewName + "]]\>"));
			xml.appendChild(tempXML);
			
			tempXML = <fields/>;
			for each (var field:DominoFormFieldVO in fields)
			{
				tempXML.appendChild(field.toXML());
			}
			xml.appendChild(tempXML);
			
			return xml;
		}
		
		public function toCode():XML
		{
			return null;
		}
	}
}