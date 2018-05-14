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
		 * Handles by the history manager during a process
		 */
		function get isUpdating():Boolean;
		function set isUpdating(value:Boolean):void;
	}
}
