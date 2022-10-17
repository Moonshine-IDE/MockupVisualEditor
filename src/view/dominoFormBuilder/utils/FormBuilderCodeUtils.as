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
package view.dominoFormBuilder.utils
{
	import flash.filesystem.File;
	
	import utils.MoonshineBridgeUtils;
	
	import view.dominoFormBuilder.vo.DominoFormVO;

	public class FormBuilderCodeUtils
	{
		public static function loadFromFile(path:File, toFormObject:DominoFormVO, onSuccess:Function=null):void
		{
			if (path.exists)
			{
				var fileXML:XML = XML(MoonshineBridgeUtils.moonshineBridgeFormBuilderInterface.read(path));
				toFormObject.fromXML(fileXML, onSuccess);
			}
			else if (onSuccess != null)
			{
				onSuccess();
			}
		}
		
		public static function toDominoCode(formObject:DominoFormVO):XML
		{
			XML.ignoreWhitespace = true;
			
			var form:String = DominoTemplatesManager.getFormTemplate();
			var par:String = DominoTemplatesManager.getFormParTemplate();
			
			var formBody:String = par.replace(/%value%/ig, formObject.viewName);
			formBody += formObject.toCode();
			
			form = form.replace(/%formname%/ig, formObject.formName);
			form = form.replace(/%frombody%/ig, formBody);
			
			return XML(form);
		}
		
		public static function toViewCode(formObject:DominoFormVO):XML
		{
			XML.ignoreWhitespace = true;
			
			var view:String = DominoTemplatesManager.getViewTemplate();
			view = view.replace(/%viewname%/ig, formObject.viewName);
			view = view.replace(/%formname%/ig, formObject.formName);
			view = view.replace(/%columns%/ig, formObject.toViewColumnsCode());
			
			return XML(view);
		}
	}
}