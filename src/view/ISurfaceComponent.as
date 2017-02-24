package view
{
	import mx.core.IChildList;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;

	public interface ISurfaceComponent extends IUIComponent, IInvalidating, IChildList
	{
		function get propertyEditorClass():Class;
		function toXML():XML;
		function fromXML(value:XML, childFromXMLCallback:Function):void;
	}
}
