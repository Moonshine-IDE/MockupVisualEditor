package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.controls.HRule;
    import mx.graphics.SolidColor;
    import mx.graphics.SolidColorStroke;
    import mx.utils.StringUtil;
    
    import spark.components.BorderContainer;
    import spark.components.Group;
    import spark.components.Image;
    import spark.components.TextArea;
    import spark.layouts.VerticalLayout;
    
    import components.FlowLayout;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IInitializeAfterAddedComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.TextEditorPropertyEditor;
    import view.suportClasses.PropertyChangeReference;

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

    /**
     * <p>Representation of PrimeFaces TextEditor component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;TextEditor
     * <b>Attributes</b>
     * width="110"
     * height="110"
     * src=""/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;ui:textEditor
     * <b>Attributes</b>
     * style="width:110px;height:110px;"
     * src=""/&gt;
     * </pre>
     */
    public class TextEditor extends BorderContainer implements IPrimeFacesSurfaceComponent, IHistorySurfaceComponent, IInitializeAfterAddedComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "textEditor";
        public static var ELEMENT_NAME:String = "TextEditor";
		
		[Embed(source='/assets/richTextThumbItems.png')]
		private var menuThumbnail: Class;
		[Embed(source='/assets/richTextMenuItem1.png')]
		private var menuOption1: Class;
		[Embed(source='/assets/richTextMenuItem2.png')]
		private var menuOption2: Class;
		
		private var hRule:HRule;
		private var menuGroup:Group;
		
        public function TextEditor()
        {
            super();

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
				"widgetVarChanged",
				"textChanged",
				"placeholderChanged",
				"styleChanged"
            ];
			
			backgroundFill = new SolidColor(0xFCFCFC);
			borderStroke = new SolidColorStroke(0xCCCCCC);
			
            var vLayout:VerticalLayout = new VerticalLayout();
			vLayout.gap = 0;
            layout = vLayout;
			
			width = minWidth = 110;
			height = minHeight = 80;
        }
		
		/**
		 * Excluded from ASDoc
		 */
		public function componentAddedToEditor():void
		{
			// update size
			width = (width == 110) ? 250 : width;
			height = (height == 80) ? 100 : height;
			minWidth = 120;
			
			// change/update styles
			backgroundFill = new SolidColor(0xFFFFFF);
			
			var tmpParentLayout:VerticalLayout = (menuGroup.parent as Group).layout as VerticalLayout;
			tmpParentLayout.paddingLeft = tmpParentLayout.paddingRight = 12;
			tmpParentLayout.paddingTop = tmpParentLayout.paddingBottom = 8;
			(menuGroup.parent as Group).layout = tmpParentLayout;
			
			menuGroup.minHeight = 24;
			
			_editor.setStyle("paddingLeft", 12);
			_editor.setStyle("paddingRight", 12);
			_editor.prompt = "Input Text";
			
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
		
		/**
		 * Excluded from ASDoc
		 */
		public function getComponentsChildren():OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, "TextEditor", null));
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
		
		[Exclude(name="isSelected", kind="property")]
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
		 * @example
		 * <strong>Visual Editor XML:</strong>
		 * <listing version="3.0">&lt;TextEditor value=""/&gt;</listing>
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
         * <listing version="3.0">&lt;ui:textEditor style="width:80%;"/&gt;</listing>
         */
        override public function get percentWidth():Number
        {
            return super.percentWidth;
        }

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>PrimeFaces: <strong>src</strong></p>
         *
         * @default "110"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;TextEditor width="110"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;ui:textEditor style="width:110px;height:110px;"/&gt;</listing>
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
         * <listing version="3.0">&lt;ui:textEditor style="height:80%;"/&gt;</listing>
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
         * @default "110"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;TextEditor height="110"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;ui:textEditor style="width:110px;height:110px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }
		
		private var _widgetVar:String = "";
		
		[Inspectable(category="General")]
		[Bindable("widgetVarChanged")]
		/**
		 * <p>PrimeFaces: <strong>value</strong></p>
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

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            setCommonXMLAttributes(xml);
			xml.@widgetVar = this.widgetVar;
			xml.@value = this.text;
			if (StringUtil.trim(this.placeholder).length != 0) xml.@placeholder = this.placeholder;
            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
			XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
			
			this.widgetVar = xml.@widgetVar;
			this.text = xml.@value;
			this.placeholder = xml.@placeholder;
			
			this.callLater(componentAddedToEditor);
        }

        public function toCode():XML
        {
			var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, PRIME_FACES_XML_ELEMENT_NAME) + "/>");
			var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
			xml.addNamespace(primeFacesNamespace);
			xml.setNamespace(primeFacesNamespace);
			
			XMLCodeUtils.addSizeHtmlStyleToXML(xml, this);
			
			xml.@widgetVar = this.widgetVar;
			xml.@value = this.text;
			if (StringUtil.trim(this.placeholder).length != 0) xml.@placeholder = this.placeholder;
			return xml;
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
				// unfortunately, flowlayout do not avail any
				// padding feature thus we contain the menuGroup
				// inside of another container having padding
				var menuGroupContainer:Group = new Group();
				menuGroupContainer.percentWidth = 100;
				menuGroupContainer.layout = new VerticalLayout();
				(menuGroupContainer.layout as VerticalLayout).paddingLeft = (menuGroupContainer.layout as VerticalLayout).paddingRight = 8;
				(menuGroupContainer.layout as VerticalLayout).paddingTop = (menuGroupContainer.layout as VerticalLayout).paddingBottom = 8;
				(menuGroupContainer.layout as VerticalLayout).verticalAlign = "middle";
				
				menuGroup = new Group();
				menuGroup.percentWidth = 100;
				menuGroup.minHeight = 16;
				menuGroup.layout = new FlowLayout();
				(menuGroup.layout as FlowLayout).verticalAlign = "middle";
				
				menuGroupContainer.addElement(menuGroup);
				addElement(menuGroupContainer);
				generateMenuImages();
				
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
			}
		}
		
		private function generateMenuImages(afterAdded:Boolean=false):void
		{
			var tmpImage:Image;
			if (!afterAdded)
			{
				tmpImage = new Image();
				tmpImage.source = new menuThumbnail();
				menuGroup.addElement(tmpImage);
			}
			else
			{
				// clear exisint menu option icon image 
				// and a bit more realistic ones
				menuGroup.removeAllElements();
				
				tmpImage = new Image();
				tmpImage.source = new menuOption1();
				menuGroup.addElement(tmpImage);
				tmpImage = new Image();
				tmpImage.source = new menuOption2();
				menuGroup.addElement(tmpImage);
			}
		}
    }
}