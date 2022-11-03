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
package view.dominoFormBuilder.supportClasses
{
	import flash.filesystem.File;
	
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.Group;
	import spark.layouts.VerticalLayout;
	
	import view.dominoFormBuilder.DominoTabularForm;
	import view.dominoFormBuilder.utils.FormBuilderCodeUtils;
	import view.dominoFormBuilder.vo.DominoFormVO;
	import view.suportClasses.events.PropertyEditorChangeEvent;
	
	public class DominoFormBuilderBaseEditor extends Group
	{
		public var tabularTab:DominoTabularForm;
		
		private var _dominoForm:DominoFormVO = new DominoFormVO();
		[Bindable]
		public function get dominoForm():DominoFormVO
		{
			return _dominoForm;
		}
		public function set dominoForm(value:DominoFormVO):void
		{
			_dominoForm = value;
		}
		
		private var _filePath:File;
		public function get filePath():File
		{
			return _filePath;
		}
		public function set filePath(value:File):void
		{
			if (!_filePath || (_filePath.nativePath != value.nativePath))
			{
				_filePath = value;
				retrieveFromFile();
			}
		}
		
		public function get formXML():XML
		{
			return dominoForm.toXML();
		}
		
		public function get formDXL():XML
		{
			return FormBuilderCodeUtils.toDominoCode(dominoForm);
		}
		
		public function get viewDXL():XML
		{
			return FormBuilderCodeUtils.toViewCode(dominoForm);
		}
		
		public function DominoFormBuilderBaseEditor()
		{
			super();
			layout = new VerticalLayout();
		}
		
		public function dispose():void
		{
			removeChangeListeners();
		}
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED API
		//
		//--------------------------------------------------------------------------
		
		protected function retrieveFromFile():void
		{
			FormBuilderCodeUtils.loadFromFile(filePath, dominoForm, addChangeListeners);
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE API
		//
		//--------------------------------------------------------------------------
		
		private function addChangeListeners():void
		{
			removeChangeListeners();
			
			dominoForm.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onFormPropertyChanged);
			dominoForm.fields.addEventListener(CollectionEvent.COLLECTION_CHANGE, onFormFieldsCollectionChanged);
		}
		
		private function removeChangeListeners():void
		{
			dominoForm.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onFormPropertyChanged);
			dominoForm.fields.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onFormFieldsCollectionChanged);
		}
		
		private function onFormPropertyChanged(event:PropertyChangeEvent):void
		{
			tabularTab.dispatchEvent(new PropertyEditorChangeEvent(PropertyEditorChangeEvent.PROPERTY_EDITOR_CHANGED, null));
		}
		
		private function onFormFieldsCollectionChanged(event:CollectionEvent):void
		{
			onFormPropertyChanged(null);
		}
	}
}