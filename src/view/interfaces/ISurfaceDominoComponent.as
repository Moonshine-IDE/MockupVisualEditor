package view.interfaces
{
    import interfaces.IComponent;
	import interfaces.IDominoComponent;

    import mx.core.IChildList;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	
	public interface ISurfaceDominoComponent extends IUIComponent, IInvalidating, IChildList, IDominoComponent
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
		 * Help to determine if 'self' is currently selected on the stage 
		 */
		function get isSelected():Boolean;
		function set isSelected(value:Boolean):void;

	}
}
