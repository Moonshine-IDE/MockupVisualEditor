package view.interfaces
{
	import view.suportClasses.PropertyChangeReference;

	public interface IHistorySurfaceComponent
	{
		/**
		 * Returns last edited field reference
		 */
		function get propertyChangeFieldReference():PropertyChangeReference;
		function set propertyChangeFieldReference(value:PropertyChangeReference):void;
		
		/**
		 * Restore value against a given field from history manager
		 */
		function restorePropertyOnChangeReference(nameField:String, value:*):void;
		
		/**
		 * Handles by the history manager during a process
		 */
		function get isUpdating():Boolean;
		function set isUpdating(value:Boolean):void;
	}
}
