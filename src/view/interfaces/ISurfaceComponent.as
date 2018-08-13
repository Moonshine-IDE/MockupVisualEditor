package view.interfaces
{
	import mx.core.IChildList;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	
	public interface ISurfaceComponent extends IUIComponent, IInvalidating, IChildList
	{
        /**
		 * Represents UI reflection to the properties which user is allowed to modify in property editor
         */
		function get propertyEditorClass():Class;

        /**
		 * Helper function which returns lists of events to track whether user changed any value in property editor
         */
		function get propertiesChangedEvents():Array;

        /**
		 * Translates component to Visual Editor XML format
		 *
         * @return Visual Editor XML format
         */
		function toXML():XML;

        /**
		 * Reads Visual Editor XML and translates it to component
		 *
         * @param value Visual Editor XML
         * @param childFromXMLCallback Notification function
         */
		function fromXML(xml:XML, childFromXMLCallback:Function):void;

        /**
		 * Translates component to technology specific XML (Flex MXML, PrimeFaces XML)
		 *
         * @return Technology specific XML
         */
		function toCode():XML;
		
		/**
		 * Help to determine if 'self' is currently selected on the stage 
		 */
		function get isSelected():Boolean;
		function set isSelected(value:Boolean):void;
	}
}
