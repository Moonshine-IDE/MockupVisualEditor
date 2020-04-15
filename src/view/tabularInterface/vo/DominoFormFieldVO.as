package view.tabularInterface.vo
{
	[Bindable] public class DominoFormFieldVO
	{
		public static const ELEMENT_NAME:String = "field";
		
		public var name:String;
		public var label:String;
		public var description:String;
		public var type:String;
		public var editable:String;
		public var formula:String;
		public var sortOption:String;
		public var isMultiValue:Boolean;
		public var isIncludeInView:Boolean;
		
		public function DominoFormFieldVO()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC API
		//
		//--------------------------------------------------------------------------
		
		public function fromXML(value:XML, callback:Function=null):void
		{
			this.name = value.@name;
			this.type = value.@type;
			this.editable = value.@editable;
			this.formula = value.@formula;
			this.sortOption = value.@sortOption;
			this.isMultiValue = (value.@isMultiValue == "true") ? true : false;
			this.isIncludeInView = (value.@isIncludeInView == "true") ? true : false;
			
			this.label = value.label;
			this.description = value.description;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			
			xml.@name = name;
			xml.@type = type;
			xml.@editable = editable;
			xml.@formula = formula;
			xml.@sortOption = sortOption;
			xml.@isMultiValue = isMultiValue.toString();
			xml.@isIncludeInView = isIncludeInView.toString();
			
			var tempXML:XML = <label/>;
			tempXML.appendChild(new XML("\<![CDATA[" + label + "]]\>"));
			xml.appendChild(tempXML);
			
			tempXML = <description/>;
			tempXML.appendChild(new XML("\<![CDATA[" + description + "]]\>"));
			xml.appendChild(tempXML);
			
			return xml;
		}
		
		public function toCode():XML
		{
			return null;
		}
	}
}