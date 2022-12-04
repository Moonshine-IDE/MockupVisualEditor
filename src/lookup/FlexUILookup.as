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
	import view.flex.surfaceComponents.components.*;
	import interfaces.ILookup;

	public class FlexUILookup implements ILookup
	{
		private var _lookup:Object;

		public function FlexUILookup()
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
			this.lookup[view.flex.surfaceComponents.components.MainApplication.ELEMENT_NAME] =
					view.flex.surfaceComponents.components.MainApplication;

			this.lookup[view.flex.surfaceComponents.components.Button.ELEMENT_NAME] =
					view.flex.surfaceComponents.components.Button;

			this.lookup[view.flex.surfaceComponents.components.Container.ELEMENT_NAME] =
					view.flex.surfaceComponents.components.Container;

			this.lookup[Calendar.ELEMENT_NAME] = Calendar;
			this.lookup[CheckBox.ELEMENT_NAME] = CheckBox;
			this.lookup[DropDownList.ELEMENT_NAME] = DropDownList;
			this.lookup[Hyperlink.ELEMENT_NAME] = Hyperlink;
			this.lookup[Image.ELEMENT_NAME] = Image;
			this.lookup[Input.ELEMENT_NAME] = Input;
			this.lookup[List.ELEMENT_NAME] = List;
			this.lookup[RadioButton.ELEMENT_NAME] = RadioButton;
			this.lookup[Table.ELEMENT_NAME] = Table;
			this.lookup[Tabs.ELEMENT_NAME] = Tabs;
			this.lookup[Text.ELEMENT_NAME] = Text;
			this.lookup[Tree.ELEMENT_NAME] = Tree;
			this.lookup[Window.ELEMENT_NAME] = Window;
		}
	}
}
