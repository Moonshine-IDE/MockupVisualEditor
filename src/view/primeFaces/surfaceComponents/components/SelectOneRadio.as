////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2016-present Prominic.NET, Inc.
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
package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    import flash.net.registerClassAlias;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import mx.collections.ArrayCollection;
    import mx.containers.GridItem;
    import mx.containers.GridRow;
    import mx.core.IVisualElementContainer;
    import mx.core.ScrollPolicy;
    import mx.utils.ObjectUtil;
    
    import spark.components.RadioButton;
    import spark.components.RadioButtonGroup;
    import spark.layouts.HorizontalLayout;
    
    import data.ConstantsItems;
    import data.OrganizerItem;
    
    import skins.RadioButtonPrimeFacesSkin;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;

    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IInitializeAfterAddedComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.interfaces.ISelectableItemsComponent;
    import view.primeFaces.propertyEditors.SelectOneRadioPropertyEditor;
    import view.suportClasses.GridBase;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;
    import interfaces.components.ISelectOneRadio;
    import components.primeFaces.SelectOneRadio;
    import vo.SelectItem;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]
	[Exclude(name="componentAddedToEditor", kind="method")]
	[Exclude(name="getComponentsChildren", kind="method")]
	[Exclude(name="updateItems", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="selectedIndex", kind="property")]
	[Exclude(name="items", kind="property")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of selectOneRadio in HTML</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;SelectOneRadio
     * <b>Attributes</b>
     * width="230"
     * height="21"
	 * value=""
	 * columns="0"
     * percentWidth=""
     * percentHeight=""&gt;
	 *	&lt;selectItem itemLabel="Title" itemValue=""/&gt;
	 * &lt;/SelectOneRadio&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:selectOneRadio
     * <b>Attributes</b>
	 * value=""
	 * columns="0"
     * style="width:230px;height:21px;"&gt;
	 * 	&lt;f:selectItem itemLabel="Title" itemValue=""/&gt;
     * &lt;/p:selectOneRadio&gt;
     * </pre>
     */
    public class SelectOneRadio extends GridBase implements ISelectableItemsComponent, IGetChildrenSurfaceComponent,
			IHistorySurfaceCustomHandlerComponent, IInitializeAfterAddedComponent, ICDATAInformation
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "selectOneRadio";
        public static const ELEMENT_NAME:String = "SelectOneRadio";

		private var component:ISelectOneRadio;
		
        public function SelectOneRadio()
        {
            super();
			
			component = new components.primeFaces.SelectOneRadio();
			items = new ArrayCollection(component.items);

	        this.width = 100;
			this.height = 21;
            this.minWidth = 20;
            this.minHeight = 20;
			
			this.setStyle("verticalGap", 1);
			this.setStyle("horizontalGap", 1);
			this.setStyle("verticalScrollPolicy", ScrollPolicy.OFF);
			this.setStyle("horizontalScrollPolicy", ScrollPolicy.OFF);

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"columnsChanged",
				"valueChanged",
				"itemRemoved",
				"itemAdded",
				"itemUpdated"
            ];
			
			var tmpItem:SelectItem = new SelectItem();
			tmpItem.itemLabel = "Title";
			tmpItem.isSelected = true;
			
			items.addItem(tmpItem);
			this.columnBorderAlpha = 0;
			this.ensureCreateInitialRowWithColumn();
			addRadio((this.getElementAt(0) as GridRow).getElementAt(0) as GridItem, items[0]);
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

        private var _isUpdating:Boolean;
        public function get isUpdating():Boolean
        {
            return _isUpdating;
        }

        public function set isUpdating(value:Boolean):void
        {
            _isUpdating = value;
        }

        private var _propertyChangeFieldReference:PropertyChangeReference;
        public function get propertyChangeFieldReference():PropertyChangeReference
        {
            return _propertyChangeFieldReference;
        }

        public function set propertyChangeFieldReference(value:PropertyChangeReference):void
        {
            _propertyChangeFieldReference = value;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
        {
            _propertyChangeFieldReference = new PropertyChangeReference(this, fieldName, oldValue, newValue);
        }

        public function get propertyEditorClass():Class
        {
            return SelectOneRadioPropertyEditor;
        }

        private var _cdataXML:XML;

        public function get cdataXML():XML
        {
            return _cdataXML;
        }

        private var _cdataInformation:String;

        public function get cdataInformation():String
        {
            return _cdataInformation;
        }

		private var _items:ArrayCollection;
		[Bindable("itemsChanged")]
		public function get items():ArrayCollection
		{
			return _items;
		}
		public function set items(value:ArrayCollection):void
		{
			if (_items === value) return;
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "items", _items, value);
			
			_items = value;
			dispatchEvent(new Event("itemsChanged"));
		}
		
		private var _value:String = "";
		[Bindable("valueChanged")]
		/**
		 * <p>PrimeFaces: <strong>value</strong></p>
		 *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;SelectOneRadio value=""/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:selectOneRadio value=""/&gt;</listing>
		 */
		public function get value():String
		{
			return _value;
		}
		public function set value(value:String):void
		{
			if (_value === value) return;
			
			_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "value", _value, value);
			
			_value = value;
			dispatchEvent(new Event("valueChanged"));
		}
		
		private var _radioGroup:RadioButtonGroup = new RadioButtonGroup();
		public function get selectedIndex():int
		{
			return _radioGroup.selectedIndex;
		}
		public function set selectedIndex(value:int):void
		{
			
		}
		
		[Inspectable(environment="none")]
		[Bindable("resize")]
		/**
		 * <p>PrimeFaces: <strong>style</strong></p>
		 *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;SelectOneRadio percentWidth="80"/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;selectOneRadio style="width:80%;"/&gt;</listing>
		 */
		override public function get percentWidth():Number
		{
			return super.percentWidth;
		}
		
		[PercentProxy("percentWidth")]
		[Inspectable(category="General")]
		[Bindable("widthChanged")]
		/**
		 * <p>PrimeFaces: <strong>style</strong></p>
		 *
		 * @default "120"
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;SelectOneRadio width="120"/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;selectOneRadio style="width:120px;"/&gt;</listing>
		 */
		override public function get width():Number
		{
			return super.width;
		}
		
		[Inspectable(environment="none")]
		[Bindable("resize")]
		/**
		 * <p>PrimeFaces: <strong>style</strong></p>
		 *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;SelectOneRadio percentHeight="80"/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;selectOneRadio style="height:80%;"/&gt;</listing>
		 */
		override public function get percentHeight():Number
		{
			return super.percentHeight;
		}
		
		[PercentProxy("percentHeight")]
		[Inspectable(category="General")]
		[Bindable("heightChanged")]
		/**
		 * <p>PrimeFaces: <strong>style</strong></p>
		 *
		 * @default "120"
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;SelectOneRadio height="120"/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;selectOneRadio style="width:120px;height:120px;"/&gt;</listing>
		 */
		override public function get height():Number
		{
			return super.height;
		}
		
		private var _columns:int;
		[Bindable("columnsChanged")]
		/**
		 * <p>PrimeFaces: <strong>columns</strong></p>
		 * 
		 * @default 0
		 *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;SelectOneRadio columns="0"/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:selectOneRadio columns="0"/&gt;</listing>
		 */
		public function get columns():int
		{
			return _columns;
		}
		public function set columns(value:int):void
		{
			if (_columns != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "columns", _columns, value);
				
				_columns = value;
				dispatchEvent(new Event("columnsChanged"));
			}
		}
		
		public function restorePropertyOnChangeReference(nameField:String, value:*):void
		{
			var deleteIndex:int;
			switch(nameField)
			{
				case "removeItemAt":
					try
					{
						deleteIndex = items.getItemIndex(value.object);
						items.removeItemAt(deleteIndex);
					}
					catch(e:Error)
					{
						items.addItemAt(value.object, value.index);
					}
					
					generateColumns();
					break;
				case "addItemAt":
					try
					{
						deleteIndex = items.getItemIndex(value);
						items.removeItemAt(deleteIndex);
					}
					catch(e:Error)
					{
						items.addItem(value);
					}
					
					generateColumns();
					break;
				case "updateItemAt":
					SelectItem(items[value.index]).updateItemWith(value.object);
					updateColumn(value.index);
					break;
				default:
					this[nameField.toString()] = value;
					if (nameField.toString() == "columns") generateColumns();
					break;
			}
		}
		
		public function updateItems(updateType:String, itemIndex:int=-1):void
		{
			switch(updateType)
			{
				case ConstantsItems.ITEM_ADD:
					// item always added to last
					_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addItemAt", items[items.length - 1], items[items.length - 1]);
					dispatchEvent(new Event("itemAdded"));
					generateColumns();
					
					break;
				case ConstantsItems.ITEM_DELETE:
					if (itemIndex != -1)
					{
						if (!isUpdating)
						{
							var historyObject:Object = {object:items[itemIndex], index:itemIndex};
							_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeItemAt", historyObject, historyObject);
						}
						
						items.removeItemAt(itemIndex);
						generateColumns();
						dispatchEvent(new Event("itemRemoved"));
					}
					break;
				case ConstantsItems.ITEM_EDIT:
					if (itemIndex != -1)
					{
						// dispatch only if there are changes and user not just edit ended without makeing any change
						if (!isUpdating && (items[itemIndex] as SelectItem).isItemChanged(_propertyChangeFieldReference.fieldLastValue.object))
						{
							registerClassAlias("SelectItem", SelectItem);
							_propertyChangeFieldReference.fieldNewValue = {object:ObjectUtil.copy(items[itemIndex]), index:itemIndex};
							dispatchEvent(new Event("itemUpdated"));
							
							updateColumn(itemIndex);
						}
					}
					break;
				default:
					generateColumns();
					break;
			}
		}

        public function componentAddedToEditor():void
        {
            this.maxHeight = 21;
            this.width = 230;
        }

        public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, null));
		}
		
        public function toXML():XML
        {
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");
			
			XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

			xml["@value"] = this.value;
			if (columns > 0)
			{
				xml["@layout"] = "grid";
				xml["@columns"] = columns;
			}
			
			var itemXML:XML;
			for each (var item:SelectItem in items)
			{
				itemXML = new XML("<selectItem />");
				itemXML["@itemLabel"] = item.itemLabel;
				itemXML["@itemValue"] = item.itemValue;
				xml.appendChild(itemXML);
			}

            return xml;
        }
		
		public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

			componentAddedToEditor();
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

            items.removeAll();

			component.fromXML(xml, callback, localSurface, lookup);
			
			this.columns = component.columns;
			this.value = component.value;

			generateColumns();
        }

		public function toCode():XML
        {
			component.value = this.value;
			component.columns = this.columns;
			
			component.isSelected = this.isSelected;
			(component as components.primeFaces.SelectOneRadio).width = this.width;
			(component as components.primeFaces.SelectOneRadio).height = this.width;
			(component as components.primeFaces.SelectOneRadio).percentWidth = this.percentWidth;
			(component as components.primeFaces.SelectOneRadio).percentHeight = this.percentHeight;
			
            return component.toCode();
        }
		public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
		public function toRora():XML
        {
            return null;
        }
		private function addRadio(gridItem:GridItem, item:SelectItem):void
		{
			var tmpRadio:RadioButton = new RadioButton();
			tmpRadio.label = item.itemLabel;
			tmpRadio.value = item.itemValue;
			tmpRadio.selected = item.isSelected;
			tmpRadio.group = _radioGroup;
			tmpRadio.setStyle("skinClass", RadioButtonPrimeFacesSkin);
			(gridItem.getElementAt(0) as IVisualElementContainer).addElement(tmpRadio);
		}
		
		private function generateColumns():void
		{
			this.removeAllElements();
			this.height = this.maxHeight = 21;
			this.invalidateDisplayList();
			
			super.addRow();
			
			var cell:GridItem;
			var _rowIndex:int;
			var item:SelectItem;
			
			// when layout is not grid, or columns is 0
			if (columns == 0)
			{
				cell = (this.getElementAt(0) as GridRow).getElementAt(0) as GridItem;
				var tmpDiv:Div = ((this.getElementAt(0) as GridRow).getElementAt(0) as GridItem).getElementAt(0) as Div;
				(tmpDiv.layout as HorizontalLayout).gap = 15;
				for each (item in items)
				{
					addRadio(cell, item);
				}
			}
			else
			{
				var columnIndex:int;
				for each (item in items)
				{
					if (columnIndex == 0)
					{
						addRadio((this.getElementAt(_rowIndex) as GridRow).getElementAt(columnIndex) as GridItem, item);
						columnIndex++;
					}
					else if (columnIndex < columns)
					{
						cell = super.addColumn(_rowIndex);
						addRadio(cell, item);
						columnIndex++;
					} 
					else if (columnIndex == columns)
					{
						_rowIndex ++;
						columnIndex = 0;
						
						this.maxHeight = this.height = (this.height + 21);
						this.invalidateDisplayList();
						
						super.addRow();
						addRadio((this.getElementAt(_rowIndex) as GridRow).getElementAt(columnIndex) as GridItem, item);
						columnIndex++;
					}
				}
			}
		}
		
		private function updateColumn(atIndex:int):void
		{
			var tmpColIndex:int;
			var tmpRowIndex:int;
			var tmpItemIndex:int;
			
			// calculate row/column only if grid layout
			if (columns > 0)
			{
				tmpColIndex = atIndex;
				while (tmpColIndex >= columns)
				{
					tmpColIndex -= columns;
					tmpRowIndex ++;
				}
			}
			else
			{
				tmpItemIndex = atIndex;
			}
			
			var tmpRadio:RadioButton = (((this.getElementAt(tmpRowIndex) as GridRow).getElementAt(tmpColIndex) as GridItem).getElementAt(0) as Div).getElementAt(tmpItemIndex) as RadioButton;
			tmpRadio.label = items[atIndex].itemLabel;
		}
    }
}