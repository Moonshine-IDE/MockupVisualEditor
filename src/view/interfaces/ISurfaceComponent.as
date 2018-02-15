package view.interfaces
{
	import mx.core.IChildList;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;

	public interface ISurfaceComponent extends IUIComponent, IInvalidating, IChildList
	{
		function get propertyEditorClass():Class;
		function get propertiesChangedEvents():Array;
		
		function toXML():XML;
		function fromXML(value:XML, childFromXMLCallback:Function):void;
		function toCode():XML;
	}
}
