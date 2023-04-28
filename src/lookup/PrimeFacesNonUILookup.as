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
package lookup
{
	import components.Container;
	import components.GridItem;
	import components.GridRow;
	import components.NavigatorContent;
	import components.common.RootDiv;
	import components.primeFaces.AutoCompleteDropDownList;
	import components.primeFaces.Button;
	import components.primeFaces.Calendar;
	import components.primeFaces.DataTable;
	import components.primeFaces.Fieldset;
	import components.primeFaces.Grid;
	import components.primeFaces.Include;
	import components.primeFaces.InputMask;
	import components.primeFaces.InputNumber;
	import components.primeFaces.InputText;
	import components.primeFaces.InputTextarea;
	import components.primeFaces.MainApplication;
	import components.primeFaces.OutputLabel;
	import components.primeFaces.PanelGrid;
	import components.primeFaces.SelectBooleanCheckbox;
	import components.primeFaces.SelectOneListbox;
	import components.primeFaces.SelectOneMenu;
	import components.primeFaces.SelectOneRadio;
	import components.primeFaces.TabView;
	import components.primeFaces.TextEditor;
	import components.primeFaces.Tree;

	import interfaces.ILookup;

	public class PrimeFacesNonUILookup implements ILookup
	{
		private var _lookup:Object;

		public function PrimeFacesNonUILookup()
		{
			_lookup = {};

			initLookupComponents();
		}

		public function get lookup():Object
		{
			return _lookup;
		}

		private function initLookupComponents():void
		{
			this.lookup["RootDiv"] = RootDiv;
			this.lookup["MainApplication"] = MainApplication;
			this.lookup[Container.ELEMENT_NAME] = Container;
			this.lookup[GridRow.GRIDROW_NAME] = GridRow;
			this.lookup[GridItem.GRIDITEM_NAME] = GridItem;
			this.lookup[NavigatorContent.NAVIGATORCONTENT_NAME] = NavigatorContent;

			this.lookup[TabView.ELEMENT_NAME] = TabView;
			this.lookup[PanelGrid.ELEMENT_NAME] = PanelGrid;
			this.lookup[Grid.ELEMENT_NAME] = Grid;
			this.lookup[Include.ELEMENT_NAME] = Include;
			this.lookup[Button.ELEMENT_NAME] = Button;
			this.lookup[OutputLabel.ELEMENT_NAME] = OutputLabel;
			this.lookup[InputText.ELEMENT_NAME] = InputText;
			this.lookup[DataTable.ELEMENT_NAME] = DataTable;
			this.lookup[Fieldset.ELEMENT_NAME] = Fieldset;
			this.lookup[SelectOneMenu.ELEMENT_NAME] = SelectOneMenu;
			this.lookup[TextEditor.ELEMENT_NAME] = TextEditor;
			this.lookup[InputTextarea.ELEMENT_NAME] = InputTextarea;
			this.lookup[Calendar.ELEMENT_NAME] = Calendar;
			this.lookup[SelectBooleanCheckbox.ELEMENT_NAME] = SelectBooleanCheckbox;
			this.lookup[SelectOneRadio.ELEMENT_NAME] = SelectOneRadio;
			this.lookup[InputMask.ELEMENT_NAME] = InputMask;
			this.lookup[InputNumber.ELEMENT_NAME] = InputNumber;
			this.lookup[Tree.ELEMENT_NAME] = Tree;
			this.lookup[AutoCompleteDropDownList.ELEMENT_NAME] = AutoCompleteDropDownList;
			this.lookup[SelectOneListbox.ELEMENT_NAME] = SelectOneListbox;
		}
	}
}
