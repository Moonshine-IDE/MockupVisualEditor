package view.dominoFormBuilder.vo
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	
	import view.dominoFormBuilder.utils.DominoTemplatesManager;
	
	[Bindable] 
	public class DominoFormVO extends EventDispatcher
	{
		public static const ELEMENT_NAME:String = "form";
		
		public var formName:String;
		public var viewName:String;
		public var hasWebAccess:Boolean;
		public var fields:ArrayCollection = new ArrayCollection();
		public var dxlGeneratedOn:Date;
		
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
			if ("@dxlGeneratedOn" in value.form)
			{
				this.dxlGeneratedOn = new Date(Date.parse(
					String(value.form.@dxlGeneratedOn)
				));
			}
			
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
			
			if (!dxlGeneratedOn) dxlGeneratedOn = new Date();
			xml.@dxlGeneratedOn = dxlGeneratedOn.toUTCString();
			return xml;
		}
		
		//--------------------------------------------------------------------------
		//
		//  DXL/XML
		//
		//--------------------------------------------------------------------------
		
		public function toCode():String
		{
			var table:String = DominoTemplatesManager.getTableTemplate();
			
			// generate rows/columns
			var tmpRows:String = "";
			for each (var field:DominoFormFieldVO in fields)
			{
				tmpRows += field.toCode();
			}
			
			table = table.replace(/%rows%/ig, tmpRows);
			return table;
		}
		
		public function toViewColumnsCode():String
		{
			var column:String = DominoTemplatesManager.getViewColumn();
			
			// generate rows/columns
			var tmpColumns:String = "";
			var tmpColumn:String = "";
			for each (var field:DominoFormFieldVO in fields)
			{
				if (field.isIncludeInView)
				{
					tmpColumn = column.replace(/%fieldname%/ig, field.name);
					tmpColumn = tmpColumn.replace(/%sort%/ig, field.sortOption.value);
					tmpColumn = tmpColumn.replace(/%categorized%/ig, field.sortOption.isCategorized.toString());
					tmpColumn = tmpColumn.replace(/%label%/ig, field.label);
					
					tmpColumns += tmpColumn;
				}
			}
			
			return tmpColumns;
		}
	}
}