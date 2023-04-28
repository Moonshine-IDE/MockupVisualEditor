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
	import interfaces.ILookup;

	import view.primeFaces.surfaceComponents.components.*;
	import view.primeFaces.supportClasses.GridItem;
	import view.primeFaces.supportClasses.GridRow;
	import view.primeFaces.supportClasses.NavigatorContent;
	import view.primeFaces.surfaceComponents.components.Div;

	public class PrimeFacesUILookup implements ILookup
	{
		private var _lookup:Object;

		public function PrimeFacesUILookup()
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
			this.lookup[view.primeFaces.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
					view.primeFaces.surfaceComponents.components.MainApplication;
			this.lookup[view.primeFaces.surfaceComponents.components.Button.ELEMENT_NAME] =
					view.primeFaces.surfaceComponents.components.Button;
			this.lookup[InputMask.ELEMENT_NAME] = InputMask;
			this.lookup[InputNumber.ELEMENT_NAME] = InputNumber;
			this.lookup[AutoCompleteDropDownList.ELEMENT_NAME] = AutoCompleteDropDownList;
			this.lookup[OutputLabel.ELEMENT_NAME] = OutputLabel;
			this.lookup[Fieldset.ELEMENT_NAME] = Fieldset;
			this.lookup[InputTextarea.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.InputTextarea;
			this.lookup[InputText.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.InputText;
			this.lookup[SelectBooleanCheckbox.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectBooleanCheckbox;
			this.lookup[SelectOneRadio.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectOneRadio;
			this.lookup[SelectOneMenu.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.SelectOneMenu;
			this.lookup[Include.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Include;
			this.lookup[TextEditor.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.TextEditor;
			this.lookup[TabView.ELEMENT_NAME] = TabView;
			this.lookup[view.primeFaces.surfaceComponents.components.Tree.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Tree;
			this.lookup[DataTable.ELEMENT_NAME] = DataTable;
			this.lookup[Div.ELEMENT_NAME] = Div;
			this.lookup[Grid.ELEMENT_NAME] = Grid;
			this.lookup[PanelGrid.ELEMENT_NAME] = PanelGrid;
			this.lookup[OutputPanel.ELEMENT_NAME] = OutputPanel;
			this.lookup[view.primeFaces.surfaceComponents.components.Calendar.ELEMENT_NAME] = view.primeFaces.surfaceComponents.components.Calendar;
			this.lookup[RootDiv.ELEMENT_NAME] = RootDiv;
			this.lookup[SelectOneListbox.ELEMENT_NAME] = SelectOneListbox;
			this.lookup[view.primeFaces.supportClasses.Container.ELEMENT_NAME] = view.primeFaces.supportClasses.Container;
			this.lookup[GridItem.ELEMENT_NAME] = GridItem;
			this.lookup[GridRow.ELEMENT_NAME] = GridRow;
			this.lookup[NavigatorContent.ELEMENT_NAME] = NavigatorContent;
		}
	}
}
