package view.interfaces
{
    import view.*;
	import mx.core.IVisualElement;

	public interface IPropertyEditor extends IVisualElement
	{
		function get surface():EditingSurface;
		function set surface(value:EditingSurface):void;
		function get selectedItem():ISurfaceComponent;
		function set selectedItem(value:ISurfaceComponent):void;
	}
}
