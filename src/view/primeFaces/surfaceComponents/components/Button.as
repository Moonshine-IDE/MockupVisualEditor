package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import spark.components.Button;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.ButtonPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.ButtonSkin;
    import view.suportClasses.PropertyChangeReference;

    [Exclude(name="propertyChangeFieldReference", kind="property")]
	[Exclude(name="actionListener", kind="property")]
	[Exclude(name="isCommandButton", kind="property")]
    [Exclude(name="isUpdating", kind="property")]

	[Exclude(name="propertiesChangedEvents", kind="property")]
	[Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]

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
    public class Button extends spark.components.Button implements IPrimeFacesSurfaceComponent, IHistorySurfaceComponent
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "button";
		public static const PRIME_FACES_XML_ELEMENT_NAME_COMMAND_BUTTON:String = "commandButton";
		public static const ELEMENT_NAME:String = "Button";
		
		public function Button()
		{
			super();

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
					"toolTipChanged",
					"isCommandButtonChanged",
					"actionListenerChanged"
			];
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
		
		private var _isCommandButton:Boolean;
		
		[Bindable("isCommandButtonChanged")]
		public function get isCommandButton():Boolean
		{
			return _isCommandButton;
		}
		
		public function set isCommandButton(value:Boolean):void
		{
			if (_isCommandButton != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "isCommandButton", _isCommandButton, value);
				
				_isCommandButton = value;
				dispatchEvent(new Event("isCommandButtonChanged"));
			}
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
         * <listing version="3.0">&lt;Button width="100"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
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
		 * <listing version="3.0">&lt;Button height="30"/&gt;</listing>
         * @example
		 * <strong>PrimeFaces:</strong>
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
         * <p>PrimeFaces: <strong>disabled</strong></p>
         *
         * @default "false"
		 * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Button disabled="false"/&gt;</listing>
         * @example
		 * <strong>PrimeFaces:</strong>
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
		 * <p>PrimeFaces: <strong>value</strong></p>
		 *
		 * @default "Button"
		 *
		 * @example
         * <strong>Visual Editor:</strong>
         * <listing version="3.0">&lt;Button value="Button"/&gt;</listing>
		 * @example
		 * <strong>PrimeFaces:</strong>
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
		
		[Bindable("toolTipChanged")]
        /**
		 * <p>PrimeFaces: <strong>title</strong></p>
         *
		 * @example
         * <strong>Visual Editor:</strong>
         * <listing version="3.0">&lt;Button title=""/&gt;</listing>
		 *
         * @example
		 * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:button title=""/&gt;</listing>
         */
		override public function set toolTip(value:String):void
		{
			if (super.toolTip != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "toolTip", super.toolTip, value);
				
				super.toolTip = value;
				dispatchEvent(new Event("toolTipChanged"));
			}
		}
		
		private var _actionListener:String;
		
		[Bindable("actionListenerChanged")]
		public function get actionListener():String
		{
			return _actionListener;
		}
		
		public function set actionListener(value:String):void
		{
			if (_actionListener != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "actionListener", _actionListener, value);
				
				_actionListener = value;
				dispatchEvent(new Event("actionListenerChanged"));
			}
		}

        public function get propertyEditorClass():Class
		{
			return ButtonPropertyEditor;
		}		
		
		private var _propertiesChangedEvents:Array;
		public function get propertiesChangedEvents():Array
		{
			return _propertiesChangedEvents;
		}
		
		public function toXML():XML
		{
			var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, ELEMENT_NAME) + "/>");

			XMLCodeUtils.setSizeFromComponentToXML(this, xml);

			xml.@disabled = !this.enabled;
            xml.@value = this.label;
			xml.@title = this.toolTip;
			xml.@isCommandButton = this.isCommandButton.toString();
			xml.@actionListener = this.isCommandButton ? this.actionListener : "";

			return xml;
		}

        public function fromXML(xml:XML, childFromXMLCallback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.enabled = xml.@disabled == "false" ? true : false;
			this.isCommandButton = xml.@isCommandButton == "true" ? true : false;
            this.label = xml.@value;
            this.toolTip = xml.@title;
			this.actionListener = xml.@actionListener;
        }

		public function toCode():XML
		{
			var tagFace:String = isCommandButton ? PRIME_FACES_XML_ELEMENT_NAME_COMMAND_BUTTON : PRIME_FACES_XML_ELEMENT_NAME;
			var xml:XML = new XML("<" + MxmlCodeUtils.getMXMLTagNameWithSelection(this, tagFace) + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

			xml.@disabled = !this.enabled;
            xml.@value = this.label;
			xml.@title = this.toolTip;
			if (isCommandButton) xml.@actionListener = this.actionListener;

			return xml;
		}
	}
}