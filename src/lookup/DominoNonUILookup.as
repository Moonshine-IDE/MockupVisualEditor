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
	import components.GridRow;
	import components.GridItem;
	import components.NavigatorContent;
	import components.common.Div;
	import components.domino.Body;
	import components.domino.DominoButton;
	import components.domino.DominoCalendar;
	import components.domino.DominoComputedText;
	import components.domino.DominoInputText;
	import components.domino.DominoLabel;
	import components.domino.DominoParagraph;
	import components.domino.DominoSection;
	import components.domino.DominoTabView;
	import components.domino.DominoTable;
	import components.domino.MainApplication;
	import components.domino.DominoSubForm;
	import components.domino.DominoShareActions;
	import components.domino.DominoShareField;

	import interfaces.ILookup;

	public class DominoNonUILookup implements ILookup
	{
		private var _lookup:Object;

		public function DominoNonUILookup()
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
			this.lookup[MainApplication.ELEMENT_NAME] = Body;
			this.lookup["Body"] = Body;
			this.lookup["RootDiv"] = Body;

			this.lookup[Div.ELEMENT_NAME] = Div;
			this.lookup[GridItem.GRIDITEM_NAME] = GridItem;
			this.lookup[GridRow.GRIDROW_NAME] = GridRow;
			this.lookup[NavigatorContent.NAVIGATORCONTENT_NAME] = NavigatorContent;

			this.lookup[DominoInputText.ELEMENT_NAME] = DominoInputText;
			this.lookup[DominoLabel.ELEMENT_NAME] = DominoLabel;
			this.lookup[DominoButton.ELEMENT_NAME] = DominoButton;
			this.lookup[DominoComputedText.ELEMENT_NAME] = DominoComputedText;
			this.lookup["Grid"] = DominoTable;
			this.lookup[DominoTable.ELEMENT_NAME] = DominoTable;
			this.lookup[DominoTabView.ELEMENT_NAME] = DominoTabView;
			this.lookup[DominoSection.ELEMENT_NAME] = DominoSection;
			this.lookup[DominoCalendar.ELEMENT_NAME] = DominoCalendar;
			this.lookup[DominoParagraph.ELEMENT_NAME] = DominoParagraph;
			this.lookup[DominoSubForm.ELEMENT_NAME] = DominoSubForm;
			this.lookup[DominoShareActions.ELEMENT_NAME] = DominoShareActions;
			this.lookup[DominoShareField.ELEMENT_NAME] = DominoShareField;
		}
	}
}
