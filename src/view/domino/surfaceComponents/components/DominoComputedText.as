////////////////////////////////////////////////////////////////////////////////
// Copyright 2022 Prominic.NET, Inc.
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
// Author: Prominic.NET, Inc.
// No warranty of merchantability or fitness of any kind. 
// Use this software at your own risk.
////////////////////////////////////////////////////////////////////////////////
package view.domino.surfaceComponents.components
{
	import interfaces.ILookup;
	import interfaces.IRoyaleComponentConverter;
	import interfaces.ISurface;
	import interfaces.dominoComponents.IDominoComputedText;
    import view.interfaces.ICDATAInformation;
    import flash.events.Event;

    import interfaces.IComponentSizeOutput;

    import spark.layouts.VerticalAlign;
    import spark.components.Label;
    
    import data.OrganizerItem;
    import utils.XMLCodeUtils;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IDominoSurfaceComponent;
    import view.domino.propertyEditors.DominoComputedTextPropertyEditor;
    import view.suportClasses.PropertyChangeReference;

    import components.domino.DominoPar;
    import mx.collections.ArrayList;
    import utils.StringHelper;

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
	 *  <p>Representation and converter for Visuale computed text  components </p>
	 * 
	 *  <p>This class work for  convert from Visuale input  components to target framework of body format.</p>
	 *  Conversion status<ul>
	 *   <li>Domino:  Complete</li>
	 *   <li>Royale:  TODO</li>
	 * </ul>
	 * 
	 * <p>Input:  view.domino.surfaceComponents.components.DominoComputedText</p>
	 * <p> Example Domino output:</p>
	 * <pre>
	 *  &lt;par def=&#39;6&#39;&gt;&lt;run&gt;&lt;font color=&#39;blue&#39;/&gt;example string .....&lt;/run&gt;&lt;/par&gt;
     * </pre>
	 * 
	 * <p> Example Royale output:</p>
	 * <pre>
	 * TODO
     * </pre>
	 *
	 * @see https://github.com/Moonshine-IDE/VisualEditorConverterLib/blob/master/src/components/domino/DominoComputedText.as
	 * @see https://help.hcltechsw.com/dom_designer/10.0.1/basic/H_COMPUTEDTEXT_ELEMENT_XML.html
	 */
    
    public class DominoComputedText extends Label implements IDominoSurfaceComponent, IHistorySurfaceComponent, ICDATAInformation, IComponentSizeOutput, IRoyaleComponentConverter
    {
        public static const DOMINO_ELEMENT_NAME:String = "ComputedText";
       
        public static const ELEMENT_NAME:String = "ComputedText";
		private var component:IDominoComputedText;
        public function DominoComputedText()
        {
            super();
            component = new components.domino.DominoComputedText();
			
            this.text = "ComputedText";

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
                "formulaAttributeChanged"
            ];
        }
        private var _hidewhen:String;
        /**
         * <p>Domino:Contains formula ,Represents  hide or show the element.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>Domino</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText hidewhen=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;formula &gt; &lt;formula /&gt;</listing>
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


        [Inspectable(category="General", defaultValue="Label")]
        [Bindable("textChanged")]
        
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


        private var _widthOutput:Boolean = true;
        protected var widthOutputChanged:Boolean;
         /**
         * <p>General:This is a general property to set if allow seting width.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText widthOutput=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText widthOutput=""/&gt;</listing>
         */

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

        private var _heightOutput:Boolean = true;
        /**
         * <p>General:This is a general property to set if allow seting heght.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText heightOutput=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText heightOutput=""/&gt;</listing>
         */
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
            return DominoComputedTextPropertyEditor;
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
        /**
         * <p>General:This is a general property to show the field already be updating or not.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText isUpdating=""/&gt;</listing>
         */
        public function get isUpdating():Boolean
        {
            return _isUpdating;
        }

        public function set isUpdating(value:Boolean):void
        {
            _isUpdating = value;
        }
		
		private var _isSelected:Boolean;
        /**
         * <p>General:This is a general property to show the field already be selected or not.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText isSelected=""/&gt;</listing>
         */

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
         * <p>General:This is a general property to show the field if need indicate.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText indicateRequired=""/&gt;</listing>
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
        private var _colors:ArrayList = new ArrayList([
        {label: "aqua",description: "aqua color.",htmlcolor:"#00FFFF"},
        {label: "black",description:"",htmlcolor:"#000000"},
        {label: "blue",description:"",htmlcolor:"#0000FF"}, 
        {label: "fuchsia",description:"",htmlcolor:"#FF00FF"},
        {label: "gray",description:"",htmlcolor:"#808080"},
        {label: "green",description:"",htmlcolor:"#008000"},
        {label: "lime",description:"",htmlcolor:"#00FF00"},
        {label: "maroon",description:"",htmlcolor:"#800000"},
        {label: "navy",description:"",htmlcolor:"#000080"},
        {label: "olive",description:"",htmlcolor:"#808000"},
        {label: "purple",description:"",htmlcolor:"#800080"},
        {label: "red",description:"",htmlcolor:"#FF0000"},
        {label: "silver",description:"",htmlcolor:"#C0C0C0"},
        {label: "teal",description:"",htmlcolor:"#008080"},
        {label: "white",description:"",htmlcolor:"#ffffff"},
        {label: "yellow",description:"",htmlcolor:"#FFFF00"},
        {label: "none",description:"",htmlcolor:"#000000"},
        {label: "system",description:"A preset color. For instance, the font color of a hotspot link is 'system' because it is determined by the %link.color.attrs; property settings for a form.",
        htmlcolor:"#4B0082"}
        ]);

        public function get colors():ArrayList
        {
            return _colors;
        }


        private var _color:String = "system";
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


        private var _formula:String;
        [Bindable(event="formulaAttributeChanged")]
         /**
         * <p>Domino:A field that contains an function or command formula, the formula will calculation and show the result when it display.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>Domino</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText hidewhen=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0"> &lt;code /&gt;   &lt;formula &gt; &lt;formula /&gt; &lt;code /&gt;</listing>
         */
		public function get formula():String
		{
			return _formula;
		}

		public function set formula(value:String):void
		{
			if (_formula != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "formula", _formula, value);
				
                _formula = value;
                dispatchEvent(new Event("formulaAttributeChanged"))
            }
		}

        //------------font style--------------------------------------------

        //<!ENTITY % font.styles "normal | bold | italic | underline | strikethrough | superscript | subscript | shadow | emboss | extrude">
        [Bindable]
        private var _fontStyles:ArrayList = new ArrayList([
              {label: "normal",description: "normal",value:"normal",enabled:true},
              {label: "bold",description: "bold",value:"bold",enabled:true},
              {label: "italic",description: "italic",value:"italic",enabled:true},
              {label: "underline",description: "underline",value:"underline",enabled:true},
              {label: "strikethrough",description: "strikethrough",value:"strikethrough",enabled:true},
              {label: "superscript",description: "superscript",value:"superscript",enabled:true},
              {label: "shadow",description: "shadow",value:"shadow",enabled:true},
              {label: "emboss",description: "emboss",value:"emboss",enabled:true},
              {label: "extrude",description: "extrude",value:"extrude",enabled:true},
              {label: "subscript",description: "subscript",value:"subscript",enabled:true},
              
        ])

        public function get fontStyles():ArrayList
        {
            return _fontStyles;
        }

        private var _fontStyle:String = "normal";
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
                
               
                dispatchEvent(new Event("colorAttributeChanged"))
            }
        }

        //------------color setting end------------------------------------------------
        [Bindable("sizeChanged")]
        /**
         * <p>Domino:text size .</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>Domino</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText size=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText size=""/&gt;</listing>
         */

        private var _size:String = "12";
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
         * <p>Domino: <strong>style</strong></p>
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
         * <p>Domino: <strong>style</strong></p>
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
         * <p>Domino: <strong>style</strong></p>
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
         * <p>Domino: <strong>for</strong></p>
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

        private var _hide:String;
		public function get hide():String
		{
			return _hide;
		}
		public function set hide(value:String):void
		{
			_hide = value;
		}

        

        	//-------------other componetn end-------------
		
		

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME +">computed text</"+ELEMENT_NAME+ ">");
            if(this.size){
                xml.@size = this.size;
            }

            if(this.color){
                xml.@color = this.color;
            }
            if(this.formula){
                 xml.@formula = StringHelper.base64Encode(this.formula);;
            }

            if(this.fontStyle){
                xml.@style = this.fontStyle;
            }
            
            if(this.hidewhen){
                var encodeFormulaStr:String= StringHelper.base64Encode(this.hidewhen);
                 xml.@hidewhen = encodeFormulaStr;
            }
            if(this.hide){
                 xml.@hide = this.hide;
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
           
			component.fromXML(xml, callback, localSurface, lookup);
           
            this.formula = component.formula;
            this.color = component.color;
            this.size = component.size;
            this.fontStyle=component.fontStyle;
            if(component.formula){
                
               this.formula=  StringHelper.base64Decode(component.formula);
            }


        }

        public function toCode():XML
        {
			component.formula = this.formula;
            component.size = this.size;
            component.color = this.color;
            component.fontStyle = this.fontStyle;
			//component.forAttribute = this.forAttribute;
			//component.indicateRequired = this.indicateRequired;
			
			component.isSelected = this.isSelected;
            component.hidewhen = this.hidewhen;
            component.hide = this.hide;
		
            return component.toCode();
        }

        public	function toRoyaleConvertCode():XML
		{
			return new XML("");
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