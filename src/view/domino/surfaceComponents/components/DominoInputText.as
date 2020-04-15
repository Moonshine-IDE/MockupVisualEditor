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
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IInputText;
    import interfaces.dominoComponents.IDominoInputText;
    import components.domino.DominoInputText;

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
				"maxLengthChanged",
                "idAttributeChanged", 
                "nameAttributeChanged", 
                "kindAttributeChanged", 
                "typeAttributeChanged", 
                "allowmultivaluesAttributeChanged", 
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
          //-----width-------------------------
          //-----heigh-------------------------
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