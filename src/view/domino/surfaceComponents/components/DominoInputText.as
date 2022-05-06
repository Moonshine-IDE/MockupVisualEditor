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
    import flash.events.Event;

    import interfaces.IComponentSizeOutput;
	import interfaces.ILookup;
	import interfaces.ISurface;

	import mx.utils.StringUtil;
    
    import spark.components.TextInput;
    
    import data.OrganizerItem;

    import utils.XMLCodeUtils;
    import mx.collections.ArrayList;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IIdAttribute;
    import view.interfaces.IDominoSurfaceComponent;
    import view.domino.propertyEditors.InputTextPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.dominoComponents.IDominoInputText;
	import interfaces.IRoyaleComponentConverter;

    import components.domino.DominoInputText;

    import utils.StringHelper;

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]
    /**domino exclude property */
    [Exclude(name="kinds", kind="property")]
    [Exclude(name="types", kind="property")]

    /**
	 *  <p>Representation and converter for Visuale field  components </p>
	 * 
	 *  <p> This class work for  convert from Visuale field  components to target framework of domino format.</p>
	 *  Conversion status<ul>
	 *   <li>Domino:  Complete</li>
	 *   <li>Royale:  Partial</li>
	 *  </ul>
	 * 
	 * <p>Input:  view.domino.surfaceComponents.components.DominoInputText</p>
	 * <p> Example Domino output:</p>
	 * <pre>
	 *  &lt;field useappletinbrowser=&quot;false&quot; allowtabout=&quot;false&quot; defaultfocus=&quot;false&quot; protected=&quot;false&quot; sign=&quot;false&quot; storelocally=&quot;false&quot; type=&quot;text&quot; kind=&quot;editable&quot; computeaftervalidation=&quot;false&quot; allowmultivalues=&quot;false&quot; width=&quot;100pt&quot; height=&quot;30pt&quot; bgcolor=&quot;#ffffff&quot; name=&quot;test&quot;/&gt;
     * </pre>
	 * <p>Domino event:</p>
	 * <pre>
	 * Client: Default value,Input Translation, Input Validation, Input Enabled,HTML attribute
	 * Web: onBlur,onChange,onClick,onFocus,onKeyDown,onKeyPress,onKeyUp,onMouseDown,onMouseUp,onMouseMove,OnMouseOut,OnMouseOver,onSelect,
	 * Client:(option),(Declarations),Entering,Exiting,Initialize,Terminate
	 * </pre>
    * <p>Domino Attributes:</p>
     * <pre>
     * &lt;inputText
     * <b>Attributes</b>
     * id=""
     * style="width:100px;height:30px;"
     * value=""
     * maxlength=""
     * required="false"
     * type="text"
     * allowtabout="false"
     * defaultfocus="false"
     * protected="false"
     * sign="false"
     * storelocally="false"
     * hidewhen=""
     * inputvalidation=""
     * inputtranslation=""
     * text=""
     * type="text"
     * kind="editable"
     * bgcolor="#ffffff"
     * id=""
     * name=""
     * digits=""
     * format=""
     * punctuated=""
     * parens=""
     * percent=""
     * show=""
     * date=""
     * allowmultivalues="false"
     * showtodaywhenappropriate=""
     * fourdigityear=""
     * fourdigityearfor21stcentury=""
     * omitthisyear=""
     * time=""
     * zone=""
     * calendar=""
     * allowtabout="false"
     * borderstyle="inset"
     * listdisplayseparator="comma"
     * listinputseparators="comma"
     * lookupaddressonrefresh="false"
     * lookupeachchar="false"
     * protected="false"
     * showdelimiters="true"
     * sign="false"
     * storelocally="false"
     * useappletinbrowser="false"
     * ui=""
     * recalconchange="false"
     * recalcchoices="false"
     * numberColumns=""
     * allownew="true"
     * multiline="true"
     * usenotesstyle="false"
     * firstdisplay=""
     * onlyallow=""
     * useappletinbrowser="false"/&gt;
     * </pre>
	 * <p> Example Royale output:</p>
	 * <pre>
	 * TODO
     * </pre>
	 *
	 * @see https://help.hcltechsw.com/dom_designer/10.0.1/basic/H_FIELD_ELEMENT_XML.html
	 * @see https://github.com/Moonshine-IDE/VisualEditorConverterLib/blob/master/src/components/domino/DominoInputText.as
	 */
    
    public class DominoInputText extends TextInput implements IDominoSurfaceComponent,IIdAttribute,
            IHistorySurfaceComponent, IComponentSizeOutput, IRoyaleComponentConverter
    {
        public static const DOMINO_ELEMENT_NAME:String = "field";
       
        public static const ELEMENT_NAME:String = "Field";
		
		private var component:IDominoInputText;
		
        public function DominoInputText()
        {
            super();
			
			component = new components.domino.DominoInputText();
			
            this.mouseChildren = false;
            this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
			//this.maxHeight = 30;

            this.nameAttribute = "test" ;
            this.type = "text" ;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "textChanged",
                "digitsChanged",
				"maxLengthChanged",
                "idAttributeChanged", 
                "nameAttributeChanged", 
                "kindAttributeChanged",
                "formatAttributeChanged", 
                "typeAttributeChanged", 
                "showAttributeChanged",
                "dateAttributeChanged",
                "allowmultivaluesAttributeChanged",
                "timeAttributeChanged",
                "zoneAttributeChanged",
                "calendarAttributeChanged",
                "keywordsChanged",
                "checkboxAttributeChanged",
                "choicesdialogAttributeChanged",
                "listinputseparatorsAttributeChanged",
                "listdisplayseparatorAttributeChanged",
                "formulaChanged",
                "firstdisplayAttributeChanged",
                "onlyallowAttributeChanged",
                "objectAttributeChanged",
                "defaultValueAttributeChanged",
                "inputtranslationAttributeChanged",
                "inputvalidationAttributeChanged",
                "hidewhenAttributeChanged",
                "numberColumnsChanged",
                "recalcchoicesChanged",
                "recalonchangeChanged",
                "keyformulachoicesChanged",
                "keyformulavalueAttributeChanged",
                "keywordsformulaChanged",
                "securityOptionsInputAttributeChanged"
            ];
			
			this.prompt = "Input Text";
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

       
        private var _numberColumns:Number=1;
        [Bindable(event="numberColumnsChanged")]
        /**
         * <p>Domino: <strong>numberColumns (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText numberColumns=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText numberColumns=""/&gt;</listing>
         */
        public function get numberColumns():Number
        {
            return _numberColumns;
        }
		
        public function set numberColumns(value:Number):void
        {
            if (_numberColumns != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "numberColumns", _numberColumns, value);
				
                _numberColumns = value;
                dispatchEvent(new Event("numberColumnsChanged"))
            }
        }


        private var _idAttribute:String;
		[Bindable(event="idAttributeChanged")]
        /**
         * <p>Domino: <strong>id (Require ,default is 'test')</strong></p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Supported</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText id=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText id=""/&gt;</listing>
         */
        public function get idAttribute():String
        {
            return _idAttribute;
        }
		
        public function set idAttribute(value:String):void
        {
            if (_idAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "idAttribute", _idAttribute, value);
				
                _idAttribute = value;
                dispatchEvent(new Event("idAttributeChanged"))
            }
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>Domino: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText percentWidth="80"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText style="width:80%;"/&gt;</listing>
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
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Supported</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         *
         * @default "100"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText width="100"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        
        override public function get percentHeight():Number
        {
            return super.percentHeight;
        }

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>Domino: <strong>style</strong></p>
         *
         * @default "30"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText height="30"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

		private var _maxLength:String = "";
		[Bindable(event="maxLengthChanged")]
        /**
         * <p>Domino: <strong>maxlength (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText maxlength=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText maxlength=""/&gt;</listing>
         */
        public function get maxLength():String
		{
			return _maxLength;
		}

		public function set maxLength(value:String):void
		{
			if (_maxLength != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "maxLength", _maxLength, value);
				
				_maxLength = value;
				dispatchEvent(new Event("maxLengthChanged"));
			}
		}

       


        [Inspectable(category="General", defaultValue="")]
        [Bindable("textChanged")]
        /**
         * <p>Domino: <strong>value</strong></p>
        * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Supported</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText value=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText value=""/&gt;</listing>
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
       

        //-----name-------------------------
        private var _nameAttribute:String;
		[Bindable(event="nameAttributeChanged")]
        /**
         * <p>Name assigned to the field.it must keep unique in one form file. </p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Supported</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText nameAttribute=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText name=""/&gt;</listing>
         */
        public function get nameAttribute():String
        {
            return _nameAttribute;
        }
		
        public function set nameAttribute(value:String):void
        {
            if (_nameAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "nameAtfitribute", _nameAttribute, value);
				
                _nameAttribute = value;
                dispatchEvent(new Event("nameAttributeChanged"))
            }
        }
        //-----allowmultiple-------------------------
        
        private var _allowmultivalues:Boolean;
        private var allowmultipleChanged:Boolean;

        [Bindable(event="allowmultipleChanged")]
        /** 
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText allowmultivalues=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText allowmultivalues=""/&gt;</listing>
         */
        public function get allowmultivalues():Boolean
        {
            return _allowmultivalues;
        }

        public function set allowmultivalues(value:Boolean):void
        {
            if (_allowmultivalues != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "allowmultipleChanged", _allowmultivalues, value);

                _allowmultivalues = value;
                allowmultipleChanged = true;

                dispatchEvent(new Event("allowmultipleChanged"));
            }
        }

         //-----type-------------------------
        /**
          * https://help.hcltechsw.com/dom_designer/10.0.1/basic/H_FIELD_ELEMENT_XML.html
          * Type of field as defined in the %field.types; entity.
          * The %field.types; entity lists the types of fields. 
          * <!ENTITY % field.types "text | number | datetime | richtext | keyword | names | authors | 
          * readers | password | formula | timezone | richtextlite | color ">
          */
        [Bindable]
        private var _types:ArrayList = new ArrayList([
            {label: "text",description:"A text field."}, 
            {label: "number",description:"A number field."},
            {label: "datetime",description:"A date/time field."}, 
            {label: "richtext",description:"A rich text field."},
            {label: "keyword",description:"Presents a list of keywords for entry into the field, as a result of a formula or a list of constants. The Dialog List field is a keyword field that can also display a list of choices from the address dialog, view dialog, or ACL."}, 
            {label: "names",description:"A computed or editable field that lists usernames."}, 
            {label: "authors",description:"Lists the users who can edit the documents that they created."},
            {label: "password",description:"A text field that displays text characters as a string of asterisks (*) to hide the content of the field. This type is often used for field in which users enter their passwords."},
            {label: "formula",description:"A field that contains an @function or @command formula."},
            {label: "timezone",description:"A field that displays a drop-down list of all available world time zones."},
            {label: "richtextlite",description:"A rich text field that a user can paste a limited number of objects into; a helper icon listing the available element types displays beside this field."},
            {label: "readers",description:"Lists the users who can read the documents created from a form."},
            {label: "color",description:"A field that displays a color picker."}
        ]);
        public function get types():ArrayList
        {
            return _types;
        }
       
        private var _type:String;
		[Bindable(event="typeAttributeChanged")]
        /**
         * <p>Domino: Type of field as defined in the %field.types; entity.</p>
         * <code>&lt;!ENTITY % field.types "text | number | datetime | richtext | keyword | names | authors | readers | password | formula | timezone | richtextlite | color "&gt;</code>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Supported</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText type=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText type=""/&gt;</listing>
         */
        public function get type():String
        {
            return _type;
        }
		
        public function set type(value:String):void
        {
            if (_type != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "type", _type, value);
				
                _type = value;
                dispatchEvent(new Event("typeAttributeChanged"))
            }
        }

        //-----kind-------------------------
        /**
         * The kind attritube  entity lists the options for defining whether a field is editable or computed. 
         * This entity is used in the <field> and <section> elements. 
         * https://www.ibm.com/support/knowledgecenter/en/SSVRGU_9.0.1/basic/H_DEFINED_ENTITIES_XML.html
         * "editable | computed | computedfordisplay |computedwhencomposed "
         * 
         */
        [Bindable]
        private var _kinds:ArrayList = new ArrayList([
        {label: "editable",description: "A user can enter or change its value."},
        {label: "computed",description:"A formula calculates its value each time a user creates, saves, or refreshes a document."},
        {label: "computedfordisplay",description:"A formula recalculates its value each time a user opens or saves a document. "}, 
        {label: "computedwhencomposed",description:"A formula calculates its value only once: when a user first creates the document."}
        ]);

        public function get kinds():ArrayList
        {
            return _kinds;
        }
    
        private var _kind:String = "editable";
		[Bindable(event="kindAttributeChanged")]
        /**
         * <p>Domino: Kind of field as defined in the %field.kinds; entity.</p>
         * <p><code>&lt;!ENTITY % field.kinds; "editable | computed | computedfordisplay | computedwhencomposed  "&gt;</code></p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText kind=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText kind=""/&gt;</listing>
         */
        public function get kind():String
        {
            return _kind;
        }
		
        public function set kind(value:String):void
        {
            if (_kind != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "kind", _kind, value);
				
                _kind = value;
                dispatchEvent(new Event("kindAttributeChanged"))
            }
        }

       
          //-----digits-------------------------
          //Represents the number of decimal places (0 to 15) to display when displaying the number. 
          //If the value is "varying," indicates that the number of decimal places to display may change.
        private var _digits:Number=0;
         /**
         * <p>Domino: Represents the number of decimal places (0 to 15) to display when displaying the number. .</p>
         * <p>If the value is "varying," indicates that the number of decimal places to display may change.</p>
         * <p><code>It only work for filed type is number</code></p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
        
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText digits=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText digits=""/&gt;</listing>
         */
        [Bindable(event="digitsChanged")]
        public function get digits():Number
        {
            return _digits;
        }

        public function set digits(value:Number):void
        {
            if (_digits != value)
            {
                if(value>15){
                    value=15;
                }
                _propertyChangeFieldReference = new PropertyChangeReference(this, "digits", _digits, value);
				
                _digits = value;
                dispatchEvent(new Event("digitsChanged"))
            }
        }
          
          
          //-----format-------------------------
        [Bindable]
        private var _formats:ArrayList = new ArrayList([
        {label: "general",description: "Displays numbers as they are entered; zeroes following the decimal point are suppressed. For example, 6.00 displays as 6."},
        {label: "currency",description:"Displays values with a currency symbol and two digits after the decimal symbol; for example, $15.00."},
        {label: "fixed",description:"Displays numbers with a fixed number of decimal places. For example, 6 displays as 6.00."}, 
        {label: "scientific",description:"Displays numbers using exponential notation; for example, 10,000 displays as 1.00E+04."}
        ]);

        public function get formats():ArrayList
        {
            return _formats;
        }
    
        private var _format:String = "general";
         /**
         * <p>Domino: The %numberformat.formats; entity defines the choices for number formats. .</p>
         * <p>This property only work for filed as 'number' type</p>
         * <p><code>&lt;!ENTITY % numberformat.formats "general | fixed | scientific | currency"/&gt;</code></p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText format=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText format=""/&gt;</listing>
         */
		[Bindable(event="formatAttributeChanged")]
        public function get format():String
        {
            return _format;
        }
		
        public function set format(value:String):void
        {
            if (_format != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "format", _format, value);
				
                _format = value;
                dispatchEvent(new Event("formatAttributeChanged"))
            }
        }
          //-----punctuated-------------------------
        private var _punctuated:Boolean;
        private var punctuatedChanged:Boolean;
        /**
         * <p>Domino: If true, displays large numbers with the thousands separator; for example, 1,000..</p>
         * <p>This property only work for filed as 'number' type</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText punctuated=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText punctuated=""/&gt;</listing>
         */
        [Bindable(event="punctuatedChanged")]
        public function get punctuated():Boolean
        {
            return _punctuated;
        }

        public function set punctuated(value:Boolean):void
        {
            if (_punctuated != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "punctuatedChanged", _punctuated, value);

                _punctuated = value;
                punctuatedChanged = true;

                dispatchEvent(new Event("punctuatedChanged"));
            }
        }
         
          //-----parens-------------------------
        private var _parens:Boolean;
        private var parensChanged:Boolean;

         /**
         * <p>Domino: If true, displays negative numbers enclosed in parentheses; for example, (5) instead of -5.</p>
         * <p>This property only work for filed as 'number' type</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
        
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText parens=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText parens=""/&gt;</listing>
         */

        [Bindable(event="parensChanged")]
        public function get parens():Boolean
        {
            return _parens;
        }

        public function set parens(value:Boolean):void
        {
            if (_parens != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "parensChanged", _parens, value);

                _parens = value;
                parensChanged = true;

                dispatchEvent(new Event("parensChanged"));
            }
        }
          //-----percent-------------------------
        private var _percent:Boolean;
        private var percentChanged:Boolean;
         /**
         * <p>Domino:If true, displays values as percentages; for example, displays .10 as 10%.</p>
         * <p>This property only work for filed as 'number' type</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText percent=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText percent=""/&gt;</listing>
         */

        [Bindable(event="percentChanged")]
        public function get percent():Boolean
        {
            return _percent;
        }

        public function set percent(value:Boolean):void
        {
            if (_percent != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "percentChanged", _percent, value);

                _percent = value;
                percentChanged = true;

                dispatchEvent(new Event("percentChanged"));
            }
        }


