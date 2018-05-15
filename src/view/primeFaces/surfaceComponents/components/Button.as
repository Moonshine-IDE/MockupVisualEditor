package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import spark.components.Button;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.ButtonPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.ButtonSkin;
    import view.suportClasses.PropertyChangeReference;

    public class Button extends spark.components.Button implements IPrimeFacesSurfaceComponent, IHistorySurfaceComponent
	{
		public static const PRIME_FACES_XML_ELEMENT_NAME:String = "button";
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
					"toolTipChanged"
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
		
		public function restorePropertyOnChangeReference(nameField:String, value:*, eventType:String=null):void
		{
			this[nameField.toString()] = value;
		}

        private var _enabled:Boolean = true;

        [Bindable("enabledChanged")]
        [Inspectable(category="General", enumeration="true,false", defaultValue="true")]
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
		override public function set toolTip(value:String):void
		{
			if (super.toolTip != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "toolTip", super.toolTip, value);
				
				super.toolTip = value;
				dispatchEvent(new Event("toolTipChanged"));
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
			var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

			XMLCodeUtils.setSizeFromComponentToXML(this, xml);

			xml.@disabled = !this.enabled;
            xml.@value = this.label;
			xml.@title = this.toolTip;

			return xml;
		}

        public function fromXML(xml:XML, childFromXMLCallback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.enabled = xml.@disabled == "false" ? true : false;
            this.label = xml.@value;
            this.toolTip = xml.@title;
        }

		public function toCode():XML
		{
			var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

			xml.@disabled = !this.enabled;
            xml.@value = this.label;
			xml.@title = this.toolTip;

			return xml;
		}
	}
}