package view.dominoFormBuilder.vo
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	
	import components.GridItem;
	import components.GridRow;
	import components.domino.DominoLabel;
	import components.domino.DominoTable;
	import components.domino.formBuilder.DominoFormField;
	import components.primeFaces.Div;
	
	[Bindable] 
	public class DominoFormVO extends EventDispatcher
	{
		public static const ELEMENT_NAME:String = "form";
		
		public var formName:String;
		public var viewName:String;
		public var hasWebAccess:Boolean;
		public var fields:ArrayCollection = new ArrayCollection();
		
		/**
		 * CONSTRUCTOR
		 */
		public function DominoFormVO()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  PUBLIC API
		//
		//--------------------------------------------------------------------------
		
		public function fromXML(value:XML, callback:Function=null):void
		{
			this.formName = value.form.@name;
			this.hasWebAccess = (value.form.@hasWebAccess == "true") ? true : false;
			this.viewName = value.form.viewName;
			
			for each (var field:XML in value.form.fields.field)
			{
				var tmpField:DominoFormFieldVO = new DominoFormFieldVO();
				tmpField.fromXML(field);
				fields.addItem(tmpField);
			}
			
			if (callback != null)
			{
				callback();
			}
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			xml.@hasWebAccess = hasWebAccess.toString();
			xml.@name = formName;
			
			var tempXML:XML = <viewName/>;
			tempXML.appendChild(new XML("\<![CDATA[" + viewName + "]]\>"));
			xml.appendChild(tempXML);
			
			tempXML = <fields/>;
			for each (var field:DominoFormFieldVO in fields)
			{
				tempXML.appendChild(field.toXML());
			}
			xml.appendChild(tempXML);
			
			return xml;
		}
		
		public function toCode():XML
		{
			var tmpDominoTable:DominoTable = new DominoTable();
			var tmpRow:GridRow;
			var tmpGridItem:GridItem;
			
			// generate rows/columns
			for each (var field:DominoFormFieldVO in fields)
			{
				tmpRow = new GridRow();
				
				// 3 columns - 
				// label, input, description
				tmpGridItem = getLabelItem(field.label);
				tmpRow.addElement(tmpGridItem);
				
				tmpGridItem = getInputItem(field);
				tmpRow.addElement(tmpGridItem);
				
				tmpGridItem = getLabelItem(field.description);
				tmpRow.addElement(tmpGridItem);

				tmpDominoTable.addElement(tmpRow);
			}
			
			// sigh.. 
			var conversionTable:DominoTable = new DominoTable(tmpDominoTable);
			
			return conversionTable.toCode();
		}
		
		private function getInputItem(field:DominoFormFieldVO):GridItem
		{
			var tmpColumn:GridItem = new GridItem();
			var tmpDiv:Div = new Div();
			
			var tmpDominoField:DominoFormField = new DominoFormField();
			tmpDominoField.allowmultivalues = field.isMultiValue;
			tmpDominoField.kind = field.editable;
			tmpDominoField.type = field.type;
			tmpDominoField.nameAttribute = field.name;
			tmpDiv.addElement(tmpDominoField);
			
			tmpColumn.addElement(tmpDiv);
			return tmpColumn;
		}
		
		private function getLabelItem(value:String):GridItem
		{
			var tmpColumn:GridItem = new GridItem();
			var tmpDiv:Div = new Div();
			
			var tmpLabel:DominoLabel = new DominoLabel();
			tmpLabel.text = value;
			tmpDiv.addElement(tmpLabel);
			
			tmpColumn.addElement(tmpDiv);
			return tmpColumn;
		}
	}
}