/**
 * <field allowmultivalues="false" allowtabout="false" computeaftervalidation="false" dataconnectionfield="data" defaultfocus="false" kind="editable" name="%FieldName%" protected="false" showdelimiters="true" sign="false" storelocally="false" type="datetime" useappletinbrowser="false">
<datetimeformat date="yearmonthday" dateformat="weekdaymonthdayyear" dateseparator1=" " dateseparator2="/" dateseparator3="/" dayformat="twodigitday" fourdigityear="false" fourdigityearfor21stcentury="true" monthformat="twodigitmonth" omitthisyear="false" preference="usersetting" show="date" showtodaywhenappropriate="false" timeformat24="false" timeseparator=":" weekdayformat="shortname" yearformat="fourdigityear" zone="never"/>
</field>
 */

// -----------show-----------------------
        [Bindable]
        private var _shows:ArrayList = new ArrayList([
        {label: "Current date only.",value:"date",
        description: "Current date only."},
        {label: "Current time only.",value:"time",
        description:"Current time only."},
        {label: "Current date and time.",value:"datetime",
        description:"Current date and time."}
        ]);

        public function get shows():ArrayList
        {
            return _shows;
        }
    
        private var _show:String = "datetime";
         /**
         * <p>Domino:Displays the date and time in the format defined in the %datetimeformat.show; entity.</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <code>&lt;!ENTITY %datetimeformat.show "date | time | datetime"&gt;</code>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * <img src="data:image/png;base64,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7tNHPnKolE55NnXOnz9fra2tkvI9WY3t27fn/v7Vr34lSXr/+98/Lo1SAp09b6m3s9SCQtcpJwoTOLyCbtD1UCidqLiVxy1fv/JM1O3qXK6JupwTXcmBsdiaon2t0HmADzLca5zXtPY40wTa3t6u/v5+te7zXknSySedJCmhZ57ZOu5jLPW2pbcAACAASURBVP9s5r7E8y+4MBccH3nkEX36M38rSTrvvHN03333jckn6hrfRA+Ik60ziFftKex6iLsW5lcek69bB6zJFhz8Wh5QG0I/+cbc1Lpt2za1tbX5bvxt27apoaEh1t5Xfjfye7GffHP//ffrmGOPLzhP/5/ekJRvdjW9Um17z5+v7916s4499tgxT77x6jnrLLuzI5Bb71xTU6yWGqN9k7Nbs6RzmN+BPkyvVud0zm9nmQqVx2sev+mLqdG61aoKDQ+TR6H167c+7OF+6btN47btg5SnVpVyg3+h4yJPvqm8om/X2G+//apixy4mODQ2Nur000/XbbfdpmuuuUYrViwPPG9DQ4NuveVmHX/csblHwZ1wwvH6q0WLdPrpp+mcc85RKpXS6aefnvvheJXRrdbr9789rBqCopPXtblC00SRp9dZetj/ncOiLn/c16GCXo8tV77VcIwAwirqWalhblCNu8ZYrNdee02HHHKIBgYG9K1vfavkjkPJZFIbN27UV7/6VTU2NupXv/qVmpubIypt9Yr6kXBuNbhqFPf1z2pbD9VWnkqjxjixFXWNsbm5WQ0NDYE+XtyeBFNOu+22m6677jpJ0kUXXaSHHnqopPQee+wxXXbZZZKktWvXToqgGIdauSYVdxmrbT1UW3mAOFX07RrOXqRBmgejvra2evVq3XDDDZo+fbrWrFmjM844I3Qat99+uy6++GLt3LlT5557rq644orIylcreMwVEBw1xuoW6SPhatHXv/51jYyM6MYbb9T555+vBx98UKtXr9aCBQsKzrt161atWrVKP/nJTyRJZ511llavXh13katSc3NzVT4XFwDCqtoao1ePTMPrOarF1ibvvPNOffWrX9Wf/vQn1dXV6cgjj9QnPvEJfehDH9L8+fM1Z84cvfnmm/rDH/6gX/3qV/q3f/s3Pfroo0qlUpo7d67+4R/+QaecckpVXk8FUDuoMVZeVQbGQgHT792NpTS1DgwM6Jvf/KZuvfXWQOui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ySefrMbGRi1cuFAPP/xwbvqHHnpIBx10kGbNmqUPfOADuvPOO+NaDADAJBNbU6oxNDSkXXbZRZI0MjKidDqtBQsW6H//93/161//WgsXLtSnPvUpbdy4UXfddZdaW1t1yCGHSJJaWlq011576fHHH9esWbP07LPP6q233tIHPvAB1dXV6ROf+IR6enr02muv6T/+4z906KGHRrYsAMqDptTgaEotj7L3Sk0kElqxYoUk6c4779Rbb72lBx54QPPmzdNxxx2Xm27atGnavHmzHnnkES1ZskR//vOftWnTJv3zP/+z3nnnHa1YsUI33nijOjs7JUm33XZbuRcFADABVeR2jeXLlyuRSOiuu+7S/fffr+HhYZ1yyimaPn16bpq2tjbNnj1bUqYjjyS9+OKL6uvrkyTdeuutam5u1he/+EVJ0h//+McyLwUAYCKqSGDca6+9tHTpUj3//PO6/PLLJUmf/exnx0yzdetW/fnPf5YkPf3005KkPfbYQx/84AclSZ///Of1u9/9Tr/4xS+0fv163XjjjWVcAgDARFWxG/zPOOMMSdLzzz+vtrY2fehDHxozfmRkREcddZQ+//nP64EHHtC0adP08Y9/PNeZZ+PGjbrnnnt06aWX6rTTTtNPfvKTsi8DAGDiKVtgdF40PuGEE9TU1CRpfG1Rkvbdd18NDg5q3bp1mjFjhr7//e9rn3320V/8xV/oO9/5jnbu3KnLL79czzzzjM466yx9+ctfLstyAAAmtth7pXp57rnntHDhQg0PD+uFF17Q3nvvLUl66qmndMghh2jJkiX62c9+ppdeeknNzc2aOnXsLZfpdFovvfSS9thjD02ZMiWyZQBQXvRKDY5eqeVRkabUo446SgcccICGh4f1qU99KhcU3ey5557jgqKU2UH22msvgiIAIFKxPfnGz+GHH66ZM2fqgAMO0GWXXTZm3G677aZzzjlH++23XyWKBgCY5CrWlAoAEk2pYdCUWh68dgoAAAuBEQAAS2zXGNPptKJspgVQ2xKJBE2BqAmxBMZ0Oq3nnntOP/vZz7R9+3Zt3749jmwA1IB58+Zp33331RFHHKE999yT4IiqF0vnm9HRUV1//fXadddddfLJJ2vevHmR5QGgvM4//3zdcMMNRc//xhtv6Je//KW2bNmiCy+8cNwtVnS+CY6TivKIrSn1xRdf1LnnnquZM2cqlUrFlQ2AmI2Ojpb0G547d64WL16s+++/P8JSAfGJrSl1dHRUM2bM4FojUONKDYyJREIzZszQ6OgoxwLUhFgD4+joqOrq6PgK1LJSA1o6nVYqlSIwombE1pSaSqWUSqUCt4nfcsstOvLII3XAAQcUnPaNN97Qu971roLTvfPOOxoaGtKcOXP02GOP6dVXX9WnP/3pQOUBkJFKpUoOaOZ4ANSC2GqMYQPjFVdcoTVr1mjBggW+03V2durVV1/VLbfcUrAMBx10kK677jodffTRuu+++/Sb3/xGJ598cuDlAJB5BVypQc0cD6gxohbEFhjNjynqh3xv3bo197qqQmXYtm1b7v+rrrqKHyVQhNHR0ZLTSKVSGhkZ4TeImhDbBUBzhuj1ue+++3TYYYfp3e9+tzo6OvT222/napq33XabDj74YDU2Nmr33XfXOeeco507d+qmm27SQw89pB//+Mc644wzlEql9Pjjj+vwww9XU1OTDjzwQP3gBz9QKpXSsmXLJElnnXWW1q9fr66uLp155plKpVK67rrrdNZZZ+nEE0/Uu971Lh1xxBH69a9/rWXLlund7363TjrpJL3wwgtKpVJ67bXXtHz5cu2xxx7ae++9dc4552jHjh0Fl48Pn4nyMZ1vovgAtSCWwGg3pZpeqfbn2Wef1fLly7Vw4UL96Ec/0htvvKHBwUFJ0v/8z//onHPO0UknnaRHH31UX/nKV3TbbbfpoYce0kknnaSDDz5YS5Ys0aWXXqqXX35ZJ554ovbZZx/df//9+uQnP6kzzzxTjzzyiK655hpJ0sUXX6yjjz5ar732ml588UWl02m99tpruuOOO/SBD3xAGzZs0KuvvqrDDz9cbW1tuvvuu7V161atX79e6XRan/vc57RlyxZ997vf1TXXXKMHHnhA//AP/+C6XHz4TMSP6TTj/Bx++OGeH+e09vEAqHaxX2N0+yE8+OCDSqVSWrt2rerr69Xc3KyDDz5Y6XRac+fO1YYNG3TccccpmUxqwYIFmjZtml555RUdffTRamxsVFNTk/bZZx/ddNNNGhwc1Lnnnqs5c+botNNO06ZNm7R+/Xp95zvfkSS1trbmHjBg/1D32msvrVq1SpJ09NFH695779UVV1yhKVOm6KijjtITTzyhF198UT//+c/19a9/PfcarE996lO67bbb9M1vfjOOVQdUHa/f8aOPPqojjzzSdbhzegIjaklsvVJN84upCdq2bt2q/fffPzd+77331ty5c/XOO+9oxowZevDBB3X22Werv79f++23n1KplIaGhjQ4OKiRkRGNjIxocHBQzz33nNLptI477rgx6e+99965fIeHhzU4OKidO3fm8hsZGdGee+6Zm6a+vl4LFizQ8PBwZqVMnaqRkZHcNcrrrrtuzJM/6urq9OKLL/JEH0wK77zzjuvvWMqc5C5dujT3/09/+lPXaROJRCTXKoFyiL3G6HZdYf78+br77rv19ttva/r06Xr99df1pz/9SalUSt/73vd055136uabb9Zhhx2m6dOn673vfW/uvki7eWfXXXdVQ0ODnnrqKTU0NEiSfvvb36qhoSH3I3SbL5VKaerUqblp7HFS/gzZBL6uri4df/zxkqSXX35ZL774ombPns0PHZOC+Q15eeCBB/Q3f/M3evDBBz2nq6uro8aImhF7YHT7oRxxxBG69tpr1dXVpc9+9rO66aabJClXM5w2bZre//73S5K+8Y1vKJVK6e2339bo6KhmzZql3t5e/fGPf9RHP/pRrV27Vt/4xjd03nnnaevWrfrsZz+rq666Svvss4/q6+v19NNPa+HCha7XS7wCo93c2tbWpn/6p39SS0uL5s6dq89//vOaO3eu1q9fT2DEpDAyMlJwX7///vsLTkNgRK2IvSnV7cfS1tamNWvW6Oqrr1ZXV5cWLFigefPmKZVK6TOf+YweeughffjDH1ZdXZ2WLFmiAw88UL/73e80Ojqqv/7rv9aFF16ok08+Wf/xH/+hNWvW6Morr9Ttt9+upqYm/e3f/q1OOeUUjY6OavHixbr66qu1fft2pVKpXHOO+XHaNUT7f9uNN96olStX6uMf/7imTZumQw45RN/4xjcIipg0CtUYg6ApFbUklrdrvPXWW/q7v/s73XLLLdq5c6fn9KlUSv/3f/+n5ubmceO2b9+u+vr6XBOpbXBwUIlEQjNnzpSUqeG9+uqram5uHvcIujfffFOzZs0q+X7KP/3pT5o2bZp22WWXktIBas2ZZ56p7373uyWlMW3aNH3hC1/QD3/4w3G/Id6uERxv1yiPWJ+V6lVjtO26666u0zQ2Nkpyr8XNmDFj3LjddtttTHOoMWvWLM90wpgzZ04k6QC1JkhTaiFTpkzhWamoGbE1pdrXGQHUrih+x1xfRC2J9ZFwphPLyMhIHNkAKIORkRHfSyKF1NXVjTkmANUutsB4wAEH6PHHH9ehhx7Kq6eAGjd9+vSi500kEvr973+vAw44gMCImhBL55sdO3boySef1I033qi33norsvQB1Kbm5mZ97nOf06GHHqrZs2ePGUfnm+DofFMesQTG4eFhDQ0NcXYIICeRSKi+vj7Xec4gMAZHYCyPWAIjAARFYAyOwFgeXPwDAMBCYAQAwEJgBADAQmAEAMBCYAQAwEJgBADAQmAEAMBCYAQAwEJgBADAQmAEAMAS2/sY//znP+uWW27RzJkz9cUvfjE3/N///d/1zDPPSJI+//nPa9OmTXrttdd05plnjnu4cCHDw8O66aabNHfuXH3uc5+LtPwAgMkptmelvvzyy5o/f77mzZun1157TZK0ceNGfeYzn1EqldJVV12lSy65RAcddJC2bNmi5557Tq2traHye+ONN9Tc3Kx9991Xzz77bGTLAaB8eFZqcDwrtTxiqzE6PfroozrttNOUSqX0ta99TZdccokk6corr9Qbb7yhd7/73eUqCgAAnspyjXHLli1atmyZhoeHde655+rKK6/Mjfv+97+vq6++Wm+++aZeeOEF7b///vrCF76g5cuXa968eXrve9+r9evXS5JGR0d12WWX6T3veY923313dXZ2lqP4AIBJJPam1ClTpmjXXXdVMplUQ0ODXnzxRc2ZMyc3j92UOjw8rPe9732SpEMOOUTz58/Xj3/8Y9XX1+v1119Xd3e3vvzlL2vWrFk65phj9OCDD+qtt96iKRWoYTSlBkdTannEXmMcHR1VMpnUzJkzNTg4mGtC9dPU1KRf/OIX+tGPfqT3vOc9GhoaUjKZ1N133y1J6urq0r/8y7/opptuirv4AIBJpixNqWeccYZ+9rOfSZK++93vqqenx3f6vfbaSzNnzpQk7bbbbpKkkZERvfTSS5IytUxJOvjgg2MqMQBgsoo9MM6ZM0ff/e53deihh6qjo0OSdOaZZ2pwcNBznlmzZuX+njJlSu7vPfbYQ5L0+9//XpL029/+NoYSAwAms9gD49SpU3Pt4ldffbXmzJmj559/XpdffnnotD7xiU9Iytz/+OUvf1kXXHBBpGUFAKCsT77ZbbfdtGrVKknSt7/9bf3Xf/2X6urGF8G+wGz//cUvflGnn3663nrrLd1666065phjNGPGjPgLDgCYNGLrlRqngYEBSVJjY2M5sgMQI3qlBkev1PKoycAIYOIgMAZHYCwPHiIOAICFwAgAgIXACACAhcAIAIAltrdrpNNpRdmxB0BtSyQSdB5BTYglMKbTaT333HP62c9+pu3bt2v79u1xZAOgBsybN0/77ruvjjjiCO25554ER1S9WG7XGB0d1fXXX69dd91VJ598subNmxdZHgDK6/zzz9cNN9xQ9PxvvPGGfvnLX2rLli268MILxzzmUeJ2jTA4qSiP2JpSX3zxRZ177rmaOXOmUqlUXNkAiNno6GhJv+G5c+dq8eLFuv/++yMsFRCf2JpSR0dHNWPGDK41AjWu1MCYSCQ0Y8YMjY6OcixATYg1MI6Ojro+CxVA7Sg1oKXTaaVSKQIjakZsUSuVSimVSuVqjKV8br75Zj399NNKp9P63ve+py1btuTGvf766wXnf/nll3X99ddraGioYPp8+PAZ+4nid2yOB0AtiK3GaH4IUVwsvuKKK7RmzRotWLBAa9as0QUXXKD3v//96uzs1KuvvqpbbrnFd/4XXnhBX/va17RixQpNmzZt3PirrrpKV155pRYsWFByWYGJZmRkpOSgZp8oA9UutsBofkzOHmil+t3vfpdLc+vWrWpqaoo0fQBjjY6OlpxGKpXSyMgIgRE1IfamVK/P448/rsMPP1xNTU068MAD9YMf/CA37r777tNhhx2md7/73ero6NDbb7+dq4Uef/zxuuuuu3TTTTfpoYce0o9//GOdccYZGhgY0Je+9CXtt99+mjVrlhYsWKA777xzzFnqxRdfrN1331377befbrzxxjHNO0HKxYfPZPyYzjdRfIBaEHtTqtsZ4iuvvKITTzxRxxxzjNasWaOf/OQnOvPMM7XXXntp99131/Lly3XKKafoqquu0g033KDBwcFcus8//7y2b9+uk046Sffdd5/mzJmjSy+9VN/+9rd1991364477tDcuXN17bXX6ktf+pI++clP5srw3//937rjjjv05JNP6uKLL9a+++6rj3/847lyvfzyy57lOvLII+NYVUDV8+o0c8QRR3jO89hjj4353+94AFSbigTGu+++W4ODgzr33HM1Z84cnXbaadq0aZPWr1+v973vfUqlUlq7dq3q6+vV3Nysgw8+OHcR36S/2267qbGxUU1NTdpnn3107LHH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Ubt2bef8tm3bMnXqVCpXrozdbufuu+9m2bJlzuVjx45l4MCB2O122rdvz/PPP0+1atXo0aMHkyZNom/fvkRERBAWFkZSUhKbN2+mTZs2VKpUiYiICBYsWOAsKyoqirFjx9K0aVMCAgLo2LEjhw8fZt++fQwbNowLFy4QERHBiRMnctT/5Zdfpl69etxyyy3Mnj0b+LP7cc6cOdx55534+/tTrVo1Bg8eTGZmJm+//TZffvkln376KU899VSxtRgdo1LVWhQRyV+pDL7J6wv222+/BaB169Y5lvft29dZxi+//MKZM2ec66SmpnLs2DFM0+TQoUPs2LGD0aNHExwczDfffMPChQsZMGAA1apVw83NjS5dunDfffcxadIk4uPj6devH7Vq1SIyMtK5vSOc+/bty6RJk3jjjTcYNGgQEyZMYMGCBVSsWDFbHadPn86sWbMYP348/v7+jBgxwlnfPXv2MHjwYF555RViYmJYu3Ytr7zyCp06daJbt26sWLGCihUrMmLEiGILnrwGzbRt2zbPbTZuzH6XBkfAKhxFpDwr8WDMr+Vx/PhxgByhk1s5ud1azvH+//7v/+jfvz8AW7dupXbt2kyalPWoybfffpuLFy/y3HPPUbFiRXr16sV///tfFi5c6AyJfv360bt3bwA6depEUlISnp6e1K5dG3d3d/72t79l2x/A0qVLiYqKok+fPgAkJiYyfvx4TNMkICCAuLg4YmJi+O233wgLC8PDw4Nff/2VqKgo/P39qVSpEiEhIcUWOnl95hs2bCAyMjLX+Veur1ajiNwISnxUqqPFmJaWlmNZw4YNAdi1axd33nlntmW7du3CYrEQEREBQGZmprOMzMxMDMMgLS0N0zSpWbOmc5nNZqN27drO9wcPHsQ0TWJiYrKV71jHNE2CgoKc6/v4+JCRkUFaWhoZGRmYpplr3RMTE7nvvvucy5o2bQpAWloa3t7exMfH079/f86ePUvDhg2x2+2kp6eTlpaGYRjYbLZcyy0qjmPITXx8PFFRUc73a9euzXPdojhXKSJSlpWpFmODBg3w8fHho48+4o477nDOT0tL44knnuC2227j/fffx2q1cvHiReeXdEpKirObFsBqtTpfm6aJu7u7831gYCC+vr7s2LEDX9+sZ0bu3LmTm266KduXvuv2rl3Arstc1a1blx9//NG57Oeff3au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"  width="454" height="794"/>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText show=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText show=""/&gt;</listing>
         */
		[Bindable(event="showAttributeChanged")]
        public function get show():String
        {
            return _show;
        }
		
        public function set show(value:String):void
        {
            if (_show != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "show", _show, value);
				
                _show = value;
                dispatchEvent(new Event("showAttributeChanged"))
            }
        }	
