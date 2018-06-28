package utils
{
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;
    import flash.events.FocusEvent;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    import mx.core.IVisualElement;

    import mx.core.IVisualElementContainer;

    import view.VisualEditor;
    import view.interfaces.IMainApplication;
    import view.interfaces.ISurfaceComponent;

    public class CopyPasteVisualEditorManager
    {
        private var visualEditor:VisualEditor;

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
                var selectedElement:ISurfaceComponent = this.visualEditor.editingSurface.selectedItem;

                if (selectedElement)
                {
                    var code:XML = null;
                    if (event.keyCode == Keyboard.C && !(selectedElement is IMainApplication))
                    {
                        Clipboard.generalClipboard.clear();
                        code = selectedElement.toXML();
                        Clipboard.generalClipboard.setData(ClipboardFormats.HTML_FORMAT, code.toXMLString());
                    }
                    else if (event.keyCode == Keyboard.V)
                    {
                        var container:IVisualElementContainer = selectedElement as IVisualElementContainer;
                        if (container)
                        {
                            var pasteCode:XML = new XML(Clipboard.generalClipboard.getData(ClipboardFormats.HTML_FORMAT));
                            itemFromXML(container, pasteCode);
                        }
                    }
                }
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
            return item;
        }
    }
}
