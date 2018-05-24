package view.interfaces
{
	public interface IHistorySurfaceCustomHandlerComponent extends IHistorySurfaceComponent
	{
		/**
		 * Custom handler function
		 */
		function restorePropertyOnChangeReference(nameField:String, value:*):void;
	}
}
