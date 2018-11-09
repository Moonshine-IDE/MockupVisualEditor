package utils
{
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import flash.events.FocusEvent;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    import mx.core.IVisualElement;
    import mx.core.IVisualElementContainer;
    import mx.core.UIComponent;
    
    import view.VisualEditor;
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IMainApplication;
    import view.interfaces.ISurfaceComponent;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.events.PropertyEditorChangeEvent;

    public class CopyPasteVisualEditorManager
    {
        private var visualEditor:VisualEditor;
		private var targetDuplicateRoot:IVisualElementContainer;

        public function CopyPasteVisualEditorManager(visualEditor:VisualEditor)
        {
            this.visualEditor = visualEditor;

            visualEditor.addEventListener(FocusEvent.FOCUS_IN, onUiListenerFocusIn);
            visualEditor.addEventListener(FocusEvent.FOCUS_OUT, onUiListenerFocusOut);
        }

        private function onUiListenerFocusOut(event:FocusEvent):void
        {
            this.visualEditor.removeEventListener(KeyboardEvent.KEY_DOWN, onUiListenerKeyDown);
        }

        private function onUiListenerFocusIn(event:FocusEvent):void
        {
            this.visualEditor.addEventListener(KeyboardEvent.KEY_DOWN, onUiListenerKeyDown);
        }

        private function onUiListenerKeyDown(event:KeyboardEvent):void
        {
            if (event.commandKey || event.ctrlKey)
            {
                if (event.keyCode == Keyboard.C)
                {
                    copy();
                }
                else if (event.keyCode == Keyboard.V)
                {
                    paste();
                }
                else if (event.keyCode == Keyboard.U)
                {
                    duplicate();
                }
            }
        }

        private function copy():void
        {
            var selectedElement:ISurfaceComponent = this.visualEditor.editingSurface.selectedItem;
            if (!selectedElement) return;

            if (!(selectedElement is IMainApplication))
            {
                Clipboard.generalClipboard.clear();
                var code:XML = selectedElement.toXML();
                Clipboard.generalClipboard.setData(ClipboardFormats.HTML_FORMAT, code.toXMLString());
            }
        }

        private function paste():void
        {
            if (!this.visualEditor.editingSurface.selectedItem) return;

            var container:IVisualElementContainer = this.visualEditor.editingSurface.selectedItem as IVisualElementContainer;
            if (container)
            {
                var pasteCode:XML = new XML(Clipboard.generalClipboard.getData(ClipboardFormats.HTML_FORMAT));
				targetDuplicateRoot = container;
                itemFromXML(container, pasteCode);
            }
        }

        public function duplicate():void
        {
            var selectedElement:ISurfaceComponent = this.visualEditor.editingSurface.selectedItem;
            if (!this.visualEditor.editingSurface.selectedItem) return;

            var container:IVisualElementContainer = (selectedElement as UIComponent).parent as IVisualElementContainer;
            if (container)
            {
                var code:XML = selectedElement.toXML();
				targetDuplicateRoot = container;
                itemFromXML(container, code);
            }
        }

        private function itemFromXML(parent:IVisualElementContainer, itemXML:XML):ISurfaceComponent
        {
            var name:String = itemXML.name();
            if(!(name in EditingSurfaceReader.CLASS_LOOKUP))
            {
                throw new Error("Unknown item " + name);
            }
            var type:Class = EditingSurfaceReader.CLASS_LOOKUP[name];
            var item:ISurfaceComponent = new type() as ISurfaceComponent;
            if(item === null)
            {
                throw new Error("Failed to create surface component: " + name);
            }
            item.fromXML(itemXML, itemFromXML);
            parent.addElement(IVisualElement(item));
            this.visualEditor.editingSurface.addItem(item);
			
			// supplying the change to undo manager
			// should execute once against target where paste/duplicate happened
			if (item is IHistorySurfaceComponent && parent === targetDuplicateRoot)
			{
				var tmpChangeRef:PropertyChangeReference = new PropertyChangeReference(item as IHistorySurfaceComponent);
				tmpChangeRef.fieldClassIndexToParent = IVisualElementContainer(item.owner).getElementIndex(item as IVisualElement);
				tmpChangeRef.fieldClassParent = item.owner as IVisualElementContainer;
				
				this.visualEditor.editingSurface.dispatchEvent(new PropertyEditorChangeEvent(PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_ADDING, tmpChangeRef));
				targetDuplicateRoot = null;
			}
			
            return item;
        }
    }
}