// -----------date-----------------------
// <!ENTITY % datetimeformat.date "yearmonthday | year4monthday | monthday | yearmonth | 
// year4month | weekdaymonthdayyear | 
// weekdaymonthday | weekday | month | day | year">
        [Bindable]
        private var _dates:ArrayList = new ArrayList([
        {label:"Only year month and day, where the year is in 2 digits.",value: "yearmonthday",description: "Current date only."},
        {label:"Only year and month, where the year is in 4 digits.",value: "year4monthday",description:"Current time only."},
        {label:"Only month and day",value: "monthday",description:"Current date and time."},
        {label:"Only month and year",value: "yearmonth",description:"Current date and time."},
        {label:"Only year and month, where the year is in 4 digits.",value: "year4month",description:"Current date and time."},
        {label:"Only weekday,month and year",value: "weekdaymonthdayyear",description:"Current date and time."},
        {label:"Only weekday,month and day",value: "weekdaymonthday",description:"Current date and time."},
        {label:"Only weekday",value: "weekday",description:"Current date and time."},
        {label:"Only month",value: "month",description:"Current date and time."},
        {label:"Only day",value: "day",description:"Current date and time."},
         {label:"Only year",value: "year",description:"Current date and time."}
         
        ]);

        public function get dates():ArrayList
        {
            return _dates;
        }
    
        private var _date:String = "yearmonthday";
        /**
         * <p>Domino:Displays the date in the format defined in the Defined entities for &lt;datetimeformat/&gt; element entity.</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <code>&lt;!ENTITY % datetimeformat.date "yearmonthday | year4monthday | monthday | yearmonth | year4month | weekdaymonthdayyear | weekdaymonthday | weekday | month | day | year &gt;</code>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText date=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText date=""/&gt;</listing>
         */
		[Bindable(event="dateAttributeChanged")]
        public function get date():String
        {
            return _date;
        }
		
        public function set date(value:String):void
        {
            if (_date != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "date", _date, value);
				
                _date = value;
                dispatchEvent(new Event("dateAttributeChanged"))
            }
        }
        // -----------showtodaywhenappropriate-----------------------
        private var showtodaywhenappropriateChanged:Boolean;
        private var _showtodaywhenappropriate:Boolean;
       
         /**
         * <p>Domino:Boolean. If true, displays 'today' instead of the date when date equals the current date.</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText showtodaywhenappropriate=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText showtodaywhenappropriate=""/&gt;</listing>
         */
        [Bindable(event="showtodaywhenappropriateChanged")]
        public function get showtodaywhenappropriate():Boolean
        {
            return _showtodaywhenappropriate;
        }

        public function set showtodaywhenappropriate(value:Boolean):void
        {
            if (_showtodaywhenappropriate != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "showtodaywhenappropriateChanged", _showtodaywhenappropriate, value);

                _showtodaywhenappropriate = value;
                showtodaywhenappropriateChanged = true;

                dispatchEvent(new Event("showtodaywhenappropriateChanged"));
            }
        }

