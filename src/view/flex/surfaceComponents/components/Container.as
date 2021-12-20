////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package view.flex.surfaceComponents.components
{
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;
	import mx.events.FlexEvent;
	
	import spark.components.BorderContainer;
	import spark.layouts.BasicLayout;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.VerticalLayout;
	
	import utils.GenericUtils;
	import utils.MxmlCodeUtils;
	
	import view.flex.propertyEditors.ContainerPropertyEditor;
	import view.interfaces.IFlexSurfaceComponent;
	import view.interfaces.ILayoutContainer;
	import view.interfaces.ISurfaceComponent;
	
    import mx.controls.Alert;

	public class Container extends BorderContainer implements ILayoutContainer, IFlexSurfaceComponent
	{
		public static const MXML_ELEMENT_NAME:String = "BorderContainer";
		public static const ELEMENT_NAME:String = "container";
		public static const LAYOUT_HORIZONTAL:String = "HorizontalLayout";
		public static const LAYOUT_VERTICAL:String = "VerticalLayout";
		public static const LAYOUT_BASIC:String = "BasicLayout";
		public static const CONTAINER_GROUP:String = "Group";
		public static const CONTAINER_VGROUP:String = "VGroup";
		public static const CONTAINER_HGROUP:String = "HGroup";

		public function Container()
		{
			this.width = 200;
			this.height = 200;
			this.minWidth = 20;
			this.minHeight = 20;
			
			this._layoutTypes = new ArrayList([LAYOUT_BASIC, LAYOUT_HORIZONTAL, LAYOUT_VERTICAL]);
			this._containerTypes = new ArrayList([CONTAINER_GROUP, CONTAINER_VGROUP, CONTAINER_HGROUP]);
			
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationCompletes, false, 0, true);

            _propertiesChangedEvents = [
                "xChanged",
                "yChanged",
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged"
            ];
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

        public function toCode():XML
        {
            var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, MXML_ELEMENT_NAME) + "/>");

            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            xml.@backgroundColor = this.backgroundColor;
			setCommonXMLAttributes(xml);

            xml.appendChild(layoutToMXML());

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IFlexSurfaceComponent = this.getElementAt(i) as IFlexSurfaceComponent;
                if(element === null)
                {
                    continue;
                }

				xml.appendChild(element.toCode());
            }

            return xml;
        }

		public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
		public function toRora():XML
        {
			Alert.show("Container to Royale");
            return null;
        }

        private function setCommonXMLAttributes(xml:XML):void
		{
            xml.@x = this.x;
            xml.@y = this.y;
            xml.@width = GenericUtils.getWidth(this);
            xml.@height = this.height;
		}

		private function layoutToMXML():XML
		{
            var xml:XML = new XML("<layout></layout>");

            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);

            var mxmlLayout:XML = new XML("<" + layoutType + "/>");
            mxmlLayout.addNamespace(sparkNamespace);
            mxmlLayout.setNamespace(sparkNamespace);

            xml.appendChild(mxmlLayout);

			return xml;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }
    }
}
