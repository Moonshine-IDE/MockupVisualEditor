package view.domino.surfaceComponents.components
{
    import flash.events.Event;

    import interfaces.IComponentSizeOutput;

    import mx.utils.StringUtil;
    
    import spark.components.TextInput;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;
    import mx.collections.ArrayList;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IIdAttribute;
    import view.interfaces.INameAttribute;
    import view.interfaces.IDominoSurfaceComponent;
    import view.domino.propertyEditors.InputTextPropertyEditor;
    import view.primeFaces.propertyEditors.InputNumberPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IInputText;
    import interfaces.dominoComponents.IDominoInputText;
    import components.domino.DominoInputText;

    import mx.controls.Alert;
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
    // [Exclude(name="keywords", kind="property")]
    


    /**
     * <p>Representation of PrimeFaces inputText component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;InputText
     * <b>Attributes</b>
     * id=""
     * width="100"
     * height="30"
     * value=""
     * maxlength=""
     * required="false"/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:inputText
     * <b>Attributes</b>
     * id=""
     * style="width:100px;height:30px;"
     * value=""
     * maxlength=""
     * required="false"/&gt;
     * </pre>
     */
    public class DominoInputText extends TextInput implements IDominoSurfaceComponent,IIdAttribute,
            IHistorySurfaceComponent, IComponentSizeOutput
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
			this.maxHeight = 30;

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
                "checkboxAttributeChanged"
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

        private var _idAttribute:String;
		[Bindable(event="idAttributeChanged")]
        /**
         * <p>PrimeFaces: <strong>id (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText id=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText id=""/&gt;</listing>
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
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="width:80%;"/&gt;</listing>
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
         * @default "100"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText width="100"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="width:100px;height:30px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;InputText percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="height:80%;"/&gt;</listing>
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
         * @default "30"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText height="30"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

		private var _maxLength:String = "";
		[Bindable(event="maxLengthChanged")]
        /**
         * <p>PrimeFaces: <strong>maxlength (Optional)</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText maxlength=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText maxlength=""/&gt;</listing>
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
         * <p>PrimeFaces: <strong>value</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText value=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText value=""/&gt;</listing>
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
        /**
         * Domino property list start***********************
         */

        //-----name-------------------------
        private var _nameAttribute:String;
		[Bindable(event="nameAttributeChanged")]
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



        /**
         * Domino number field property list start***********************
         */
          //-----digits-------------------------
          //Represents the number of decimal places (0 to 15) to display when displaying the number. 
          //If the value is "varying," indicates that the number of decimal places to display may change.
        private var _digits:Number=0;
     
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
        private var _showtodaywhenappropriate:Boolean;
        private var showtodaywhenappropriateChanged:Boolean;

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
      private var _fourdigityear:Boolean;
        private var fourdigityearChanged:Boolean;

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
        private var _fourdigityearfor21stcentury:Boolean;
        private var f21stChanged:Boolean;

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
private var _omitthisyear:Boolean;
        private var omitthisyearChanged:Boolean;

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
    
        private var _keywordui:String = "checkbox";
		[Bindable(event="checkboxAttributeChanged")]
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
         * Domino property list end***********************
         */

        private var _required:Boolean;
        private var requiredChanged:Boolean;

        [Bindable(event="requiredChanged")]
        /**
         * <p>PrimeFaces: <strong>required</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText required="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:inputText required="false"/&gt;</listing>
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
                if(this.type=="datetiem"){
                    xml.@show = this.show;
                    xml.@date = this.date;
                    xml.@showtodaywhenappropriate = this.showtodaywhenappropriate;
                    xml.@fourdigityear = this.fourdigityear;
                    xml.@fourdigityearfor21stcentury = this.fourdigityearfor21stcentury;

                    xml.@omitthisyear = this.omitthisyear;
                    xml.@time = this.time;
                    xml.@zone = this.zone;
                    xml.@calendars = this.calendars;
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
                        var encodeStr:String= StringHelper.base64Encode(this.keywords)
                      
                         xml.@keywords = encodeStr;
                     }

                     if(this.keywordui){
                         xml.@keywordui=this.keywordui
                     }
                }else{
                    delete xml.@keywords
                    delete xml.@keywordui
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

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

			component.fromXML(xml, callback);
			
            this.text = component.text;
			this.maxLength = component.maxLength;
            this.idAttribute = component.idAttribute;
            this.required = component.required;

            this.nameAttribute=component.nameAttribute;
            this.kind = component.kind;
            this.type = component.type;
            this.allowmultivalues = component.allowmultivalues;
            this.width = component.width;
            this.height = component.height;

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
                          this.keywords=StringHelper.base64Decode(component.keywords)
                    }
                  
                    this.keywordui=component.keywordui
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
             if(this.type=="keyword"){
                
                    component.keywords=this.keywords
                  
                    component.keywordui=this.keywordui
             }
			// (component as components.domino.DominoInputText).width = this.width;
			// (component as components.domino.DominoInputText).height = this.width;
			(component as components.domino.DominoInputText).percentWidth = this.percentWidth;
			(component as components.domino.DominoInputText).percentHeight = this.percentHeight;
			
            return component.toCode();
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
