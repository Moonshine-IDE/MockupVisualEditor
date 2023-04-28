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

package view.domino.surfaceComponents.components
{   
    import flash.events.Event;

    import interfaces.IComponentSizeOutput;
    import interfaces.ILookup;
    import interfaces.IRoyaleComponentConverter;
    import interfaces.ISurface;

    import spark.components.Label;
    import spark.layouts.VerticalAlign;
    
    import data.OrganizerItem;

    import utils.XMLCodeUtils;

    import view.interfaces.ICDATAInformation;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IDominoSurfaceComponent;
    import view.domino.propertyEditors.DominoLabelPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import components.domino.DominoPar;
    import components.domino.DominoRun;
    import components.domino.DominoFont;
    import components.domino.DominoLabel;

    import mx.collections.ArrayList;

    import utils.StringHelper;

    import interfaces.dominoComponents.IDominoLabel;
    import global.domino.DominoGlobalTokens;
    

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]
    /**
	 *  <p>Representation and converter for Visuale label  components </p>
	 * 
	 *  <p>This class work for  convert from Visuale label  components to target framework of domino format.</p>
	 *  Conversion status<ul>
	 *   <li>Domino:  Complete</li>
	 *   <li>Royale:  Partial</li>
	 * </ul>
	 * 
	 * <p>Input:  view.domino.surfaceComponents.components.DominoLabel</p>
	 * <p> Example Domino output:</p>
	 * <pre>
	 * &lt;par isNewLine=&quot;false&quot;&gt;
	 * 	&lt;run&gt;
	 *	 &lt;font color=&quot;system&quot; size=&quot;12pt&quot; style=&quot;normal&quot;/&gt;Label
	 *	&lt;/run&gt;
	 *	&lt;/par&gt;
	 * </pre> 
	 *
	 * <p> Example Royale output:</p>
	 * <pre>
	 * TODO
     * </pre>
	 *
	 * @see https://help.hcltechsw.com/dom_designer/10.0.1/basic/H_TEXT_ELEMENT_XML.html
	 * @see https://github.com/Moonshine-IDE/VisualEditorConverterLib/blob/master/src/components/domino/DominoLabel.as
	 */
    
    public class DominoLabel extends Label implements IDominoSurfaceComponent, IHistorySurfaceComponent,
            ICDATAInformation, IComponentSizeOutput, IRoyaleComponentConverter
    {
        public static const DOMINO_ELEMENT_NAME:String = "label";
       
        public static const ELEMENT_NAME:String = "Label";
		private var component:IDominoLabel;
		
        public function DominoLabel()
        {
            super();
            component = new components.domino.DominoLabel();
			
            this.text = "Label";

            this.setStyle("verticalAlign", VerticalAlign.MIDDLE);

            this.toolTip = "";
            this.width = 100;
            this.height = 30;
            this.minWidth = 20;
            this.minHeight = 20;
            this.maxDisplayedLines = -1;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "textChanged",
                "sizeChanged",
                "forAttributeChanged",
				"indicateRequiredChanged",
                "colorAttributeChanged",
                "fontStyleAttributeChanged",
                "hidewhenAttributeChanged",
                "fontNameAttributeChanged"
            ];
        }


        private var _hidewhen:String;
        /**
         * <p>Domino:Contains formula ,Represents  hide or show the element.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;par hidewhen=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;par hidewhen=""/&gt;</listing>
         */
        [Bindable(event="hidewhenAttributeChanged")]
		public function get hidewhen():String
		{
			return _hidewhen;
		}
		public function set hidewhen(value:String):void
		{
			if (_hidewhen != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "hidewhen", _hidewhen, value);
				
                _hidewhen = value;
                dispatchEvent(new Event("hidewhenAttributeChanged"))
            }
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


        [Bindable]
        private var _fontNames:ArrayList = DominoGlobalTokens.FontNames;


        public function get fontNames():ArrayList
        {
            return _fontNames;
        }

        private var _heightOutput:Boolean = true;
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

        public function get propertyEditorClass():Class
        {
            return DominoLabelPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;

        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
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

        private var _indicateRequired:Boolean;
        private var indicateRequiredChanged:Boolean;
		
		[Bindable("indicateRequiredChanged")]
        /**
         * <p>Domino: <strong>none</strong></p>
         *
         * @default "false"
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel indicateRequired="false"/&gt;</listing>
         */
        public function get indicateRequired():Boolean
        {
            return _indicateRequired;
        }
		
        public function set indicateRequired(value:Boolean):void
        {
            if (_indicateRequired != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "indicateRequired", _indicateRequired, value);
				
                _indicateRequired = value;
                indicateRequiredChanged = true;
                invalidateProperties();
				dispatchEvent(new Event("indicateRequiredChanged"));
            }
        }

      
        /****************************************************************
         * font color for lable
         * https://help.hcltechsw.com/dom_designer/10.0.1/basic/H_DEFINED_ENTITIES_XML.html
         * aqua | black | blue | fuchsia | gray | green | lime | 
         * maroon | navy | olive |purple | red | silver | teal |
         * white | yellow | none | system " 
         */
        [Bindable]
        private var _colors:ArrayList =DominoGlobalTokens.Colors;

        public function get colors():ArrayList
        {
            return _colors;
        }


        private var _color:String = "system";
         /**
         * <p>Domino:Color of the font.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Plan</td></tr>
         * <tr><td>PrimeFaces</td><td>Supported</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;font color=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;font color=""/&gt;</listing>
         */
		[Bindable(event="colorAttributeChanged")]
        public function get color():String
        {
            return _color;
        }
		
        public function set color(value:String):void
        {
            if (_color != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "color", _color, value);
				
                _color = value;
                var html_color:String =null;
                for(var i:int=0; i<_colors.length; i++)
                {
                 
                  if(_colors.getItemAt(i).label==value){
                      html_color=_colors.getItemAt(i).htmlcolor
                  }
                }

                if(html_color!=null){
                     super.setStyle("color",html_color);
                }
               
                dispatchEvent(new Event("colorAttributeChanged"))
            }
        }

        //------------font style--------------------------------------------

        //<!ENTITY % font.styles "normal | bold | italic | underline | strikethrough | superscript | subscript | shadow | emboss | extrude">
        [Bindable]
        private var _fontStyles:ArrayList =DominoGlobalTokens.FontStyles;


        public function get fontStyles():ArrayList
        {
            return _fontStyles;
        }

        private var _fontStyle:String = "normal";
        /**
         * <p>Domino:A list of tokens taken from the %font.styles; entity.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Plan</td></tr>
         * <tr><td>PrimeFaces</td><td>Supported</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;font fontStyle=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;font fontStyle=""/&gt;</listing>
         */
		[Bindable(event="fontStyleAttributeChanged")]
        public function get fontStyle():String
        {
            return _fontStyle;
        }
		
        public function set fontStyle(value:String):void
        {
            if (_fontStyle != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "fontStyle", _fontStyle, value);
				
                _fontStyle = value;
                
               
                dispatchEvent(new Event ("fontStyleAttributeChanged"))
            }
        }


        private var _fontName:String = "serif";
        [Bindable(event="fontNameAttributeChanged")]
        public function get fontName():String
        {
            return _fontName;
        }
        public function set fontName(value:String):void
        {
            if (_fontName != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "fontName", _fontName, value);
				
                _fontName = value;

                dispatchEvent(new Event("fontNameAttributeChanged"))
            }
        }

        //------------color setting end------------------------------------------------
        [Bindable("sizeChanged")]
        /**
         * <p>Domino: <strong>size</strong></p>
         *
         * @default "12"
         *
           */

         private var _size:String = "12";
        /**
         * <p>Domino:Size of the font, in points..</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Plan</td></tr>
         * <tr><td>PrimeFaces</td><td>Supported</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;font size=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;font size=""/&gt;</listing>
         */
        public function get size():String
        {
            return  this._size ;
        }

        public function set size(value:String):void
		{
			if (this._size != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "size", this._size, value);
				
				this._size = value;
               
                super.setStyle("fontSize",value);
				dispatchEvent(new Event("sizeChanged"));
			}
		}

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>Domino: <strong>percentWidth</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel percentWidth="80"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="width:80%;"/&gt;</listing>
         */
        override public function get percentWidth():Number
        {
            return super.percentWidth;
        }

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>Domino: <strong>width</strong></p>
         *
         * @default "100"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel width="100"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>Domino: <strong>percentHeight</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel percentHeight="80"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="height:80%;"/&gt;</listing>
         */
        override public function get percentHeight():Number
        {
            return super.percentHeight;
        }

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>Domino: <strong>height</strong></p>
         *
         * @default "30"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel height="30"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        private var _forAttribute:String;

        [Bindable("forAttributeChanged")]
        /**
         * <p>Domino: <strong>forAttribute</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel for=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;h:outputLabel for=""/&gt;</listing>
         */
        public function get forAttribute():String
        {
            return _forAttribute;
        }

        public function set forAttribute(value:String):void
        {
            if (_forAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "forAttribute", _forAttribute, value);
				
                _forAttribute = value;
                dispatchEvent(new Event("forAttributeChanged"));
            }
        }

        [Inspectable(category="General", defaultValue="Label")]
        [Bindable("textChanged")]
        /**
         * <p>Domino: <strong>text</strong></p>
         *
         * @default "Label"
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel value="Label"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;h:outputLabel value="Label"/&gt;</listing>
         */
        override public function get text():String
        {
            return super.text;
        }

		override public function set text(value:String):void
		{
			if (super.text != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "text", super.text, value);
				
				super.text = value;
				dispatchEvent(new Event("textChanged"));
			}
		}


        //------------comenent start------------------
		private var _font:DominoFont;
		public function set font(font:DominoFont):void
		{
			_font = font;
		}
		public function get font():DominoFont
		{
			return _font ;
		}

		private var _par:DominoPar;
		public function set par(par:DominoPar):void
		{
			_par = par;
		}
		public function get par():DominoPar
		{
			return _par ;
		}

		private var _run:DominoRun;
		public function set run(run:DominoRun):void
		{
			_run = run;
		}
		public function get run():DominoRun
		{
			return _run ;
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

        private var _familyid:String;
		public function get familyid():String
		{
			return _familyid;
		}
		public function set familyid(value:String):void
		{
			_familyid = value;
		}


		private var _pitch:String;
		public function get pitch():String
		{
			return _pitch;
		}
		public function set pitch(value:String):void
		{
			_pitch = value;
		}

		private var _truetype:String;
		public function get truetype():String
		{
			return _truetype;
		}
		public function set truetype(value:String):void
		{
			_truetype = value;
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

         //-----Html core attrs-------
        private var _htmlId:String;
		public function get htmlId():String
		{
			return _htmlId;
		}
        public function set htmlId(value:String):void
		{
				_htmlId = value;
		}

		private var _htmlClass:String;
		public function get htmlClass():String
		{
			return _htmlClass;
		}
        public function set htmlClass(value:String):void
		{
			_htmlClass = value;
		}

		private var _htmlStyle:String;
		public function get htmlStyle():String
		{
			return _htmlStyle;
		}
        public function set htmlStyle(value:String):void
		{
			_htmlStyle=value;
		}

		private var _htmlTitle:String;
		public function get htmlTitle():String
		{
			return _htmlTitle;
		}
        public function set htmlTitle(value:String):void
		{
			_htmlTitle=value;
		}

		private var _htmlOther:String;
		public function get htmlOther():String
		{
			return _htmlOther;
		}
        public function set htmlOther(value:String):void
		{
			_htmlOther=value;
		}

		//-------------other componetn end-------------
		
		

        public function toXML():XML
        {
            var escapeText:String = escape(this.text);
           
            //format fix, we need replace the tab to space.
            // if(escapeText.indexOf("%09")>=0){
            //     Alert.show("escapeText1:"+escapeText);
            //   escapeText=escapeText.replace (/%09/g,"%20%20%20%20%20%20%20%20");
            //     Alert.show("escapeText2:"+escapeText);
            // }
            var xml:XML = new XML("<" + ELEMENT_NAME +">"+escapeText+"</"+ELEMENT_NAME+ ">");
            if(this.size){
                xml.@size = this.size;
            }

            if(this.color){
                xml.@color = this.color;
            }

            if(this.fontStyle){
                xml.@fontStyle = this.fontStyle;
            }
             if(this.fontName){
                xml.@fontName = this.fontName;
            }
            
            if(this.hidewhen){
                var encodeFormulaStr:String= StringHelper.base64Encode(this.hidewhen);
                 xml.@hidewhen = encodeFormulaStr;
            }

            if(this.hide){
              
                 xml.@hide = hide;
            }

            if(this.isNewLine){
                xml.@isNewLine= this.isNewLine;
            }else{

            }

            if(this.familyid){
                xml.@familyid = this.familyid;
            }
            if(this.pitch){
                xml.@pitch = this.pitch;
            }
            if(this.truetype){
                xml.@truetype = this.truetype;
            }

            if(this.htmlId){
                xml.@htmlId = this.htmlId;
            }
            if(this.htmlClass){
                xml.@htmlClass = this.htmlClass;
            }
            if(this.htmlStyle){
                xml.@htmlStyle = this.htmlStyle;
            }
            if(this.htmlTitle){
                xml.@htmlTitle = this.htmlTitle;
            }
            if(this.htmlOther){
                xml.@htmlOther = this.htmlOther;
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
            var localSurface:ISurface = surface;

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
           
			component.fromXML(xml, callback, localSurface,lookup);
           
            this.text = component.text;
            this.color = component.color;
            this.size = component.size;
            this.fontStyle=component.fontStyle;
            this.fontName=component.fontName;
            this.isNewLine = component.isNewLine;
            this.familyid= component.familyid;
            this.pitch = component.pitch;
            this.hide=component.hide;
            if(component.truetype){
                 this.truetype = component.truetype;
            }
           
            if(component.hidewhen){
                
               this.hidewhen=  StringHelper.base64Decode(component.hidewhen);
            }

            


        }

        public function toCode():XML
        {
			component.text = this.text;
            component.size = this.size;
            component.color = this.color;
            component.fontStyle = this.fontStyle;
			//component.forAttribute = this.forAttribute;
			//component.indicateRequired = this.indicateRequired;
			
			component.isSelected = this.isSelected;
            component.hidewhen = this.hidewhen;
            component.hide = this.hide;
            component.isNewLine = this.isNewLine;
            component.familyid = this.familyid;
            component.pitch = this.pitch ;
            component.truetype = this.truetype ;

             if(this.htmlId){
                component.htmlId = this.htmlId;
            }
            if(this.htmlTitle){
                component.htmlTitle = this.htmlTitle;
            }
            if(this.htmlClass){
                component.htmlClass = this.htmlClass;
            }
            if(this.htmlStyle){
                component.htmlStyle = this.htmlStyle;
            }
            if(this.htmlOther){
                component.htmlOther = this.htmlOther;
            }
		
            return component.toCode();
        }

        public	function toRoyaleConvertCode():XML
		{
            component.text = this.text;

			return (component as IRoyaleComponentConverter).toRoyaleConvertCode();
		}

		public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, null));
		}

         override protected function commitProperties():void
        {
            super.commitProperties();

            // if (indicateRequiredChanged)
            // {
			// 	isUpdating = true; // do not update 'text' change to history manager as the 'text' change here is the effect of another field change
            //     if (indicateRequired && !hasIndicationRequired())
            //     {
            //         this.text += " *";
            //     }
            //     else if (this.text && !indicateRequired)
            //     {
            //         this.text = this.text.replace(" *", "");
            //     }
            //     indicateRequiredChanged = false;
			// 	isUpdating = false;
            // }

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
    }
}