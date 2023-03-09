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

	import view.domino.surfaceComponents.components.*;
	import view.primeFaces.supportClasses.GridItem;
	import view.primeFaces.supportClasses.GridRow;
	import view.primeFaces.supportClasses.NavigatorContent;
	import view.primeFaces.surfaceComponents.components.Div;

	public class DominoUILookup implements ILookup
	{
		private var _lookup:Object;

		public function DominoUILookup()
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
			//TODO: Piotr - move this classes to more general package
			this.lookup[GridItem.ELEMENT_NAME] = GridItem;
			this.lookup[GridRow.ELEMENT_NAME] = GridRow;
			this.lookup[Div.ELEMENT_NAME] = Div;

			this.lookup[DominoInputText.ELEMENT_NAME] = DominoInputText;
			this.lookup[DominoLabel.ELEMENT_NAME] = DominoLabel;
			this.lookup[DominoButton.ELEMENT_NAME] = DominoButton;
			this.lookup[DominoComputedText.ELEMENT_NAME] = DominoComputedText;
			this.lookup[DominoTable.ELEMENT_NAME] = DominoTable;
			this.lookup[DominoTabView.ELEMENT_NAME] = DominoTabView;
			this.lookup[NavigatorContent.ELEMENT_NAME] = NavigatorContent;
			this.lookup[DominoSection.ELEMENT_NAME] = DominoSection;
			this.lookup[view.primeFaces.supportClasses.Container.ELEMENT_NAME] = view.primeFaces.supportClasses.Container;
			this.lookup[DominoCalendar.ELEMENT_NAME] =DominoCalendar;
			this.lookup[DominoParagraph.ELEMENT_NAME] =DominoParagraph;
			this.lookup[view.domino.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
					view.domino.surfaceComponents.components.MainApplication;
			this.lookup[DominoSubForm.ELEMENT_NAME] = DominoSubForm;
			this.lookup[DominoShareAction.ELEMENT_NAME] = DominoShareAction;
			this.lookup[DominoShareField.ELEMENT_NAME] = DominoShareField;
		}
	}
}
