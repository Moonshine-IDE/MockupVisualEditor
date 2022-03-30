package view.interfaces
{
	import data.OrganizerItem;

	public interface IDominoSurfaceComponent extends IGetChildrenSurfaceComponent
	{
		//function getComponentsChildren(...params):OrganizerItem; // shall be use to generate component tree
      	function get hide():String;
		function set hide(value:String):void

    }
}