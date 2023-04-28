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
package view.interfaces
{
    import interfaces.IComponent;

    import mx.core.IChildList;
	import mx.core.IInvalidating;
	import mx.core.IUIComponent;
	
	public interface ISurfaceComponent extends IUIComponent, IInvalidating, IChildList, IComponent
	{
        /**
		 * Represents UI reflection to the properties which user is allowed to modify in property editor
         */
		function get propertyEditorClass():Class;

        /**
		 * Helper function which returns lists of events to track whether user changed any value in property editor
         */
		function get propertiesChangedEvents():Array;

        /**
		 * Translates component to Visual Editor XML format
		 *
         * @return Visual Editor XML format
         */
		function toXML():XML;

		/**
		 * Help to determine if 'self' is currently selected on the stage 
		 */
		function get isSelected():Boolean;
		function set isSelected(value:Boolean):void;
	

	}
}
