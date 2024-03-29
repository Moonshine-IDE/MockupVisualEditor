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
package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

	import interfaces.ILookup;
	import interfaces.ISurface;

	import mx.controls.HRule;
    import mx.graphics.SolidColor;
    import mx.graphics.SolidColorStroke;
    import mx.utils.StringUtil;
    
    import spark.components.BorderContainer;
    import spark.components.HGroup;
    import spark.components.TextArea;
    import spark.layouts.VerticalAlign;
    import spark.layouts.VerticalLayout;
    import spark.primitives.BitmapImage;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IInitializeAfterAddedComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.primeFaces.propertyEditors.TextEditorPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.ITextEditor;
    import components.primeFaces.TextEditor;
    import mx.controls.Alert;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="mainXML", kind="property")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="createChildren", kind="method")]
    [Exclude(name="setCommonXMLAttributes", kind="method")]
	[Exclude(name="componentAddedToEditor", kind="method")]
	[Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="editor", kind="property")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces TextEditor component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;TextEditor
     * <b>Attributes</b>
     * width="250"
     * height="100"
     * percentWidth=""
     * percentHeight=""
     * placeholder=""
     * text=""
     * widgetVar=""
     * /&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:textEditor
     * <b>Attributes</b>
     * style="width:250px;height:100px;"
     * placeholder=""
     * value=""
     * widgetVar=""
     * /&gt;
     * </pre>
     */
    public class TextEditor extends BorderContainer implements IGetChildrenSurfaceComponent, IHistorySurfaceComponent,
			IInitializeAfterAddedComponent, ICDATAInformation
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "textEditor";
        public static const ELEMENT_NAME:String = "TextEditor";
		
		private var component:ITextEditor;
		
		[Embed(source='/assets/richTextThumbItems.png')]
		private var menuThumbnail: Class;
		[Embed(source='/assets/richTextMenuItem1.png')]
		private var menuOption1: Class;
		[Embed(source='/assets/richTextMenuItem2.png')]
		private var menuOption2: Class;
		
		private var hRule:HRule;
		private var menuGroup:HGroup;
		
        public function TextEditor()
        {
            super();
			
			component = new components.primeFaces.TextEditor();
			
            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"widgetVarChanged",
				"textChanged",
				"placeholderChanged"
            ];
			
			backgroundFill = new SolidColor(0xFCFCFC);
			borderStroke = new SolidColorStroke(0xCCCCCC);
			
            var vLayout:VerticalLayout = new VerticalLayout();
			vLayout.gap = 0;
            layout = vLayout;
			
			width = minWidth = 110;
			height = minHeight = 80;
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
		
		private var _isUpdating:Boolean;
		public function get isUpdating():Boolean
		{
			return _isUpdating;
		}
		
		public function set isUpdating(value:Boolean):void
		{
			_isUpdating = value;
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
            return TextEditorPropertyEditor;
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

		private var _editor:TextArea;
		public function get editor():TextArea
		{
			return _editor;
		}
		
		private var _pendingText:String;
		
		[Inspectable(category="General", defaultValue="")]
		[Bindable("textChanged")]
		/**
		 * <p>PrimeFaces: <strong>value</strong></p>
		 *
         * @default null
         *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;TextEditor text=""/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:textEditor value=""/&gt;</listing>
		 */
		public function set text(value:String):void
		{
			// generally gets called when XMLtoCode and
			// before creation of the _editor component
			if (!_editor)
			{
				_pendingText = value;
				return;
			}
			
			if (_editor.text != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "text", _editor.text, value);
				
				_editor.text = value;
				dispatchEvent(new Event("textChanged"));
			}
		}
		public function get text():String
		{
			return _editor.text;
		}
		
		private var _pendingPlaceHolder:String;
		
		[Inspectable(category="General", defaultValue="")]
		[Bindable("placeholderChanged")]
		/**
		 * <p>PrimeFaces: <strong>placeholder</strong></p>
		 *
         * @default null
         *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;TextEditor placeholder=""/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:textEditor placeholder=""/&gt;</listing>
		 */
		public function set placeholder(value:String):void
		{
			// generally gets called when XMLtoCode and
			// before creation of the _editor component
			if (!_pendingPlaceHolder)
			{
				_pendingPlaceHolder = value;
				return;
			}
			
			if (_editor.prompt != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "placeholder", _editor.prompt, value);
				
				_editor.prompt = value;
				dispatchEvent(new Event("placeholderChanged"));
			}
		}
		public function get placeholder():String
		{
			return _editor.prompt;
		}

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;TextEditor percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:textEditor style="width:80%;"/&gt;</listing>
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
         * @default "250"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;TextEditor width="250"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:textEditor style="width:250px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;TextEditor percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:textEditor style="height:80%;"/&gt;</listing>
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
         * @default "100"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;TextEditor height="100"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:textEditor style="height:100px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }
		
		private var _widgetVar:String;
		
		[Bindable("widgetVarChanged")]
		/**
		 * <p>PrimeFaces: <strong>widgetVar</strong></p>
		 *
         * @default null
         *
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;TextEditor widgetVar=""/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
		 * <listing version="3.0">&lt;p:textEditor widgetVar=""/&gt;</listing>
		 */
		public function set widgetVar(value:String):void
		{
			if (_widgetVar != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "widgetVar", _widgetVar, value);
				
				_widgetVar = value;
				dispatchEvent(new Event("widgetVarChanged"));
			}
		}
		public function get widgetVar():String
		{
			return _widgetVar;
		}
		
        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        public function getComponentsChildren(...params):OrganizerItem
        {
            // @note @return
            // children = null (if not a drop acceptable component, i.e. text input, button etc.)
            // children = [] (if drop acceptable component, i.e. div, tab etc.)
            return (new OrganizerItem(this, ELEMENT_NAME, null));
        }

        public function componentAddedToEditor():void
        {
            // update size
            width = (width == 110) ? 250 : width;
            height = (height == 80) ? 100 : height;
            minWidth = 120;

            // change/update styles
            backgroundFill = new SolidColor(0xFFFFFF);

            menuGroup.paddingLeft = menuGroup.paddingRight = 12;
            menuGroup.paddingTop = menuGroup.paddingBottom = 8;
            menuGroup.minHeight = 24;

            _editor.setStyle("paddingLeft", 12);
            _editor.setStyle("paddingRight", 12);

            // update menu images to bit more realistic
            generateMenuImages(true);
            if (_pendingText)
            {
                _editor.text = _pendingText;
                _pendingText = null;
            }
            if (_pendingPlaceHolder)
            {
                _editor.prompt = _pendingPlaceHolder;
                _pendingPlaceHolder = null;
            }
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            setCommonXMLAttributes(xml);
			xml.@text = this.text;
			if (this.widgetVar) xml.@widgetVar = this.widgetVar;
			if (this.placeholder) xml.@placeholder = this.placeholder;
            return xml;
        }

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

			XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);
			
			component.fromXML(xml, callback, localSurface, lookup);
			
			this.widgetVar = component.widgetVar;
			this.text = component.text;
			this.placeholder = component.placeholder;
			
			this.callLater(componentAddedToEditor);
        }

        public function toCode():XML
        {
			component.widgetVar = this.widgetVar;
			component.text = this.text;
			component.placeholder = this.placeholder;
			
			component.isSelected = this.isSelected;
			(component as components.primeFaces.TextEditor).width = this.width;
			(component as components.primeFaces.TextEditor).height = this.width;
			(component as components.primeFaces.TextEditor).percentWidth = this.percentWidth;
			(component as components.primeFaces.TextEditor).percentHeight = this.percentHeight;
			
			return component.toCode();
        }

        public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
        public function toRora():XML
        {   
            Alert.show("Mock toRoyaleConvertCode execute1");
            return null;
        }
		
        protected function setCommonXMLAttributes(xml:XML):void
        {
            if (!isNaN(this.percentWidth))
            {
                xml.@percentWidth = this.percentWidth;
            }
            else
            {
                xml.@width = this.width;
            }

            if (!isNaN(this.percentHeight))
            {
                xml.@percentHeight = this.percentHeight;
            }
            else
            {
                xml.@height = this.height;
            }
        }
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			if (!menuGroup)
			{
				menuGroup = new HGroup();
				menuGroup.percentWidth = 100;
				menuGroup.minHeight = 16;
				menuGroup.padding = 8;
				menuGroup.verticalAlign = VerticalAlign.MIDDLE;
				menuGroup.clipAndEnableScrolling = true;
				addElement(menuGroup);
				
				hRule = new HRule();
				hRule.setStyle("strokeWidth", 1);
				hRule.setStyle("strokeColor", 0xcccccc);
				hRule.percentWidth = 100;
				addElement(hRule);
				
				_editor = new TextArea();
				_editor.percentWidth = _editor.percentHeight = 100;
				_editor.editable = _editor.selectable = false;
				_editor.setStyle("paddingTop", 12);
				_editor.setStyle("paddingBottom", 12);
				_editor.setStyle("paddingLeft", 8);
				_editor.setStyle("paddingRight", 8);
				_editor.setStyle("borderVisible", "false");
				_editor.prompt = "Input Text";
				addElement(_editor);
				
				generateMenuImages();
			}
		}
		
		private function generateMenuImages(afterAdded:Boolean=false):void
		{
			var tmpImage:BitmapImage;
			if (!afterAdded)
			{
				tmpImage = new BitmapImage();
				tmpImage.source = new menuThumbnail();
				menuGroup.addElement(tmpImage);
			}
			else
			{
				// clear exisint menu option icon image 
				// and a bit more realistic ones
				menuGroup.removeAllElements();
				
				tmpImage = new BitmapImage();
				tmpImage.source = new menuOption1();
				menuGroup.addElement(tmpImage);
				tmpImage = new BitmapImage();
				tmpImage.source = new menuOption2();
				menuGroup.addElement(tmpImage);
			}
		}
    }
}