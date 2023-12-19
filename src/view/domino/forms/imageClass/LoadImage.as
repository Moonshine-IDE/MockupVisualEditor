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

package view.domino.forms.imageClass
{
	[Bindable]
    public class LoadImage 
	{
        [Embed(source='/assets/align-center-solid.png')]
        public static const ALIGN_CENTER:Class;

        [Embed(source='/assets/align-justify-solid.png')]
        public static const ALIGN_JUSTIFY:Class;

        [Embed(source='/assets/align-left-solid.png')]
        public static const ALIGN_LEFT:Class;

        [Embed(source='/assets/align-right-solid.png')]
        public static const ALIGN_RIGHT:Class;
        
        [Embed(source='/assets/ban-solid.png')]
        public static const ALIGN_NONE:Class;
		
		[Embed(source='/assets/firstLine_justify.png')]
		public static const FIRST_LINE_JUSTIFY:Class;
		
		[Embed(source='/assets/firstLine_inside.png')]
		public static const FIRST_LINE_INSIDE_FIRST:Class;
		
		[Embed(source='/assets/firstLine_outside.png')]
		public static const FIRST_LINE_INSIDE_EXCEPT_FIRST:Class;

        [Embed(source='/assets/dominoObjectTreeCircle.png')]
		public static const DOMINO_OBJECT_TREE_CIRCLE:Class;

        [Embed(source='/assets/dominoObjectTreeCircle_fill.png')]
		public static const DOMINO_OBJECT_TREE_CIRCLE_FILL:Class;

        [Embed(source='/assets/dominoObjectTreeCircle_fill_mul.png')]
		public static const DOMINO_OBJECT_TREE_CIRCLE_FILL_MUL:Class;

        [Embed(source='/assets/dominoObjectTreeRhombus.png')]
		public static const DOMINO_OBJECT_TREE_RHOMBUS:Class;

        [Embed(source='/assets/dominoObjectTreeRhombus_fill.png')]
		public static const DOMINO_OBJECT_TREE_RHOMBUS_FILL:Class;

        [Embed(source='/assets/dominoObjectTreeRhombus_fill_mul.png')]
		public static const DOMINO_OBJECT_TREE_RHOMBUS_FILL_MUL:Class;

        

        [Embed(source='/assets/dominoObjectTreePage.png')]
		public static const DOMINO_OBJECT_TREE_PAGE:Class;
        
        [Embed(source='/assets/dominoObjectTreePage_fill.png')]
		public static const DOMINO_OBJECT_TREE_PAGE_FILL:Class;

        [Embed(source='/assets/dominoObjectTreePage_fill_mul.png')]
		public static const DOMINO_OBJECT_TREE_PAGE_FILL_MUL:Class;

    }
}