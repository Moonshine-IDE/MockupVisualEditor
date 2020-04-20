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