// -----------fourdigityear-----------------------
      
        private var fourdigityearChanged:Boolean;
        private var _fourdigityear:Boolean;
         /**
         * <p>Domino:Always displays the year using four digits.</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText fourdigityear=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText fourdigityear=""/&gt;</listing>
         */

        [Bindable(event="fourdigityearChanged")]
        public function get fourdigityear():Boolean
        {
            return _fourdigityear;
        }

        public function set fourdigityear(value:Boolean):void
        {
            if (_fourdigityear != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "fourdigityearChanged", _fourdigityear, value);

                _fourdigityear = value;
                fourdigityearChanged = true;

                dispatchEvent(new Event("fourdigityearChanged"));
            }
        }

// -----------fourdigityearfor21stcentury-----------------------
        private var f21stChanged:Boolean;
        private var _fourdigityearfor21stcentury:Boolean;
       
         /**
         * <p>Domino:Displays the year using four digits only for dates having the year 2000 and later.</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText fourdigityearfor21stcentury=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText fourdigityearfor21stcentury=""/&gt;</listing>
         */

        [Bindable(event="f21stChanged")]
        public function get fourdigityearfor21stcentury():Boolean
        {
            return _fourdigityearfor21stcentury;
        }

        public function set fourdigityearfor21stcentury(value:Boolean):void
        {
            if (_fourdigityearfor21stcentury != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "f21stChanged", _fourdigityearfor21stcentury, value);

                _fourdigityearfor21stcentury = value;
                f21stChanged = true;

                dispatchEvent(new Event("f21stChanged"));
            }
        }

