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
    
    import global.domino.DominoGlobals;
    import view.primeFaces.supportClasses.Container;

    import interfaces.ILookup;

	import interfaces.ISurface;
    import converter.DominoConverter;
    import view.domino.surfaceComponents.components.DominoTable;
    import view.domino.surfaceComponents.components.DominoTabView;
    import view.domino.surfaceComponents.components.DominoSection;
    import view.domino.surfaceComponents.components.DominoParagraph;
    import view.domino.surfaceComponents.components.DominoSubForm;
    import view.domino.surfaceComponents.components.MainApplication;
    import mx.controls.Alert;
    
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
            }else{
                Alert.show("The main application frame may not be duplicated.");
            }
        }

        private function paste():void
        {
            var selectedElement:ISurfaceComponent = this.visualEditor.editingSurface.selectedItem;
            if (!selectedElement) return;
         
            var container:IVisualElementContainer = selectedElement as IVisualElementContainer;
            //if the select is table or tabView , we need more logic handle the traget container.
            if(container is DominoTable){
                var dominoTable:DominoTable= container as DominoTable;
                container=(dominoTable.getCurrentSelectCell()) as IVisualElementContainer;
            }else if(container is DominoTabView){
                var dominoTabView:DominoTabView=container as DominoTabView;
                container=(dominoTabView.div) as IVisualElementContainer;
            }else if(container is DominoParagraph){
                container= (selectedElement as UIComponent).parent as IVisualElementContainer;
            }else if(container is DominoSection){

            }else if(container is DominoSubForm){
                container= (selectedElement as UIComponent).parent as IVisualElementContainer;
            }else if(!(container is view.primeFaces.supportClasses.Container)){
                //check if it is itself, otherwise the past element should be as slibing for the source element.
                container= (selectedElement as UIComponent).parent as IVisualElementContainer;
            }

         

            if (container)
            {
                var pasteCode:XML = new XML(Clipboard.generalClipboard.getData(ClipboardFormats.HTML_FORMAT));
				targetDuplicateRoot = container;
                pasteItemFromXML(container, pasteCode);
                 //update status of Editor
                MoonshineBridgeUtils.moonshineBridge.updateCurrentVisualEditorStatus();
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
                pasteItemFromXML(container, code);

            }
        }

		
        private function pasteItemFromXML(parent:IVisualElementContainer, itemXML:XML,surface:ISurface=null, lookup:ILookup=null):ISurfaceComponent
        {

            var name:String = itemXML.name();
            if(!(name in EditingSurfaceReader.classLookup.lookup))
            {
                throw new Error("Unknown item " + name);
            }
            var type:Class = EditingSurfaceReader.classLookup.lookup[name];
            var item:ISurfaceComponent = new type() as ISurfaceComponent;
            if(item === null)
            {
                throw new Error("Failed to create surface component: " + name);
            }

            //auto update the field name when it past
            if(name=="Field" || name=="field"){
                itemXML.@name=itemXML.@name+"_"+DominoGlobals.FieldPastNameCount.toString();
                DominoGlobals.FieldPastNameCount++;
            }

            if(item is DominoParagraph){
                item=(DominoConverter.pasteFromXML(item, EditingSurfaceReader.classLookup,itemXML,this.visualEditor.editingSurface)) as ISurfaceComponent;
                parent.addElement(IVisualElement(item));
            }else if((item is DominoTable) || (item is DominoTabView) || (item is DominoSection)){
                item=(DominoConverter.itemFromXML(parent, EditingSurfaceReader.classLookup,itemXML,this.visualEditor.editingSurface)) as ISurfaceComponent;
            } 
            else{
              item.fromXML(itemXML, pasteItemFromXML, this.visualEditor.editingSurface, EditingSurfaceReader.classLookup);
              parent.addElement(IVisualElement(item));
          
            }

              this.visualEditor.editingSurface.addItem(item);
           
            
			
          
			// supplying the change to undo manager
			// should execute once against target where paste/duplicate happened
			if (item is IHistorySurfaceComponent && parent === targetDuplicateRoot)
			{
				var tmpChangeRef:PropertyChangeReference = new PropertyChangeReference(item as IHistorySurfaceComponent);
				tmpChangeRef.fieldClassIndexToParent = IVisualElementContainer(item.owner).getElementIndex(item as IVisualElement);
				tmpChangeRef.fieldClassParent = item.owner as IVisualElementContainer;
				
				this.visualEditor.editingSurface.dispatchEvent(new PropertyEditorChangeEvent(PropertyEditorChangeEvent.PROPERTY_EDITOR_ITEM_ADDING, tmpChangeRef));
				this.visualEditor.editingSurface.organizer.addDroppedElement(parent as IVisualElement, item as IVisualElement);
				targetDuplicateRoot = null;
			}
			
            return item;
        }
    }
}