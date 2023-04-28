////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) STARTcloud, Inc. 2015-2022. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the Server Side Public License, version 1,
//  as published by MongoDB, Inc.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  Server Side Public License for more details.
//
//  You should have received a copy of the Server Side Public License
//  along with this program. If not, see
//
//  http://www.mongodb.com/licensing/server-side-public-license
//
//  As a special exception, the copyright holders give permission to link the
//  code of portions of this program with the OpenSSL library under certain
//  conditions as described in each individual source file and distribute
//  linked combinations including the program with the OpenSSL library. You
//  must comply with the Server Side Public License in all respects for
//  all of the code used other than as permitted herein. If you modify file(s)
//  with this exception, you may extend this exception to your version of the
//  file(s), but you are not obligated to do so. If you do not wish to do so,
//  delete this exception statement from your version. If you delete this
//  exception statement from all source files in the program, then also delete
//  it in the license file.
//
////////////////////////////////////////////////////////////////////////////////
package view.flex.surfaceComponents.components
{
	import interfaces.ILookup;
	import interfaces.ISurface;

	import mx.collections.ArrayList;
	
	import spark.components.DataGrid;
	import spark.components.gridClasses.GridColumn;
	
	import utils.MxmlCodeUtils;
	
	import view.flex.surfaceComponents.skins.TableSkin;
	import view.interfaces.IFlexSurfaceComponent;

	public class Table extends DataGrid implements IFlexSurfaceComponent
	{
        private static const MXML_ELEMENT_NAME:String = "DataGrid";
		public static const ELEMENT_NAME:String = "table";

		public function Table()
		{
			super();

            this.setStyle("skinClass", TableSkin);
            this.setStyle("color", "#6A6A6A");
            this.setStyle("fontSize", 12);

			this.mouseChildren = false;
			this.dataProvider = new ArrayList(
			[
				{ label: "One", value: 1 },
				{ label: "Two", value: 2 },
				{ label: "Three", value: 3 },
				{ label: "Four", value: 4 },
				{ label: "Five", value: 5 }
			]);
			this.columns = new ArrayList(
			[
				new GridColumn("label"),
				new GridColumn("value")
			]);
			this.width = 200;
			this.height = 160;
			this.minWidth = 20;
			this.minHeight = 20;

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged"
            ];
		}

        public function get propertyEditorClass():Class
        {
            return null;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }
		
		private var _isSelected:Boolean;
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
		}

        public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			setCommonXMLAttributes(xml);

			return xml;
		}

		public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
		{
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
		}

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            setCommonXMLAttributes(xml);

			var columnsXML:XML = new XML("<columns></columns>");
            columnsXML.addNamespace(sparkNamespace);
            columnsXML.setNamespace(sparkNamespace);

			var arrayListXML:XML = new XML("<ArrayList></ArrayList>");
            arrayListXML.addNamespace(sparkNamespace);
            arrayListXML.setNamespace(sparkNamespace);

            columnsXML.appendChild(arrayListXML);
            for(var i:int = 0; i < columnsLength; i++)
			{
				var gridColumn:XML = new XML("<GridColumn></GridColumn>");
                gridColumn.addNamespace(sparkNamespace);
                gridColumn.setNamespace(sparkNamespace);

				var clmn:GridColumn = columns.getItemAt(i) as GridColumn;
				gridColumn.@headerText = clmn.headerText;

                arrayListXML.appendChild(gridColumn);
			}

            xml.appendChild(columnsXML);
			
            return xml;
        }

		public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
		public function toRora():XML
        {
            return null;
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
		}
    }
}
