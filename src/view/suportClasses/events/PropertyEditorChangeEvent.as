////////////////////////////////////////////////////////////////////////////////
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
// http://www.apache.org/licenses/LICENSE-2.0 
// 
// Unless required by applicable law or agreed to in writing, software 
// distributed under the License is distributed on an "AS IS" BASIS, 
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and 
// limitations under the License
// 
// No warranty of merchantability or fitness of any kind. 
// Use this software at your own risk.
// 
////////////////////////////////////////////////////////////////////////////////
package view.suportClasses.events
{
	import flash.events.Event;
	
	import view.suportClasses.PropertyChangeReference;
	
	public class PropertyEditorChangeEvent extends Event
	{
		public static const PROPERTY_EDITOR_CHANGED:String = "propertyEditorChanged";
		public static const PROPERTY_EDITOR_ITEM_DELETING:String = "propertyEditorItemDeleting";
		public static const PROPERTY_EDITOR_ITEM_ADDING:String = "propertyEditorItemAdding";
		
		public var changedReference:PropertyChangeReference;
		
		public function PropertyEditorChangeEvent(type:String, changedReference:PropertyChangeReference)
		{
			this.changedReference = changedReference;
			super(type, true, false);
		}
	}
}