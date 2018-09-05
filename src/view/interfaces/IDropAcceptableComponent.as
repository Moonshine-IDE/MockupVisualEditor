package view.interfaces
{
	import mx.core.IVisualElement;
	
	public interface IDropAcceptableComponent
	{
		function dropElementAt(element:IVisualElement, index:int):void;
	}
}
