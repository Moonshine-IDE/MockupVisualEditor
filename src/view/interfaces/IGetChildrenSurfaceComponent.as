package view.interfaces
{
	import data.OrganizerItem;

	public interface IGetChildrenSurfaceComponent extends ISurfaceComponent
	{
		function getComponentsChildren(...params):OrganizerItem; // shall be use to generate component tree
	}
}