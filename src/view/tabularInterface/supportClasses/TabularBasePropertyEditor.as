package view.tabularInterface.supportClasses
{
	import flash.filesystem.File;
	
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.Group;
	import spark.layouts.VerticalLayout;
	
	import view.suportClasses.events.PropertyEditorChangeEvent;
	import view.tabularInterface.DominoTabularForm;
	import view.tabularInterface.utils.TabularExporter;
	import view.tabularInterface.utils.TabularImporter;
	import view.tabularInterface.vo.DominoFormVO;
	
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
			if (!_filePath || (_filePath.nativePath != value.nativePath))
			{
				_filePath = value;
				retrieveFromFile();
			}
		}
		
		public function TabularBasePropertyEditor()
		{
			super();
			layout = new VerticalLayout();
			
			dominoForm.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onFormPropertyChanged);
			dominoForm.fields.addEventListener(CollectionEvent.COLLECTION_CHANGE, onFormFieldsCollectionChanged);
		}
		
		public function dispose():void
		{
			dominoForm.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onFormPropertyChanged);
			dominoForm.fields.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onFormFieldsCollectionChanged);
		}
		
		//--------------------------------------------------------------------------
		//
		//  PROTECTED API
		//
		//--------------------------------------------------------------------------
		
		protected function retrieveFromFile():void
		{
			TabularImporter.loadFromFile(filePath, dominoForm);
		}
		
		protected function writeToFile():void
		{
			TabularExporter.writeToFile(filePath, dominoForm);
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