// -----------omitthisyear-----------------------	

        private var omitthisyearChanged:Boolean;
        private var _omitthisyear:Boolean;

         /**
         * <p>Domino:If true, omits the year from the date and time display formats. Default is false</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText omitthisyear=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText omitthisyear=""/&gt;</listing>
         */

        [Bindable(event="omitthisyearChanged")]
        public function get omitthisyear():Boolean
        {
            return _omitthisyear;
        }

        public function set omitthisyear(value:Boolean):void
        {
            if (_omitthisyear != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "omitthisyearChanged", _omitthisyear, value);

                _omitthisyear = value;
                omitthisyearChanged = true;

                dispatchEvent(new Event("omitthisyearChanged"));
            }
        }
// -----------time-----------------------
// <!ENTITY % datetimeformat.time "hourminutesecondhundredths | 
// hourminutesecond | hourminute | hour">	
        [Bindable]
        private var _times:ArrayList = new ArrayList([
        {label:"All",value: "hourminutesecondhundredths",description: "Current date only."},
        {label:"Hours,minutes,and seconds",value: "hourminutesecond",description:"Current time only."},
        {label:"Hours and minutes",value: "hourminute",description:"Current date and time."},
        {label:"Hours only",value: "hour",description:"Current date and time."}
        
        ]);

        public function get times():ArrayList
        {
            return _times;
        }
    
        private var _time:String = "hourminutesecond";
         /**
         * <p>Domino:Displays the time in the format defined in the %datetimeformat.time; entity.</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <code>&lt;!ENTITY % datetimeformat.time "hourminutesecondhundredths | hourminutesecond | hourminute | hour"&gt;</code>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText time=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText time=""/&gt;</listing>
         */
		[Bindable(event="timeAttributeChanged")]
        public function get time():String
        {
            return _time;
        }
		
        public function set time(value:String):void
        {
            if (_time != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "time", _time, value);
				
                _time = value;
                dispatchEvent(new Event("timeAttributeChanged"))
            }
        }
