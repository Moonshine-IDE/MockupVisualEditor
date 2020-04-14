package view.tabularInterface.supportClasses
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.Group;
	import spark.layouts.VerticalLayout;
	
	import view.suportClasses.events.PropertyEditorChangeEvent;
	import view.tabularInterface.DominoTabularForm;
	import view.tabularInterface.vo.DominoFormVO;
	
	[Event(name="notifyMoonshine", type="flash.events.Event")]
	public class TabularBasePropertyEditor extends Group
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
			_filePath = value;
			retrieveFromFile();
		}
		
		public function TabularBasePropertyEditor()
		{
			super();
			layout = new VerticalLayout();
			
			dominoForm.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onFormPropertyChanged);
			dominoForm.addEventListener(CollectionEvent.COLLECTION_CHANGE, onFormFieldsCollectionChanged);
			
			dominoForm.tempGenerateFields();
		}
		
		public function dispose():void
		{
			dominoForm.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onFormPropertyChanged);
			dominoForm.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onFormFieldsCollectionChanged);
		}
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED API
		//
		//--------------------------------------------------------------------------
		
		protected function retrieveFromFile():void
		{
			if (filePath.exists)
			{
				// parse xml
				// call dominoForm.fromXML(..)
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  PRIVATE API
		//
		//--------------------------------------------------------------------------
		
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