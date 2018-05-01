package view.interfaces
{
	import mx.core.IChildList;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	
	import view.models.PropertyChangeReferenceVO;

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
		 * Returns last edited field reference
		 */
		//function get propertyChangeFieldReference():ChangeFieldReferenceVO;
		
		/**
		 * Restore value against a given field from history manager
		 */
		//function restorePropertyOnChangeReference(nameField:String, value:*):void;
		
		/**
		 * Handles by the history manager during a process
		 */
		//public function get isUpdating():Boolean;
		//public function set isUpdating(value:Boolean):void;

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
	}
}
