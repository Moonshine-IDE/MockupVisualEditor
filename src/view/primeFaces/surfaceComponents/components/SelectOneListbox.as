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
    import components.primeFaces.SelectOneListbox;

    import data.ConstantsItems;
    import data.OrganizerItem;

    import flash.events.Event;
    import flash.net.registerClassAlias;

	import interfaces.ILookup;
	import interfaces.ISurface;
	import interfaces.ISurface;

	import interfaces.components.ISelectOneListbox;

    import mx.collections.ArrayCollection;
    import mx.utils.ObjectUtil;

    import spark.components.List;

    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;
    import view.interfaces.IHistorySurfaceCustomHandlerComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.interfaces.ISelectableItemsComponent;
    import view.primeFaces.propertyEditors.SelectOneListboxPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.PropertyChangeReferenceCustomHandlerBasic;

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
	[Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="isSelected", kind="property")]
	[Exclude(name="dataProvider", kind="property")]
	[Exclude(name="updateHistoryState", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of selectOneMenu in HTML</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;SelectOneListbox
     * <b>Attributes</b>
     * width="120"
     * height="30"
     * percentWidth=""
     * percentHeight=""
     * value=""&gt;
	 *  &lt;selectItem itemLabel="Title" itemValue=""/&gt;
	 * &lt;/SelectOneListbox&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:selectOneListbox
     * <b>Attributes</b>
     * style="width:120px;height:30px;"
     * value=""&gt;
	 *  &lt;f:selectItem itemLabel="Title" itemValue=""/&gt;
	 * &lt;/p:selectOneListbox&gt;
     * </pre>
     */
    public class SelectOneListbox extends List implements ISelectableItemsComponent, IGetChildrenSurfaceComponent,
            IHistorySurfaceCustomHandlerComponent, ICDATAInformation
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "selectOneListbox";
        public static const ELEMENT_NAME:String = "SelectOneListbox";

		private var component:ISelectOneListbox;
		
        public function SelectOneListbox()
        {
            super();
			
			component = new components.primeFaces.SelectOneListbox();
			
			this.width = 120;
			this.height = 120;
			this.minWidth = 20;
			this.minHeight = 20;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"valueChanged",
				"itemRemoved",
				"itemAdded",
				"itemUpdated"
            ];
            
			this.dataProvider = new ArrayCollection(component.dataProvider);
			this.labelField = "itemLabel";
			this.requireSelection = true;
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
            return SelectOneListboxPropertyEditor;
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

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;SelectOneListbox percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneListbox style="percentWidth:80%;"/&gt;</listing>
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
         * @default 120
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;SelectOneListbox width="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneListbox style="width:120px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;SelectOneListbox percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneListbox style="percentHeight:80%;"/&gt;</listing>
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
         * @default 30
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;SelectOneListbox height="30"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneListbox style="height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

		private var _value:String;

		[Bindable("valueChanged")]
        /**
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @default null
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;SelectOneListbox value=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:selectOneListbox value=""/&gt;</listing>
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

		public function restorePropertyOnChangeReference(nameField:String, value:*):void
		{
			var deleteIndex:int;
			switch(nameField)
			{
				case "removeItemAt":
					try
					{
						deleteIndex = dataProvider.getItemIndex(value.object);
						dataProvider.removeItemAt(deleteIndex);
					}
					catch(e:Error)
					{
						dataProvider.addItemAt(value.object, value.index);
					}
					
					break;
				case "addItemAt":
					try
					{
						deleteIndex = dataProvider.getItemIndex(value);
						dataProvider.removeItemAt(deleteIndex);
					}
					catch(e:Error)
					{
						dataProvider.addItem(value);
					}
					
					break;
				case "updateItemAt":
					SelectItem(dataProvider[value.index]).updateItemWith(value.object);
					break;
				default:
					this[nameField.toString()] = value;
					break;
			}
		}
		
		public function updateHistoryState(updateType:String=null, itemIndex:int=-1):void
		{
			switch(updateType)
			{
				case ConstantsItems.ITEM_ADD:
					// item always added to last
					_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "addItemAt", dataProvider[dataProvider.length - 1], dataProvider[dataProvider.length - 1]);
					dispatchEvent(new Event("itemAdded"));
					
					break;
				case ConstantsItems.ITEM_DELETE:
					if (itemIndex != -1)
					{
						if (!isUpdating)
						{
							var historyObject:Object = {object:dataProvider[itemIndex], index:itemIndex};
							_propertyChangeFieldReference = new PropertyChangeReferenceCustomHandlerBasic(this, "removeItemAt", historyObject, historyObject);
						}
						dispatchEvent(new Event("itemRemoved"));
					}
					break;
				case ConstantsItems.ITEM_EDIT:
					if (itemIndex != -1)
					{
						// dispatch only if there are changes and user not just edit ended without makeing any change
						if (!isUpdating && (dataProvider[itemIndex] as SelectItem).isItemChanged(_propertyChangeFieldReference.fieldLastValue.object))
						{
							registerClassAlias("SelectItem", SelectItem);
							_propertyChangeFieldReference.fieldNewValue = {object:ObjectUtil.copy(dataProvider[itemIndex]), index:itemIndex};
							dispatchEvent(new Event("itemUpdated"));
						}
					}
					break;
			}
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

			xml["@value"] = !this.value || this.value == "null" ? "" : this.value;
			
			var itemXML:XML;
			for each (var item:SelectItem in dataProvider)
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

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

			this.dataProvider.removeAll();
			
			component.fromXML(xml, callback, localSurface, lookup);
			
			this.value = component.value;
        }

		public function toCode():XML
        {
			component.value = this.value;
			
			component.isSelected = this.isSelected;
			(component as components.primeFaces.SelectOneListbox).width = this.width;
			(component as components.primeFaces.SelectOneListbox).height = this.width;
			(component as components.primeFaces.SelectOneListbox).percentWidth = this.percentWidth;
			(component as components.primeFaces.SelectOneListbox).percentHeight = this.percentHeight;
			
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
    }
}