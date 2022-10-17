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

package view.domino.surfaceComponents.components
{
	import interfaces.IComponentPercentSizeOutput;
	import interfaces.IComponentSizeOutput;
	import interfaces.ILookup;
	import interfaces.IRoyaleComponentConverter;
	import interfaces.ISurface;

	import mx.core.IVisualElement;
    
    import data.OrganizerItem;

    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;
    import view.interfaces.IDominoParagraph;
    import view.interfaces.IDropAcceptableComponent;
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.domino.propertyEditors.PargraphPropertyEditor;
    import view.primeFaces.supportClasses.Container;
    import view.primeFaces.supportClasses.ContainerDirection;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IDominoParagraph
    import components.domino.DominoParagraph;

    import view.interfaces.IDominoSurfaceComponent;

    import view.global.Globals;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="div", kind="property")]
    [Exclude(name="restorePropertyOnChangeReference", kind="method")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]
    [Exclude(name="internalToXML", kind="method")]
    [Exclude(name="mainXML", kind="property")]
    [Exclude(name="widthOutput", kind="property")]
    [Exclude(name="heightOutput", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="dropElementAt", kind="method")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]
    [Exclude(name="_cdataXML", kind="property")]
    [Exclude(name="_cdataInformation", kind="property")]
    [Exclude(name="contentChanged", kind="property")]

    /**
	 *  <p>Representation and converter from paragraph element  </p>
	 * 
	 *  <p>This class work for  convert from paragraph element of Visuale label/text/field  components  to target framework of body format.</p>
	 *  Conversion status<ul>
	 *   <li>Domino:  Complete</li>
	 *   <li>Royale:  TODO</li>
	 * </ul>
	 * 
	 * <p>Input:  view.domino.surfaceComponents.components.DominoParagraph</p>
	 * <p> Example Domino output:</p>
	 * <pre>
	 *  &lt;par def=&quot;1019&quot; paragraph=&quot;true&quot; dominotype=&quot;paragraph&quot; class=&quot;flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop&quot;/&gt;
	 * </pre> 
	 *
	 * <p> Example Royale output:</p>
	 * <pre>
	 * TODO
     * </pre>
	 *
	 * @see https://help.hcltechsw.com/dom_designer/10.0.1/basic/H_PARAGRAPH_ELEMENT_XML.html
	 * @see https://github.com/Moonshine-IDE/VisualEditorConverterLib/blob/master/src/components/domino/DominoParagraph.as
	 */
    public class DominoParagraph extends Container implements IDominoSurfaceComponent, view.interfaces.IDominoParagraph,
            IHistorySurfaceComponent, IComponentSizeOutput, IDropAcceptableComponent, ICDATAInformation, IRoyaleComponentConverter, IComponentPercentSizeOutput
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "paragraph";
        public static var ELEMENT_NAME:String = "Paragraph";

		private var component:interfaces.components.IDominoParagraph;
		
        protected var mainXML:XML;

        public function DominoParagraph()
        {
			this._wrap = true;

            super();

			component = new components.domino.DominoParagraph(this);

			this.percentWidth = 100;
            this.minWidth = Globals.MainApplicationWidth;
            this.minHeight = 40;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "titleChanged",
                "directionChanged",
                "wrapChanged",
                "gapChanged",
                "verticalAlignChanged",
                "horizontalAlignChanged"
            ];
        }

        		private var _leftmargin:String;
		public function get leftmargin():String{
			return _leftmargin;
		}
        public function set leftmargin(value:String):void
		{
			_leftmargin = value;
		}

		private var _firstlineleftmargin:String;
		public function get firstlineleftmargin():String
		{
			return _firstlineleftmargin;
		}
        public function set firstlineleftmargin(value:String):void
		{
			 _firstlineleftmargin= value;
		}

		private var _widthPercent:Number;

		public function get widthPercent():Number
		{
			return _widthPercent;
		}

		private var  _heightPercent:Number;

		public function get heightPercent():Number
		{
			return _heightPercent;
		}

        private var _widthOutput:Boolean = true;
        protected var widthOutputChanged:Boolean;

        [Bindable]
        public function get widthOutput():Boolean
        {
            return _widthOutput;
        }

        public function set widthOutput(value:Boolean):void
        {
            if (_widthOutput != value)
            {
                _widthOutput = value;

                if (!value)
                {
                    widthOutputChanged = true;
                    this.invalidateProperties();
                }
            }
        }

        private var _heightOutput:Boolean;
        protected var heightOutputChanged:Boolean;

        [Bindable]
        public function get heightOutput():Boolean
        {
            return _heightOutput;
        }

        public function set heightOutput(value:Boolean):void
        {
            if (_heightOutput != value)
            {
                _heightOutput = value;

                if (!value)
                {
                    heightOutputChanged = true;
                    this.invalidateProperties();
                }
            }
        }


        public function get dominoParagraph():DominoParagraph
        {
            return this;
        }

        protected var _cdataXML:XML;

        public function get cdataXML():XML
        {
            return _cdataXML;
        }

        protected var _cdataInformation:String;

        public function get cdataInformation():String
        {
            return _cdataInformation;
        }

        private var _cssClass:String;
        /**
         * <p>HTML: <strong>class</strong></p>
         *
         * <p>This property helps laying out children Horizontally or Vertically. It uses browser FlexBox mechanism to avoid problems which occurs when children in div are positioned using default mechanism. Exported PrimeFaces project contains moonshine-layout-styles.css file which has classes ready to use for laying out children.</p>
         *
         * <p>Use listed css classes to laying out children:</p>
         *
         * <p><strong>Horizontal Layout</strong></p>
         * <ul>
         *  <li>flexHorizontalLayoutWrap</li>
         *  <li>flexHorizontalLayout</li>
         *  <li>flexHorizontalLayoutLeft</li>
         *  <li>flexHorizontalLayoutRight</li>
         *  <li>flexHorizontalLayoutTop</li>
         *  <li>flexHorizontalLayoutBottom</li>
         * </ul>
         *
         * <p><strong>Vertical Layout</strong></p>
         * <ul>
         *  <li>flexVerticalLayoutWrap</li>
         *  <li>flexVerticalLayout</li>
         *  <li>flexVerticalLayoutLeft</li>
         *  <li>flexVerticalLayoutRight</li>
         *  <li>flexVerticalLayoutTop</li>
         *  <li>flexVerticalLayoutBottom</li>
         * </ul>
         *
         * <p><strong>Horizontal/Vertical Layout</strong></p>
         * <ul>
         *  <li>flexMiddle</li>
         *  <li>flexCenter</li>
         * </ul>
         *
         * https://css-tricks.com/snippets/css/a-guide-to-flexbox/
         *
         * @default "flexHorizontalLayoutWrap flexHorizontalLayoutLeft flexHorizontalLayoutTop"
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div class="flexHorizontalLayoutWrap flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;</listing>
         * @example
         * <strong>HTML:</strong>
         * <listing version="3.0">&lt;div class="flexHorizontalLayoutWrap flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;</listing>
         */
        public function get cssClass():String
        {
            return _cssClass;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>Domino <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div percentWidth="80"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;div style="width:80%;"/&gt;</listing>
         */
        override public function get percentWidth():Number
        {
            return super.percentWidth;
        }

		override public function set percentWidth(value:Number):void
		{
			if (isNaN(value))
			{
				if (super.percentWidth != value)
				{
					_widthPercent = super.percentWidth;
				}
			}
			else
			{
				_widthPercent = Number.NaN;
			}

			super.percentWidth = value;
		}

		[PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>Domino <strong>width</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div width="120"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;div style="width:120px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>Domino <strong>percentHeight</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div percentHeight="80"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;div style="height:80%;"/&gt;</listing>
         */
        override public function get percentHeight():Number
        {
            return super.percentHeight;
        }

		override public function set percentHeight(value:Number):void
		{
			if (isNaN(value))
			{
				if (super.percentHeight != value)
				{
					_heightPercent = super.percentHeight;
				}
			}
			else
			{
				_heightPercent = Number.NaN;
			}

			super.percentHeight = value;
		}

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>Domino <strong>height</strong></p>
         *
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Div height="120"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;div style="height:120px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        override public function set height(value:Number):void
        {
            super.height = value;
        }

        public function get div():DominoParagraph
        {
            return this;
        }

        public function get propertyEditorClass():Class
        {
            return PargraphPropertyEditor;
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

        private var _isNewLine:String;
		public function get isNewLine():String
		{
			return _isNewLine;
		}
		public function set isNewLine(value:String):void
		{
			_isNewLine = value;
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


        private var _hide:String;
		public function get hide():String
		{
			return _hide;
		}
		public function set hide(value:String):void
		{
			_hide = value;
		}

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        override protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
        {
            _propertyChangeFieldReference = new PropertyChangeReference(this, fieldName, oldValue, newValue);
        }

        public function restorePropertyOnChangeReference(nameField:String, value:*, eventType:String=null):void
		{
			this[nameField.toString()] = value;
		}

		public function getComponentsChildren(...params):OrganizerItem
		{
			var componentsArray:Array = [];
			var organizerItem:OrganizerItem;
			var element:IGetChildrenSurfaceComponent;
			for(var i:int = 0; i < this.numElements; i++)
			{
				element = this.getElementAt(i) as IGetChildrenSurfaceComponent;
				if (!element)
				{
					continue;
				}
				
				organizerItem = element.getComponentsChildren();
				if (organizerItem) componentsArray.push(organizerItem);
			}
			
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, (componentsArray.length > 0) ? componentsArray : []));
		}
		
		public function dropElementAt(element:IVisualElement, index:int):void
		{
			this.addElementAt(element, index);
		}

        public function toXML():XML
        {
            mainXML = new XML("<" + ELEMENT_NAME + "/>");
            if(this.isNewLine){
                mainXML.@isNewLine= this.isNewLine;
            }else{

            }

            if(this.leftmargin){
                mainXML.@leftmargin= this.leftmargin;
            }

            if(this.firstlineleftmargin)
            {
                mainXML.@firstlineleftmargin= this.firstlineleftmargin;
            }

            return this.internalToXML();
        }

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

            component.fromXML(xml, callback, localSurface, lookup);
            this.isNewLine = component.isNewLine;
			_cssClass = component.cssClass;
			wrap = component.wrap;

            if(xml.@leftmargin){
                this.leftmargin=xml.@leftmargin;
            }

            if(xml.@firstlineleftmargin){
                this.firstlineleftmargin=xml.@firstlineleftmargin;
            }
			
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
            XMLCodeUtils.applyChildrenPositionFromXMLParagraph(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

			this.heightOutput = false;
        }

        public function toCode():XML
        {
			component.isSelected = this.isSelected;
			(component as components.domino.DominoParagraph).width = this.width;
			(component as components.domino.DominoParagraph).height = this.width;
			(component as components.domino.DominoParagraph).percentWidth = this.percentWidth;
			(component as components.domino.DominoParagraph).percentHeight = this.percentHeight;
            (component as components.domino.DominoParagraph).hide = this.hide;
            (component as components.domino.DominoParagraph).isNewLine = this.isNewLine;
            (component as components.domino.DominoParagraph).leftmargin = this.leftmargin;
            (component as components.domino.DominoParagraph).firstlineleftmargin = this.firstlineleftmargin;
            var xml:XML = component.toCode();
	
            xml["@class"] = XMLCodeUtils.getChildrenPositionForXML(this);

            return xml;
        }

        public	function toRoyaleConvertCode():XML
		{
			return new XML("");
		}

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (this.widthOutputChanged)
            {
                this.percentWidth = Number.NaN;
                this.width = Number.NaN;
                this.widthOutputChanged = false;
            }

            if (this.heightOutputChanged)
            {
                this.percentHeight = Number.NaN;
                this.height = Number.NaN;
                this.heightOutputChanged = false;
            }
        }

        protected function internalToXML():XML
        {
            XMLCodeUtils.setSizeFromComponentToXML(this, mainXML);

            mainXML["@class"] = _cssClass = XMLCodeUtils.getChildrenPositionForXML(this);
            mainXML.@wrap = this.wrap;

            if (cdataXML)
            {
                mainXML.appendChild(cdataXML);
            }

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IGetChildrenSurfaceComponent = this.getElementAt(i) as IGetChildrenSurfaceComponent;
                if(element === null)
                {
                    continue;
                }
                mainXML.appendChild(element.toXML());
            }
            return mainXML;
        }

        protected function resetPercentWidthHeightBasedOnLayout():void
        {
            if (isNaN(this.percentHeight) && isNaN(this.percentWidth)) return;

            var childrensHeight:Number = 0;
            var childrensWidth:Number = 0;
            var numEl:int = this.numElements;

            for (var i:int = 0; i < numEl; i++)
            {
                var element:IVisualElement = this.getElementAt(i);
                if (direction == ContainerDirection.VERTICAL_LAYOUT)
                {
                    if (!isNaN(element.height))
                    {
                        childrensHeight += element.height;
                    }

                    if (childrensWidth < element.width)
                    {
                        if (!isNaN(element.width))
                        {
                            childrensWidth = element.width;
                        }
                    }
                }
                else if (direction == ContainerDirection.HORIZONTAL_LAYOUT)
                {
                    if (!isNaN(element.width))
                    {
                        childrensWidth += element.width;
                    }

                    if (childrensHeight < element.height)
                    {
                        if (!isNaN(element.height))
                        {
                            childrensHeight = element.height;
                        }
                    }
                }
            }

            if (childrensHeight > this.height && !isNaN(this.percentHeight))
            {
                this.percentHeight = Number.NaN;
            }

            if (childrensWidth > this.width && !isNaN(this.percentWidth))
            {
                this.percentWidth = Number.NaN;
            }
        }
    }
}