package view.flex.surfaceComponents.components
{
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.containers.ViewStack;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import spark.components.Group;
	import spark.components.NavigatorContent;
	import spark.components.SkinnableContainer;
	import spark.components.TabBar;
	import spark.events.IndexChangeEvent;
	import spark.layouts.VerticalLayout;
	
	import data.DataProviderListItem;

	import utils.GenericUtils;

	import utils.MxmlCodeUtils;
	
	import view.flex.propertyEditors.TabsPropertyEditor;
	import view.flex.surfaceComponents.skins.NavigatorContentSkin;
	import view.interfaces.IDataProviderComponent;
	import view.interfaces.IFlexSurfaceComponent;
	import view.interfaces.IMultiViewContainer;
	import view.interfaces.ISurfaceComponent;

	public class Tabs extends Group implements IFlexSurfaceComponent, IMultiViewContainer, IDataProviderComponent
	{
        private static const MXML_ELEMENT_NAME:String = "Group";
		public static const ELEMENT_NAME:String = "tabs";

		public function Tabs()
		{
			super();

			this.width = 200;
			this.height = 200;
			this.minWidth = 150;
			this.minHeight = 150;

			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 0;
			this.layout = layout;

			this._tabs = new TabBar();
			this._tabs.mouseEnabled = false;
			this._tabs.mouseChildren = false;
			this._tabs.percentWidth = 100;
			this.addElement(this._tabs);

			this._stack = new ViewStack();
			this._stack.setStyle("borderColor", "#A9A9A9");
			this._stack.setStyle("borderStyle", "solid");
			this._stack.minWidth = 0;
			this._stack.minHeight = 0;
			this._stack.percentWidth = 100;
			this._stack.percentHeight = 100;
			this.addElement(this._stack);

			this._tabs.dataProvider = this._stack;

			this._dataProvider = new ArrayList();
			this._dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, dataProvider_collectionChangeHandler);
			this._dataProvider.addItem(new DataProviderListItem("One"));
			this._dataProvider.addItem(new DataProviderListItem("Two"));
			this._dataProvider.addItem(new DataProviderListItem("Three"));
			this._numViews = this._stack.numElements;
			this.selectedIndex = 0;
		}

		private var _tabs:TabBar;
		private var _stack:ViewStack;

		public function get propertyEditorClass():Class
		{
			return TabsPropertyEditor;
		}
		
		private var _isSelected:Boolean;
		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
		}

		private var _dataProvider:IList;

		[Bindable("dataChange")]
		public function get dataProvider():IList
		{
			return this._dataProvider;
		}

		private var _numViews:int = 1;

		[Bindable("dataChange")]
		public function get numViews():int
		{
			return this._numViews
		}

		private var _selectedView:SkinnableContainer;

		[Bindable("change")]
		public function get selectedView():SkinnableContainer
		{
			return this._selectedView;
		}

		private var _selectedIndex:int = -1;

		[Bindable("change")]
		public function get selectedIndex():int
		{
			return this._selectedIndex
		}

		public function set selectedIndex(value:int):void
		{
			if(this._selectedIndex === value)
			{
				return;
			}
			var oldIndex:int = this._selectedIndex;
			this._selectedIndex = value;
			this._selectedView = SkinnableContainer(this._stack.getItemAt(this._selectedIndex));
			this.invalidateProperties();
			this.dispatchEvent(new IndexChangeEvent(IndexChangeEvent.CHANGE, false, false, oldIndex, this._selectedIndex))
		}

		public function getViewAt(index:int):SkinnableContainer
		{
			return SkinnableContainer(this._stack.getItemAt(index));
		}

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			setCommonXMLAttributes(xml);
			
			xml.@selectedIndex = this.selectedIndex;
			var tabCount:int = this._dataProvider.length;
			for(var i:int = 0; i < tabCount; i++)
			{
				xml.appendChild(this.tabToXML(i));
			}
			return xml;
		}

		private function tabToXML(index:int):XML
		{
			var xml:XML = <tab/>;
			var tab:NavigatorContent = this._stack.getItemAt(index) as NavigatorContent;
			xml.@text = tab.label;
			var elementCount:int = tab.numElements;
			for(var i:int = 0; i < elementCount; i++)
			{
				var element:ISurfaceComponent = tab.getElementAt(i) as ISurfaceComponent;
				if(element === null)
				{
					continue;
				}
				xml.appendChild(element.toXML());
			}
			return xml;
		}

		public function fromXML(xml:XML, callback:Function):void
		{
			this.dataProvider.removeAll();
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			var tabsXML:XMLList = xml.elements("tab");
			var tabsCount:int = tabsXML.length();
			for(var i:int = 0; i < tabsCount; i++)
			{
				var tabXML:XML = tabsXML[i];
				var label:String = tabXML.@text;
				this._dataProvider.addItem(new DataProviderListItem(label));
				var tab:NavigatorContent = NavigatorContent(this._stack.getItemAt(this._dataProvider.length - 1));
				this.tabFromXML(tab, tabXML, callback);
			}
			this.selectedIndex = xml.@selectedIndex;
		}

		public function tabFromXML(tab:NavigatorContent, xml:XML, callback:Function):void
		{
			var elementsXML:XMLList = xml.elements();
			var childCount:int = elementsXML.length();
			for(var i:int = 0; i < childCount; i++)
			{
				var childXML:XML = elementsXML[i];
				callback(tab, childXML);
			}
		}

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

			var tabBar:XML = new XML("<TabBar></TabBar>");
            tabBar.addNamespace(sparkNamespace);
            tabBar.setNamespace(sparkNamespace);

			tabBar.@percentWidth = 100;

            var viewStack:XML = new XML("<ViewStack></ViewStack>");
            var mxNamespace:Namespace = new Namespace("mx", "library://ns.adobe.com/flex/mx");
            viewStack.addNamespace(mxNamespace);
            viewStack.setNamespace(mxNamespace);

			var viewStackId:String = GenericUtils.getRandomId("viewStack");

			viewStack.@id = viewStackId;
			viewStack.@selectedIndex = selectedIndex;

            var tabCount:int = this._dataProvider.length;
            for(var i:int = 0; i < tabCount; i++)
            {
                viewStack.appendChild(this.tabToMXML(i));
            }

			tabBar.@dataProvider = "{".concat(viewStackId, "}");
			xml.appendChild(tabBar);
			xml.appendChild(viewStack);

            return xml;
        }

        private function tabToMXML(index:int):XML
        {
            var viewStack:XML = new XML("<NavigatorContent></NavigatorContent>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            viewStack.addNamespace(sparkNamespace);
            viewStack.setNamespace(sparkNamespace);

            var tab:NavigatorContent = this._stack.getItemAt(index) as NavigatorContent;
            viewStack.@label = tab.label;

            var elementCount:int = tab.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IFlexSurfaceComponent = tab.getElementAt(i) as IFlexSurfaceComponent;
                if(element === null)
                {
                    continue;
                }

				viewStack.appendChild(element.toCode());
            }

            return viewStack;
        }

        override protected function commitProperties():void
		{
			this._stack.selectedIndex = this._selectedIndex;
			super.commitProperties();
		}

		private function dataProvider_collectionChangeHandler(event:CollectionEvent):void
		{
			switch(event.kind)
			{
				case CollectionEventKind.RESET:
				{
					this._stack.removeAll();
					this.dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
					break;
				}
				case CollectionEventKind.ADD:
				{
					var newContent:NavigatorContent = new NavigatorContent();
                    newContent.setStyle("skinClass", NavigatorContentSkin);

					newContent.label = event.items[0].label;
					this._stack.addElementAt(newContent, event.location);
					this._numViews++;
					this.dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
					break;
				}
				case CollectionEventKind.REMOVE:
				{
					this._numViews--;
					this._stack.removeElementAt(event.location);
					this.dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
					break;
				}
				case CollectionEventKind.UPDATE:
				{
					var propertyChange:PropertyChangeEvent = event.items[0];
					var item:DataProviderListItem = DataProviderListItem(propertyChange.source);
					var index:int = this._dataProvider.getItemIndex(item);
					if(index !== -1)
					{
						var content:NavigatorContent = NavigatorContent(this._stack.getElementAt(index));
						content.label = item.label;
					}
					break;
				}
			}
		}

        private function setCommonXMLAttributes(xml:XML):void
        {
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = this.width;
            xml.@height = this.height;
        }

        public function get propertiesChangedEvents():Array
        {
            return null;
        }
    }
}
