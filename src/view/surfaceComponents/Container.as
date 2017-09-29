package view.surfaceComponents
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;
	import mx.events.FlexEvent;
	import mx.graphics.SolidColor;
	
	import spark.components.BorderContainer;
	import spark.layouts.BasicLayout;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.VerticalLayout;
	import spark.layouts.supportClasses.LayoutBase;
	
	import utils.GenericUtils;
	
	import view.ILayoutContainer;
	import view.ISurfaceComponent;
	import view.propertyEditors.ContainerPropertyEditor;

	public class Container extends BorderContainer implements ILayoutContainer, ISurfaceComponent
	{
		public static const MXML_ELEMENT_NAME:String = "BorderContainer";
		public static const ELEMENT_NAME:String = "container";
		public static const LAYOUT_HORIZONTAL:String = "Horizontal";
		public static const LAYOUT_VERTICAL:String = "Vertical";
		public static const LAYOUT_CANVAS:String = "Canvas";
		public static const CONTAINER_GROUP:String = "Group";
		public static const CONTAINER_VGROUP:String = "VGroup";
		public static const CONTAINER_HGROUP:String = "HGroup";
		public static const CONTAINER_DIV:String = "Div";
		public static const CONTAINER_GRID:String = "Grid";

		public function Container()
		{
			this.width = 200;
			this.height = 200;
			this.minWidth = 20;
			this.minHeight = 20;
			
			this._layoutTypes = new ArrayList([LAYOUT_HORIZONTAL, LAYOUT_VERTICAL, LAYOUT_CANVAS]);
			this._containerTypes = new ArrayList([CONTAINER_GROUP, CONTAINER_VGROUP, CONTAINER_HGROUP, CONTAINER_DIV, CONTAINER_GRID]);
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationCompletes, false, 0, true);
		}

		public function get propertyEditorClass():Class
		{
			return ContainerPropertyEditor;
		}

		private function onCreationCompletes(event:FlexEvent):void
		{
			this.removeEventListener(FlexEvent.CREATION_COMPLETE, onCreationCompletes);
			layoutType = _layoutType;
		}
		
		private var _backgroundColor:uint = 0xcccccc;
		
		[Bindable("change")]
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		public function set backgroundColor(value:uint):void
		{
			if (_backgroundColor != value)
            {
                _backgroundColor = value;
				setStyle("backgroundColor", value);
            }
		}
		
		private var _layoutTypes:ArrayList;
		
		public function get layoutTypes():ArrayList
		{
			return this._layoutTypes;
		}
		
		private var _containerTypes:ArrayList;
		
		public function get containerTypes():ArrayList
		{
			return this._containerTypes;
		}
		
		private var _layoutType:String = LAYOUT_HORIZONTAL;
		
		[Bindable("change")]
		public function get layoutType():String
		{
			return _layoutType;
		}
		public function set layoutType(value:String):void
		{
			_layoutType = value;
			if (contentGroup)
			{
				switch(value)
				{
					case LAYOUT_HORIZONTAL:
					{
						contentGroup.layout = new HorizontalLayout;
						break;
					}
					case LAYOUT_VERTICAL:
					{
						contentGroup.layout = new VerticalLayout;
						break;
					}	
					default:
					{
						contentGroup.layout = new BasicLayout;
						break;
					}
				}
			}
			
			if (_containerType == CONTAINER_DIV)
			{
				if (_layoutType == LAYOUT_HORIZONTAL)
				{
					setStyleProperty("display", "flex");
                }
				else if (_layoutType == LAYOUT_VERTICAL)
				{
					setStyleProperty("display", "");
                }
			}
		}
		
		private var _containerType:String = CONTAINER_HGROUP;
		
		[Bindable("change")]
		public function get containerType():String
		{
			return _containerType;
		}
		public function set containerType(value:String):void
		{
			if (_containerType == value) return;
			_containerType = value;
		}
		
		private var _containerStyles:Dictionary = new Dictionary();
		
		[Bindable("change")]
		public function get containerStyles():Dictionary
		{
			return _containerStyles;
		}
		public function set containerStyles(value:Dictionary):void
		{
			_containerStyles = value;
		}
		
		protected function setStyleProperty(attr:String, value:String):void
		{
			containerStyles[attr] = value;
		}
		
		protected function getContainerStylesString():String
		{
			var tmpArr:Array = [];
			for (var i:String in containerStyles)
			{
				tmpArr.push(i +":"+ containerStyles[i]);	
			}
			
			return tmpArr.join(";");
		}
		
		protected function setContainerStylesFromString(value:String):void
		{
			var tmpArr:Array = value.split(";");
			containerStyles = new Dictionary();
			
			for (var i:int; i < tmpArr.length; i++)
			{
				var tmpEntry:Array = tmpArr[i].split(":");
				containerStyles[tmpEntry[0]] = tmpEntry[1];
			}
		}

		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			setCommonXMLAttributes(xml);

            xml.@bgColor = this.backgroundColor;
			xml.@containerStyles = getContainerStylesString();
            xml.@containerType = this.containerType;
            xml.@layoutType = this.layoutType;
			
			var elementCount:int = this.numElements;
			for(var i:int = 0; i < elementCount; i++)
			{
				var element:ISurfaceComponent = this.getElementAt(i) as ISurfaceComponent;
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
			this.x = xml.@x;
			this.y = xml.@y;
			this.width = xml.@width;
			this.height = xml.@height;
			this.backgroundColor = xml.@bgColor;
			this.containerType = xml.@containerType;
			this.layoutType = xml.@layoutType;
			this.setContainerStylesFromString(xml.@containerStyles);
			var elementsXML:XMLList = xml.elements();
			var childCount:int = elementsXML.length();
			for(var i:int = 0; i < childCount; i++)
			{
				var childXML:XML = elementsXML[i];
				callback(this, childXML);
			}
		}

        public function toMXML():XML
        {
            var xml:XML = new XML("<" + MXML_ELEMENT_NAME + "/>");

            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            xml.@backgroundColor = this.backgroundColor;
			setCommonXMLAttributes(xml);

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:ISurfaceComponent = this.getElementAt(i) as ISurfaceComponent;
                if(element === null)
                {
                    continue;
                }

                CONFIG::MOONSHINE
                {
                    xml.appendChild(element.toMXML());
                }
            }

            return xml;
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = GenericUtils.getWidth(this);
            xml.@height = this.height;
		}
    }
}
