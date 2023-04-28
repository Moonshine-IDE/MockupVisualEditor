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
    import view.*;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;

	/**
	 * Dispatched when the selectedIndex property changes.
	 * 
	 * @eventType spark.events.IndexChangeEvent.CHANGE
	 */
	[Event(name="change",type="spark.events.IndexChangeEvent")]

	public interface ILayoutContainer extends ISurfaceComponent
	{
		[Bindable("change")]
		function get backgroundColor():uint;
		function set backgroundColor(value:uint):void;
		
		[Bindable("change")]
		function get layoutType():String;
		function set layoutType(value:String):void;
		
		function get layoutTypes():ArrayList;
		
		[Bindable("change")]
		function get containerType():String;
		function set containerType(value:String):void;
		
		function get containerTypes():ArrayList;
		
		[Bindable("change")]
		function get containerStyles():Dictionary;
		function set containerStyles(value:Dictionary):void;
	}
}
