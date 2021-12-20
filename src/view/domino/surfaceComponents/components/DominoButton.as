package view.domino.surfaceComponents.components
{
    import components.domino.DominoButton;

    import flash.events.Event;

    import interfaces.dominoComponents.IDominoButton;

    import spark.components.Button;
    
    import data.OrganizerItem;

    import utils.XMLCodeUtils;

    import mx.collections.ArrayList;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IDominoSurfaceComponent;
    import view.domino.propertyEditors.DominoButtonPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.ButtonSkin;
    import view.suportClasses.PropertyChangeReference; 

    import view.interfaces.ISurfaceComponent;
    import utils.StringHelper;
    import mx.controls.Alert;

    [Exclude(name="propertyChangeFieldReference", kind="property")]
	[Exclude(name="actionListener", kind="property")]
    [Exclude(name="isUpdating", kind="property")]

	[Exclude(name="propertiesChangedEvents", kind="property")]
	[Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="toRoyaleConvertCode", kind="method")]
    [Exclude(name="isSelected", kind="property")]
	[Exclude(name="PRIME_FACES_XML_ELEMENT_NAME_COMMAND_BUTTON", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces button component</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;Button
	 * <b>Attributes</b>
	 * width="100"
	 * height="30"
	 * disabled="false"
	 * value="Button"
	 * title=""/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:button
	 * <b>Attributes</b>
	 * style="width:100px;height:30px;"
	 * disabled="false"
	 * value="Button"
	 * title=""/&gt;
     * </pre>
     */
    public class DominoButton extends spark.components.Button implements IDominoSurfaceComponent, IHistorySurfaceComponent
	{
		public static const DOMINO_ELEMENT_NAME:String = "button";
		public static const ELEMENT_NAME:String = "button";

		private var component:IDominoButton;

		public function DominoButton()
		{
			super();

            component = new components.domino.DominoButton();

            this.setStyle("skinClass", ButtonSkin);

			this.label = "Button";
			this.toolTip = "";
			this.width = 100;
			this.height = 30;
			this.minWidth = 20;
			this.minHeight = 20;
			
			_propertiesChangedEvents = [
					"widthChanged",
					"heightChanged",
					"explicitMinWidthChanged",
					"explicitMinHeightChanged",
					"enabledChanged",
					"labelChanged",
                    "sizeChanged",
                    "colorAttributeChanged",
                    "fontStyleAttributeChanged",
                    "codeeventChanged",
                    "codeChanged"
			];
		}
        [Bindable("codeeventChanged")]
        private var _codeevent:String = "click";
		public function get codeEvent():String
		{
			return _codeevent;
		}
		public function set codeEvent(value:String):void
		{
			_codeevent = value;
		}


        [Bindable("codeChanged")]
        private var _code:String;
        public function get code():String
		{
			return _code;
		}

		public function set code(value:String):void
		{
			_code = value;
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
         * <p>Domino: <strong>size</strong></p>
         *
         * @default "12"
         *
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
    /**
     *action | onhelp | queryopen | queryrecalc | postopen | 
     querymodechange | querysend | postsend | postmodechange | 
     postrecalc | querysave | postsave | queryclose | click | 
     regiondoubleclick | queryopendocument | queryaddtofolder | 
     querydragdrop | querypaste | postdragdrop | postpaste | 
     onload | onunload | onsubmit | queryentryresize | postentryresize 
     */

        [Bindable]
        private var _codeEnventList:ArrayList = new ArrayList([
        {label: "action",value:"action",description: "action"},
        {label: "onhelp",value:"onhelp",description: "onhelp"},
        {label: "queryopen",value:"queryopen",description: "queryopen"},
        {label: "queryrecalc",value:"queryrecalc",description: "queryrecalc"},
        {label: "postopen",value:"postopen",description: "postopen"},
        {label: "querymodechange",value:"querymodechange",description: "querymodechange"},
        {label: "querysend",value:"querysend",description: "querysend"},
        {label: "postsend",value:"postsend",description: "postsend"},
        {label: "postrecalc",value:"postrecalc",description: "postrecalc"},
        {label: "querysave",value:"querysave",description: "querysave"},
        {label: "queryclose",value:"queryclose",description: "queryclose"},
        {label: "click",value:"click",description: "click"},
        {label: "regiondoubleclick",value:"regiondoubleclick",description: "regiondoubleclick"},
        {label: "queryopendocument",value:"queryopendocument",description: "queryopendocument"},
        {label: "queryaddtofolder",value:"queryaddtofolder",description: "queryaddtofolder"},
        {label: "querydragdrop",value:"querydragdrop",description: "querydragdrop"},
        {label: "querypaste",value:"querypaste",description: "querypaste"},
        {label: "postdragdrop",value:"postdragdrop",description: "postdragdrop"},
        {label: "postpaste",value:"postpaste",description: "postpaste"},
        {label: "onload",value:"onload",description: "onload"},
        {label: "onunload",value:"onunload",description: "onunload"},
        {label: "onsubmit",value:"onsubmit",description: "onsubmit"},
        {label: "queryentryresize",value:"queryentryresize",description: "queryentryresize"},
        {label: "postentryresize",value:"postentryresize",description: "postentryresize"}
        ]);

        public function get codeEnventList():ArrayList
        {
            return _codeEnventList;
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

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>Domino: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Button percentWidth="80"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:button style="width:80%;"/&gt;</listing>
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
         * <listing version="3.0">&lt;Button width="100"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:button style="width:100px;height:30px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;Button percentHeight="80"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:button style="height:80%;"/&gt;</listing>
         */
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
		 * <listing version="3.0">&lt;Button height="30"/&gt;</listing>
         * @example
		 * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:button style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        private var _enabled:Boolean = true;

        [Bindable("enabledChanged")]
        [Inspectable(category="General", enumeration="true,false", defaultValue="true")]
        /**
         * <p>Domino: <strong>disabled</strong></p>
         *
         * @default "false"
		 * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Button disabled="false"/&gt;</listing>
         * @example
		 * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:button disabled="false"/&gt;</listing>
         */
        override public function get enabled():Boolean
        {
            return _enabled;
        }


        [Inspectable(category="General", enumeration="true,false", defaultValue="true")]
        override public function set enabled(value:Boolean):void
        {
			if (_enabled != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "enabled", _enabled, value);
                _enabled = value;
                invalidateSkinState();
				dispatchEvent(new Event("enabledChanged"));
            }
        }

        [Bindable("labelChanged")]
        /**
		 * <p>Domino: <strong>value</strong></p>
		 *
		 * @default "Button"
		 *
		 * @example
         * <strong>Visual Editor:</strong>
         * <listing version="3.0">&lt;Button value="Button"/&gt;</listing>
		 * @example
		 * <strong>Domino:</strong>
		 * <listing version="3.0">&lt;p:button value="Button"/&gt;</listing>
         */
        override public function get label():String
        {
            return super.label;
        }

		override public function set label(value:String):void
		{
			if (super.label != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "label", super.label, value);
				
				super.label = value;
				dispatchEvent(new Event("labelChanged"));
			}
		}
		
	

        public function get propertyEditorClass():Class
		{
			return DominoButtonPropertyEditor;
		}		
		
		private var _propertiesChangedEvents:Array;
		public function get propertiesChangedEvents():Array
		{
			return _propertiesChangedEvents;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

			xml.@disabled = !this.enabled;
            xml.@label = this.label;
            xml.@size = this.size;
            xml.@color = this.color;
            xml.@fontStyle = this.fontStyle;
            
            if(this.code){
                 xml.@code =  StringHelper.base64Encode(this.code);
                 if(this.codeEvent){
                     xml.@codeEvent=this.codeEvent;
                 }
            }


			return xml;
		}

        public function toRora():XML
        {
            Alert.show("Mock toRXML execute0");
            var xml:XML=component.toRoyaleConvertCode();
            return xml;
        }

        

        public function fromXML(xml:XML, childFromXMLCallback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

            component.fromXML(xml, childFromXMLCallback);

            this.enabled = component.enabled;
            this.label = component.label;
            this.size= component.size;
            this.color= component.color;
            this.fontStyle = component.fontStyle;

            if(component.code){
               this.code=  StringHelper.base64Decode(component.code);
            }

            if(component.codeEvent){
                this.codeEvent=component.codeEvent;
            }


        }

        public function  toRoyaleConvertCode():XML
        {
            Alert.show("Mock toRoyaleConvertCode execute0");
            component.enabled = this.enabled;
			component.label = this.label;
            component.isSelected = this.isSelected;

            component.size = this.size;
            component.color = this.color;
            component.fontStyle = this.fontStyle;

            component.code = this.code;
            component.codeEvent = this.codeEvent;
         
            (component as components.domino.DominoButton).width = this.width;
            (component as components.domino.DominoButton).height = this.height;
            (component as components.domino.DominoButton).percentWidth = this.percentWidth;
            (component as components.domino.DominoButton).percentHeight = this.percentHeight;
            Alert.show("Mock toRoyaleConvertCode execute1");
			return component.toRoyaleConvertCode();
        }

		public function toCode():XML
		{
			component.enabled = this.enabled;
			component.label = this.label;
            component.isSelected = this.isSelected;

            component.size = this.size;
            component.color = this.color;
            component.fontStyle = this.fontStyle;

            component.code = this.code;
            component.codeEvent = this.codeEvent;

            (component as components.domino.DominoButton).width = this.width;
            (component as components.domino.DominoButton).height = this.height;
            (component as components.domino.DominoButton).percentWidth = this.percentWidth;
            (component as components.domino.DominoButton).percentHeight = this.percentHeight;
             Alert.show("Mock toCode execute1");
			return component.toCode();
        }

		public function getComponentsChildren(...params):OrganizerItem
		{
            return (new OrganizerItem(this, ELEMENT_NAME, null));
		}
	}
}