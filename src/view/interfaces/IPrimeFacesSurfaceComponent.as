package view.interfaces
{
	import data.OrganizerItem;

	public interface IPrimeFacesSurfaceComponent extends ISurfaceComponent
	{
		function getComponentsChildren(...params):OrganizerItem; // shall be use to generate component tree
	}
}