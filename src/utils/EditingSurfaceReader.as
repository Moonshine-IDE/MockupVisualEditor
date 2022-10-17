////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2016-present Prominic.NET, Inc.
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
package utils
{
	import converter.DominoConverter;
	import converter.PrimeFacesConverter;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import lookup.Lookup;

	import surface.SurfaceMockup;

    public class EditingSurfaceReader
	{
        public static var classLookup:ILookup;

		public static function fromXML(surface:ISurface, xml:XML, visualEditorType:String):void
		{
			if(visualEditorType == VisualEditorType.DOMINO)
			{
				classLookup = Lookup.DominoUILookup;
            	DominoConverter.fromXML(surface, Lookup.DominoUILookup, xml);
			}
			else if (visualEditorType == VisualEditorType.FLEX)
			{
				classLookup = Lookup.FlexUILookup;
				PrimeFacesConverter.fromXML(surface, Lookup.FlexUILookup, xml);
			}
         	else
			{
				classLookup = Lookup.PrimeFacesUILookup;
				PrimeFacesConverter.fromXML(surface, Lookup.PrimeFacesUILookup, xml);
			}
		}

		public static function fromXMLAutoConvert(xml:XML):SurfaceMockup
		{
			classLookup = Lookup.DominoNonUILookup;
			var surfaceModel:SurfaceMockup =  DominoConverter.fromXMLOnly(Lookup.DominoNonUILookup, xml);
			return surfaceModel;
		}
	}
}