// -----------zone-----------------------	
// <!ENTITY % datetimeformat.zone "never | sometimes | always">
        [Bindable]
        private var _zones:ArrayList = new ArrayList([
        {label:"Adjust time to local time",value: "never",description: "never."},
        {label:"Show only if zone not local",value: "sometimes",description:"sometimes."},
        {label:"Always show time zone",value: "always",description:"always."}
        ]);

        public function get zones():ArrayList
        {
            return _zones;
        }
    
        private var _zone:String = "never";
          /**
         * <p>Domino:Displays the time zone in the format defined in the %datetimeformat.zone; entity.</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <code>&lt; !ENTITY % datetimeformat.zone "never | sometimes | always"&gt;</code>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText time=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText time=""/&gt;</listing>
         */
		[Bindable(event="zoneAttributeChanged")]
        public function get zone():String
        {
            return _zone;
        }
		
        public function set zone(value:String):void
        {
            if (_zone != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "zone", _zone, value);
				
                _zone = value;
                dispatchEvent(new Event("zoneAttributeChanged"))
            }
        }
    // -----------calendar-----------------------	
	// <!ENTITY % datetimeformat.calendar "gregorian | hijri">
        [Bindable]
        private var _calendars:ArrayList = new ArrayList([
        {label: "gregorian",description: "Christian calendar which is a revised version of the Julian calendar that incorporated leap years to keep sync with the lunar cycle."},
        {label: "hijri",description:"Islamic calendar based on twelve lunar months.."}
        ]);

        public function get calendars():ArrayList
        {
            return _calendars;
        }
    
        private var _calendar:String = "gregorian";
        /**
         * <p>Domino:The %datetimeformat.calendar; entity defines different types of calendars.</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <code>&lt;% datetimeformat.calendar "gregorian | hijri"&gt;</code>
         * <p><strong>gregorian</strong></p>
         * Christian calendar which is a revised version of the Julian calendar that incorporated leap years to keep sync with the lunar cycle.
         * <p><strong>hijri</strong></p>
         * Islamic calendar based on twelve lunar months.
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText calendar=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText calendar=""/&gt;</listing>
         */
		[Bindable(event="calendarAttributeChanged")]
        public function get calendar():String
        {
            return _calendar;
        }
		
        public function set calendar(value:String):void
        {
            if (_calendar != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "calendar", _calendar, value);
				
                _calendar = value;
                dispatchEvent(new Event("calendarAttributeChanged"))
            }
        }


        private var _keywords:String;
         /**
         * <p>Domino:Contains an optional textlist or formula element.</p>
         * <p>This property only work for filed as 'datetime' type</p>
         * <code>&lt;% datetimeformat.calendar "gregorian | hijri"&gt;</code>
         * <p><strong>gregorian</strong></p>
         * Christian calendar which is a revised version of the Julian calendar that incorporated leap years to keep sync with the lunar cycle.
         * <p><strong>hijri</strong></p>
         * Islamic calendar based on twelve lunar months.
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
        
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText keywords=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText keywords=""/&gt;</listing>
         */
        [Bindable(event="keywordsChanged")]
        public function get keywords():String
        {
            return _keywords;
        }

         public function set keywords(value:String):void
        {
            if (_keywords != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "keywords", _keywords, value);
				
                _keywords = value;
                dispatchEvent(new Event("keywordsChanged"))
            }
        }



        private var _keywordsformula:String;
        /**
         * <p>Domino:Contains formula ,Represents an function or command in the formula language..</p>
         * <p>This property only work for filed as 'keyword' or 'checkbox' type</p>
      
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText keywordsformula=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;formula &gt; &lt;formula /&gt;</listing>
         */
        [Bindable(event="keywordsformulaChanged")]
        public function get keywordsformula():String
        {
            return _keywordsformula;
        }

         public function set keywordsformula(value:String):void
        {
            if (_keywordsformula != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "keywordsformula", _keywordsformula, value);
				
                _keywordsformula = value;
                dispatchEvent(new Event("keywordsformulaChanged"))
            }
        }

        /******
         *Client: Default value,Input Translation, Input Validation, Input Enabled,HTML attribute
         *(option),(Declarations),Entering,Exiting,Initialize,Terminate
         * <!ENTITY % code.formula.events "defaultvalue | inputtranslation | inputvalidation | windowtitle | 
           webqueryopen | webquerysave | hidewhen | value | selection | htmlattributes | htmlhead | htmlbody | 
           targetframe | helprequest | form | alternatehtml | showsinglecategory | label | displayvalue ">
         */
          [Bindable]
        private var _objects:ArrayList = new ArrayList([
        {label:"Default value",value: "defaultvalue",description: "Provides an initial value for a field."},
        {label:"Input Translation",value: "inputtranslation",description:"Converts the data entered in the field to make the field conform to a specified format."},
        {label:"Input Validation",value: "inputvalidation",description:"Checks the data entered in the field against criteria that you specify."},
        // {label:"Windows Title",value: "windowtitle",description:"Generates the text that appears in the title bar of documents using the form."},
        //{label:"Web QueryOpen",value: "webqueryopen",description:"Executes before a Web document is displayed."},
        //{label:"Web Querysave",value: "webquerysave",description:"Executes before a Web document is saved."},
        //{label:"Hide When",value: "hidewhen",description:"Hides the object if the formula you provide is true."},
        //{label:"Value",value: "value",description:"Specifies the contents of a computed field."},
        // {label:"Selection",value: "selection",description:"selects the documents that appear in a view."},
        // {label:"Html Attributes",value: "htmlattributes",description:"Specifies characteristics for the associated HTML object. Applies to fields."},
        // {label:"Html Head",value: "htmlhead",description:"Information that resides in the HTML Head tag for an object. Applies to forms and pages."},
        // {label:"Html Body",value: "htmlbody",description:"Information that resides in the HTML Body tag for an object. Applies to forms and pages."},
        // {label:"Target Frame",value: "targetframe",description:"Defines which frame in a frameset the result of a command should display in."},
        // {label:"Help Request",value: "helprequest",description:"Executes when Help is selected."},
        // {label:"Form",value: "form",description:"Defines which form to open from a view."},
        // {label:"Alternate Html",value: "alternatehtml",description:"Alternate text to display if the user's browser cannot execute the code. For example, if a Java applet cannot be run by the user's browser, this text would describe the applet and inform the user that their browser's capabilities do not support it."},
        // {label:"Form",value: "form",description:"Defines which form to open from a view."},
        // {label:"Showsinglecategory",value: "showsinglecategory",description:"In embedded views, limits the documents displayed in the view to those contained in one category. The category is defined by a formula or text."},
        // {label:"Label",value: "label",description:"Specifies the label to display on an action button."},
        {label:"Displayvalue",value: "displayvalue",description:"Determines the value that displays for an action checkbox."},


           

         
        ]);

        public function get objects():ArrayList
        {
            return _objects;
        }

        private var _object:String = "defaultvalue";
		[Bindable(event="objectAttributeChanged")]
        public function get object():String
        {
            return _object;
        }
		
        public function set object(value:String):void
        {
            if (_object != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "object", _object, value);
				
                _object = value;
                dispatchEvent(new Event("objectAttributeChanged"))
            }
        }



        private var _defaultvalue:String;
        [Bindable(event="defaultValueAttributeChanged")]
		public function get defaultvalue():String
		{
			return _defaultvalue;
		}
		public function set defaultvalue(value:String):void
		{
			if (_defaultvalue != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "defaultvalue", _defaultvalue, value);
				
                _defaultvalue = value;
                dispatchEvent(new Event("defaultValueAttributeChanged"))
            }
		}

		private var _inputtranslation:String;
        [Bindable(event="inputtranslationAttributeChanged")]
		public function get inputtranslation():String
		{
			return _inputtranslation;
		}
		public function set inputtranslation(value:String):void
		{
			if (_inputtranslation != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "inputtranslation", _inputtranslation, value);
				
                _inputtranslation = value;
                dispatchEvent(new Event("inputtranslationAttributeChanged"))
            }
		}


		private var _inputvalidation:String;
        [Bindable(event="inputvalidationAttributeChanged")]
		public function get inputvalidation():String
		{
			return _inputvalidation;
		}
		public function set inputvalidation(value:String):void
		{
			if (_inputvalidation != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "inputvalidation", _inputvalidation, value);
				
                _inputvalidation = value;
                dispatchEvent(new Event("inputvalidationAttributeChanged"))
            }
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


        private var _keyformulavalue:String;
         /**
         * <p>Domino:The formula that represents  key word for list.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText keyformulavalue=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;formula &gt; &lt;formula /&gt;</listing>
         */
        [Bindable(event="keyformulavalueAttributeChanged")]
		public function get keyformulavalue():String
		{
			return _keyformulavalue;
		}
		public function set keyformulavalue(value:String):void
		{
			if (_keyformulavalue != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "keyformulavalue", _keyformulavalue, value);
				
                _keyformulavalue = value;
                dispatchEvent(new Event("keyformulavalueAttributeChanged"))
            }
		}
        /*************
         * Domino keywords
         */
           [Bindable]
        private var _keyworduis:ArrayList = new ArrayList([
        {label:"checkbox",value: "checkbox",description: "Displays options in a list with checkboxes to the left of each option. Users click the checkbox to make a selection. Users can select more than one option."},
        {label:"combobox",value: "combobox",description:"Displays a drop-down list box. Users click the down-arrow button of the drop-down list box to display the available options, then click an option to make a selection. Users can select only one option."},
        {label:"dialoglist",value: "dialoglist",description:"Displays an empty field with a down-arrow button beside it. When users click the down-arrow button, a Select Keywords dialog box displays listing the options. A Notes dialoglist field can be set to enable users to select only one or more than one option."},
        {label:"listbox",value: "listbox",description:"Displays a single row of a list and up and down arrows that a user can click to view the other rows in the list. Users can select only one option."},
        {label:"radiobutton",value: "radiobutton",description:"Displays options in a list with circles to the left of each option. Users click the circle to make a selection. Users can select only one option. Selecting a second option deselects the first option automatically."}
         
        ]);

         public function get keyworduis():ArrayList
        {
            return _keyworduis;
        }

        private var _recalonchange:Boolean=false;
        /**
         * <p>Domino:Refreshes all the fields on a form only after the user selects a value for a specific choice field.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText recalonchange="false"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText recalonchange="false"/&gt;</listing>
         */
        [Bindable(event="recalonchangeChanged")]
		public function get recalonchange():Boolean
		{
			return _recalonchange;
		}
		public function set recalonchange(value:Boolean):void
		{
			 if (_recalonchange != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "recalonchange", _recalonchange, value);
				
                _recalonchange = value;
                dispatchEvent(new Event("recalonchangeChanged"))
            }
		}

        private var _keyformulachoices:Boolean=false;
        [Bindable(event="keyformulachoicesChanged")]
		public function get keyformulachoices():Boolean
		{
			return _keyformulachoices;
		}
		public function set keyformulachoices(value:Boolean):void
		{
			 if (_keyformulachoices != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "keyformulachoices", _keyformulachoices, value);
				
                _keyformulachoices = value;
                dispatchEvent(new Event("keyformulachoicesChanged"))
            }
		}



		private var _recalcchoices:Boolean=false;
         /**
         * <p>Domino:Refreshes all the fields on a form only after the user selects a value for a specific choice field.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText recalcchoices="false"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText recalcchoices="false"/&gt;</listing>
         */
        [Bindable(event="recalcchoicesChanged")]
		public function get recalcchoices():Boolean
		{
			return _recalcchoices;
		}
		public function set recalcchoices(value:Boolean):void
		{
			 if (_recalcchoices != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "recalcchoices", _recalcchoices, value);
				
                _recalcchoices = value;
                dispatchEvent(new Event("recalcchoicesChanged"))
            }
		}
    
        private var _keywordui:String = "checkbox";
		[Bindable(event="checkboxAttributeChanged")]
         /**
         * <p>Domino:Types of list fields that the end user sees, as defined in the %keywords.ui; entity.</p>
         * <code>&lt;!ENTITY % keywords.ui "dialoglist | checkbox | radiobutton | combobox | listbox "&gt;</code>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText recalcchoices="false"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText recalcchoices="false"/&gt;</listing>
         */
        public function get keywordui():String
        {
            return _keywordui;
        }
		
        public function set keywordui(value:String):void
        {
            if (_keywordui != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "keywordui", _keywordui, value);
				
                _keywordui = value;
                dispatchEvent(new Event("checkboxAttributeChanged"))
            }
        }


        /**
         * names list field
         */

         [Bindable]
        private var _choicesdialogs:ArrayList = new ArrayList([
        {label:"none",value: "none",description: "Generates no choice list for Names and Readers fields, supplies the name of the form author for an Authors field, and displays a list of choices or a formula entered by the designer for a dialog list field."},
        {label:"acl",value: "acl",description:"Displays names from a list of people, servers, groups, and roles in the Access Control List of a database."},
        {label:"addressbook",value: "addressbook",description:"Displays a list of names from a Personal Address Book or Domino Directory Names dialog box."},
        {label:"view",value: "view",description:"Displays names from a dialog box containing entries from a column in a view."}
        
        ]);

        public function get choicesdialogs():ArrayList
        {
            return _choicesdialogs;
        }
    
        private var _choicesdialog:String = "none";
        /**
         * <p>Domino:Types of list fields available as defined in the %field.choicesdialogs; entity.</p>
         * <code>&lt;!ENTITY % field.choicesdialogs "none | addressbook | acl | view "&gt;</code>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText choicesdialog="false"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText choicesdialog="false"/&gt;</listing>
         */
		[Bindable(event="choicesdialogAttributeChanged")]
        public function get choicesdialog():String
        {
            return _choicesdialog;
        }
		
        public function set choicesdialog(value:String):void
        {
            if (_choicesdialog != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "choicesdialog", _choicesdialog, value);
				
                _choicesdialog = value;
                dispatchEvent(new Event("choicesdialogAttributeChanged"))
            }
        }
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

        /**
         * <!ENTITY % list.separators "space | comma | semicolon | newline | blankline | none">
         */
         [Bindable]
        private var _separators:ArrayList = new ArrayList([
        {label:"space",value: "space",description: "space","selected": false},
        {label:"comma",value: "comma",description:"comma","selected": false},
        {label:"semicolon",value: "semicolon",description:"semicolon","selected": false},
        {label:"newline",value: "newline",description:"newline","selected": false},
        {label:"blankline",value: "blankline",description:"blankline","selected": false}
        ]);

         public function get separators():ArrayList
         {
             return _separators;
         }


         [Bindable]
        private var _securityOptions:ArrayList = new ArrayList([
        {label:"Sign if mailed or saved in section",value: "sign",description: "sign","selected":true},
        {label:"Enable encryption for this field",value: "seal",description:"seal","selected":false},
        {label:"Must have at least Editor access to use",value: "protected",description:"protected","selected":true}
       
        ]);


        public function get securityOptions():ArrayList
        {
            return _securityOptions;
        }

        private var _inputProtected:Boolean;

		public function get inputProtected():Boolean
		{
			return _inputProtected;
		}

		public function set inputProtected(value:Boolean):void
		{
			_inputProtected = value;
		}

		private var _inputSeal:Boolean;

		public function get inputSeal():Boolean
		{
			return _inputSeal;
		}

		public function set inputSeal(value:Boolean):void
		{
			_inputSeal = value;
		}


		private var _inputSign:Boolean;

		public function get inputSign():Boolean
		{
			return _inputSign;
		}

		public function set inputSign(value:Boolean):void
		{
			_inputSign = value;
		}

        [Bindable(event="securityOptionsInputAttributeChanged")]
        private var _securityOptionsInput:String;

		public function get securityOptionsInput():String
		{
			return _securityOptionsInput;
		}

		public function set securityOptionsInput(value:String):void
		{
			if (_keyformulavalue != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "securityOptionsInput", _securityOptionsInput, value);
				
                _securityOptionsInput = value;
                dispatchEvent(new Event("securityOptionsInputAttributeChanged"))
            }
           
		}

        private var _listinputseparators:String = "comma semicolon newline";
        /**
         * <p>Domino:The types of separators that can be used between list elements when a user enters multiple values. See the %list.separators; entity for a list of available options. NMTOKENS are name tokens that enable a user to make multiple choices.</p>
          * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText listinputseparators="false"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText listinputseparators="false"/&gt;</listing>
         */
        [Bindable(event="listinputseparatorsAttributeChanged")]
        public function get listinputseparators():String
        {
            return _listinputseparators;
        }
		
        public function set listinputseparators(value:String):void
        {
            if (_listinputseparators != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "listinputseparators", _listinputseparators, value);
				
                _listinputseparators = value;
                dispatchEvent(new Event("listinputseparatorsAttributeChanged"))
            }
        }

        private var _listdisplayseparator:String = "newline";
        /**
         * <p>Domino:The types of separators that can be used between list elements when a user enters multiple values. See the %list.separators; entity for a list of available options. NMTOKENS are name tokens that enable a user to make multiple choices.</p>
          * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>PrimeFaces</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText listdisplayseparator="false"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText listdisplayseparator="false"/&gt;</listing>
         */
		[Bindable(event="listdisplayseparatorAttributeChanged")]
        public function get listdisplayseparator():String
        {
            return _listdisplayseparator;
        }
		
        public function set listdisplayseparator(value:String):void
        {
            if (_listdisplayseparator != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "listdisplayseparator", _listdisplayseparator, value);
				
                _listdisplayseparator = value;
                dispatchEvent(new Event("listdisplayseparatorAttributeChanged"))
            }
        }

        


        //formula
        private var _formula:String;
        [Bindable(event="formulaChanged")]
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
                dispatchEvent(new Event("formulaChanged"))
            }
        }  

        //richtitile
        //<!ENTITY % field.limitinput.kinds "picture | sharedimage | attachment | view | datepicker |
        // sharedapplet | text | object | calendar | inbox ">
        [Bindable]
        private var _limitinputKinds:ArrayList = new ArrayList([
        {label:"picture",value: "picture",description: "picture", "selected": false},
        {label:"sharedimage",value: "sharedimage",description: "sharedimage", "selected": false},
        {label:"attachment",value: "attachment",description: "attachment", "selected": false},
        {label:"view",value: "view",description: "view", "selected": false},
        {label:"sharedapplet",value: "sharedapplet",description: "sharedapplet", "selected": false},
        {label:"text",value: "text",description: "text", "selected": false},
        {label:"object",value: "object",description: "object", "selected": false},
        {label:"calendar",value: "calendar",description: "calendar", "selected": false},
        {label:"inbox",value: "inbox",description: "inbox", "selected": false},
        {label:"datepicker",value: "datepicker",description: "datepicker", "selected": false}
        ]);

        public function get limitinputKinds():ArrayList
        {
            return _limitinputKinds;
        }
    
        private var _onlyallow:String ="picture sharedimage attachment view sharedapplet text object calendar datepicker";
		[Bindable(event="onlyallowAttributeChanged")]
        public function get onlyallow():String
        {
            return _onlyallow;
        }
		
        public function set onlyallow(value:String):void
        {
            if (_onlyallow != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "onlyallow", _onlyallow, value);
				
                _onlyallow = value;
                dispatchEvent(new Event("onlyallowAttributeChanged"))
            }
        }



        private var _firstdisplay:String = "picture";
		[Bindable(event="firstdisplayAttributeChanged")]
        public function get firstdisplay():String
        {
            return _firstdisplay;
        }
		
        public function set firstdisplay(value:String):void
        {
            if (_firstdisplay != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "firstdisplay", _firstdisplay, value);
				
                _firstdisplay = value;
                dispatchEvent(new Event("firstdisplayAttributeChanged"))
            }
        }

         /**
         * Domino property list end***********************
         */

        private var _required:Boolean;
        private var requiredChanged:Boolean;

        [Bindable(event="requiredChanged")]
        /**
         * <p>Domino: <strong>required</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText required="false"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;inputText required="false"/&gt;</listing>
         */
        public function get required():Boolean
        {
            return _required;
        }

        public function set required(value:Boolean):void
        {
            if (_required != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "required", _required, value);

                _required = value;
                requiredChanged = true;

                dispatchEvent(new Event("requiredChanged"));
            }
        }

        public function get propertyEditorClass():Class
        {
            return InputTextPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;
        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
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



        private var _hide:String;
		public function get hide():String
		{
			return _hide;
		}
		public function set hide(value:String):void
		{
			_hide = value;
		}

        private var _helpDescription:String;

		public function get helpDescription():String
		{
			return _helpDescription;
		}

		public function set helpDescription(value:String):void
		{
			_helpDescription = value;
		}

		private var _fieldHint:String;

		public function get fieldHint():String
		{
			return _fieldHint;
		}

		public function set fieldHint(value:String):void
		{
			_fieldHint = value;
		}


        	//---------font /size  /color--------------------------------------------------------
		private var _size:String;

		public function get size():String
		{
			return _size;
		}

		public function set size(value:String):void
		{
			_size = value;
		}

		private var _color:String;

		public function get color():String
		{
			return _color;
		}

		public function set color(value:String):void
		{
			_color = value;
		}

		private var _fontStyle:String;

		public function get fontStyle():String
		{
			return _fontStyle;
		}

		public function set fontStyle(value:String):void
		{
			_fontStyle = value;
		}

		private var _fontName:String;

		public function get fontName():String
		{
			return _fontName;
		}

		public function set fontName(value:String):void
		{
			_fontName = value;
		}


        public function toXML():XML
        {
            
           
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            xml.@value = this.text;
            xml.@required = this.required;
            xml.@recalonchange=this.recalonchange.toString();
            xml.@recalcchoices=this.recalcchoices.toString();
            xml.@keyformulachoices=this.keyformulachoices.toString();
            xml.@securityOptionsInput = this.securityOptionsInput;

           
            xml.@numberColumns = this.numberColumns;
            

            if(this.formula){
                 xml.@formula =  StringHelper.base64Encode(this.formula);;
            }

            if(this.keywordsformula){
                xml.@keywordsformula=StringHelper.base64Encode(this.keywordsformula);
            }

            if(this.defaultvalue){
                 xml.@defaultvalue = StringHelper.base64Encode(this.defaultvalue);
            }

            if(this.inputtranslation){
                 xml.@inputtranslation =  StringHelper.base64Encode(this.inputtranslation);;
            }
            if(this.inputvalidation){
                 xml.@inputvalidation = StringHelper.base64Encode(this.inputvalidation);;
            }

            if(this.hidewhen){
                 xml.@hidewhen = StringHelper.base64Encode(this.hidewhen);;
            }
            if(this.hide){
                xml.@hide = this.hide;
            }


            if(this.object){
                xml.@object = this.object;
            }

            if (this.idAttribute)
            {
                xml.@id = this.idAttribute;
            }

            if(this.nameAttribute){
                xml.@name = this.nameAttribute;
            }

            if(this.allowmultivalues){
                xml.@allowmultivalues = this.allowmultivalues;
            }

            if(this.kind){
                xml.@kind = this.kind;
                //remove the formula if the kind not is computed
                if(this.kind=="computed"||this.kind=="computedfordisplay"||this.kind=="computedwhencomposed"){
                }else{
                    if(this.type!="formula"){
                       // this.formula="";
                        //delete xml.@formula
                    }
                   
                }
                
            }

            if(this.type){
                xml.@type = this.type;
                if(this.type=="number"){
                    xml.@digits = this.digits;
                    xml.@format = this.format;
                    xml.@parens = this.parens;
                    xml.@percent = this.percent;
                    xml.@punctuated = this.punctuated;
                }else{
                    delete xml.@digits
                    delete xml.@format
                    delete xml.@parens
                    delete xml.@percent
                    delete xml.@punctuated

                }
                if(this.type=="datetime"){
                    xml.@show = this.show;
                    xml.@date = this.date;
                    xml.@showtodaywhenappropriate = this.showtodaywhenappropriate;
                    xml.@fourdigityear = this.fourdigityear;
                    xml.@fourdigityearfor21stcentury = this.fourdigityearfor21stcentury;

                    xml.@omitthisyear = this.omitthisyear;
                    xml.@time = this.time;
                    xml.@zone = this.zone;
                    xml.@calendars = this.calendar;
                }else{
                    delete xml.@show
                    delete xml.@date
                    delete xml.@showtodaywhenappropriate
                    delete xml.@fourdigityear
                    delete xml.@fourdigityearfor21stcentury
                    delete xml.@omitthisyear
                    delete xml.@time
                    delete xml.@zone
                    delete xml.@calendars
                }
         

                if(this.type=="keyword"){
                     //Alert.show("key:"+this.keywords);
                     if(this.keywords){
                        //if user input shift+enter ,it will brek the text list new line.
                        //so we need filter the shift+enter in here----starting.
                        var cache:String="";
                        for(var i:int = 0; i < this.keywords.length; i++){
                            var ascii:int=this.keywords.charCodeAt(i);
                             if(ascii==8232){
                                 ascii=10;
                             }
                             cache=cache+String.fromCharCode(ascii);
                        }
                        if(this.keywords!=cache){
                            this.keywords=cache;
                        }
                        //filter shift+enter end-----------------------

                        xml.@keywords = StringHelper.base64Encode(this.keywords);

                                          
                     }

                     if(this.keywordui){
                         xml.@keywordui=this.keywordui
                     }
                }else{
                    delete xml.@keywords
                    delete xml.@keywordui
                }
                if(this.listdisplayseparator){
                    xml.@listdisplayseparator=this.listdisplayseparator
                }

                if(this.listinputseparators){
                    xml.@listinputseparators=this.listinputseparators
                }

                if(this.type=="names"){
                     if(this.choicesdialog){
                        xml.@choicesdialog=this.choicesdialog
                     }else{
                        xml.@choicesdialog="none"
                     }

                     
                  
                }else{
                     delete xml.@choicesdialog

                     //delete xml.@listdisplayseparator

                    // delete xml.@listinputseparators
                }


                 if(this.type=="richtextlite"){
                    if(this.onlyallow){
                        xml.@onlyallow=this.onlyallow
                    }
                    if(this.firstdisplay){
                        xml.@firstdisplay=this.firstdisplay
                    }

                 }else{
                    delete xml.@onlyallow
                    delete xml.@firstdisplay
                 }
            }

            if(this.width){
                xml.@width = this.width;
            }
            if(this.height){
                xml.@height = this.height;
            }

			if ((StringUtil.trim(maxLength).length != 0) && Math.round(Number(maxLength)) != 0)
			{
				xml.@maxlength = this.maxLength;
			}

            //help description
            xml.@fieldHint = this.fieldHint;
            xml.@helpDescription = this.helpDescription;

            return xml;
        }

        public function fromXML(xml:XML, callback:Function, surface:ISurface,  lookup:ILookup):void
        {
			var localSurface:ISurface = surface;

            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
            //Alert.show("xml:"+xml.toXMLString());

			component.fromXML(xml, callback, localSurface, lookup);
			
            this.text = component.text;
			this.maxLength = component.maxLength;
            this.idAttribute = component.idAttribute;
            this.required = component.required;
          //  this.numberColumns = component.numberColumns;

            this.nameAttribute=component.nameAttribute;
            this.kind = component.kind;
            this.type = component.type;
            this.allowmultivalues = component.allowmultivalues;
            this.width = component.width;
            this.height = component.height;
            this.object = component.object;
            this.recalcchoices = component.recalcchoices;
            this.recalonchange = component.recalonchange;
            this.securityOptionsInput = component.securityOptionsInput;
            this.keyformulachoices = component.keyformulachoices;
            this.helpDescription = component.helpDescription;
            this.fieldHint = component.fieldHint;
            if(component.formula){
                
               this.formula=  StringHelper.base64Decode(component.formula);
            }
            if(component.keywordsformula){
                this.keywordsformula= StringHelper.base64Decode(component.keywordsformula);
            }
             if(component.defaultvalue){
                
               this.defaultvalue=  StringHelper.base64Decode(component.defaultvalue);
            }
             if(component.inputtranslation){
                
               this.inputtranslation=  StringHelper.base64Decode(component.inputtranslation);
            }
             if(component.inputvalidation){
                
               this.inputvalidation=  StringHelper.base64Decode(component.inputvalidation);
            }
             if(component.hidewhen){
                
               this.hidewhen=  StringHelper.base64Decode(component.hidewhen);
            }
            if(component.hide){
                this.hide = component.hide;
            }


            if(this.type =="number"){

                this.digits= parseInt(component.digits);
                this.format=component.format  ;
                this.punctuated=component.punctuated ;
                this.parens=component.parens ;
                this.percent=component.percent ;

            }

             if(this.type =="datetime"){
                 this.show=component.show ;
                 this.date = component.date;
                 this.showtodaywhenappropriate = component.showtodaywhenappropriate;
                 this.fourdigityear = component.fourdigityear;
                 this.fourdigityearfor21stcentury = component.fourdigityearfor21stcentury;
                 this.omitthisyear = component.omitthisyear;
                 this.time = component.time;
                 this.zone = component.zone;
                 this.calendar = component.calendar;
             }

                if(this.type =="keyword"){
                    if(component.keywords){
                          this.keywords=StringHelper.base64Decode(component.keywords);
                    }
                  
                    this.keywordui=component.keywordui;

                    this.numberColumns = component.numberColumns;
                    //Alert.show("numberColumns:"+this.numberColumns);
                }

                 if(this.type =="names"){
                     if(component.choicesdialog){
                         this.choicesdialog=component.choicesdialog
                     }

                     
                 }
                if(component.listinputseparators){
                    this.listinputseparators=component.listinputseparators;
                }

                if(component.listdisplayseparator){
                    this.listdisplayseparator=component.listdisplayseparator;
                }

                 if(this.type =="richtextlite"){
                     if(component.onlyallow){
                         this.onlyallow=component.onlyallow
                     }
                     if(component.firstdisplay){
                         this.firstdisplay=component.firstdisplay
                     }
                 }


        }

        public function toCode():XML
        {
            component.text = this.text;
            component.required = this.required;
			component.maxLength = this.maxLength;
			component.idAttribute = this.idAttribute;
            component.nameAttribute = this.nameAttribute;
            component.type=this.type;
            component.kind = this.kind;
            component.allowmultivalues = this.allowmultivalues;
            component.width= this.width;
            component.height= this.height;
            component.object= this.object;
            component.defaultvalue= this.defaultvalue;
            component.inputvalidation = this.inputvalidation;
            component.inputtranslation = this.inputtranslation;
            component.hidewhen = this.hidewhen;
            component.hide = this.hide;
            component.keywordsformula=this.keywordsformula;
            component.keyformulachoices=this.keyformulachoices;
            component.helpDescription = this.helpDescription;
            component.fieldHint = this.fieldHint;
            component.securityOptionsInput= this.securityOptionsInput;
            if(this.formula){
                component.formula= this.formula;
            }
            if(this.listdisplayseparator){
                component.listdisplayseparator= this.listdisplayseparator;
            }
            if(this.listinputseparators){
                component.listinputseparators = this.listinputseparators;
            }
           //Alert.show("formula:"+formula);

				
			component.isSelected = this.isSelected;

            if(this.type=="number"){
                component.digits = this.digits.toString();
                component.format = this.format;
                component.punctuated = this.punctuated;
                component.parens = this.parens;
                component.percent = this.percent;
            }
             if(this.type=="datetime"){
                component.show = this.show.toString();
                component.date = this.date;
                component.showtodaywhenappropriate = this.showtodaywhenappropriate;
                component.fourdigityear = this.fourdigityear;
                component.fourdigityearfor21stcentury = this.fourdigityearfor21stcentury;
                component.omitthisyear = this.omitthisyear;
                component.time = this.time;
                component.zone = this.zone;
                component.calendar = this.calendar;
            }
            component.numberColumns=this.numberColumns;
             if(this.type=="keyword"){
                
                    component.keywords=this.keywords;
                    //Alert.show("numberColumns:"+this.numberColumns);
                    component.keywordui=this.keywordui;
                 
                    component.recalonchange = this.recalonchange;
                    component.recalcchoices = this.recalcchoices;
                    component.keyformulachoices = this.keyformulachoices;

             }

             if(this.type=="names"){
                 component.choicesdialog=this.choicesdialog

             }
             if(this.type=="richtextlite"){
                 component.onlyallow=this.onlyallow
                 component.firstdisplay=this.firstdisplay

             }
			// (component as components.domino.DominoInputText).width = this.width;
			// (component as components.domino.DominoInputText).height = this.width;
			(component as components.domino.DominoInputText).percentWidth = this.percentWidth;
			(component as components.domino.DominoInputText).percentHeight = this.percentHeight;
			
            return component.toCode();
        }

        public	function toRoyaleConvertCode():XML
		{
            component.text = this.text;
            component.required = this.required;
			component.maxLength = this.maxLength;
			component.idAttribute = this.idAttribute;
            component.nameAttribute = this.nameAttribute;
            component.type=this.type;
            component.kind = this.kind;
            if(this.type=="keyword")
			{
				component.keywords=this.keywords;
				component.keywordui=this.keywordui;

				component.recalonchange = this.recalonchange;
				component.recalcchoices = this.recalcchoices;
				component.keyformulachoices = this.keyformulachoices;
             }

			return (component as IRoyaleComponentConverter).toRoyaleConvertCode();
		}

		public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, null));
		}
    }
}
