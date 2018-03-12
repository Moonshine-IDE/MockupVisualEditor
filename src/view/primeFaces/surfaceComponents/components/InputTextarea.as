package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    
    import mx.utils.StringUtil;
    
    import spark.components.TextArea;
    
    import utils.XMLCodeUtils;
    
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.InputTextareaPropertyEditor;

    public class InputTextarea extends TextArea implements IPrimeFacesSurfaceComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "inputTextarea";
        public static const ELEMENT_NAME:String = "inputTextarea";

        public function InputTextarea()
        {
            super();

            this.mouseChildren = false;
            this.toolTip = "";
            this.width = 100;
			this.height = 60;
            this.minWidth = 20;
			this.minHeight = 40;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "textChanged",
				"change"
            ];
			
			this.prompt = "Input Text Area";
        }

        private var _isAutoResize:Boolean;
        public function get isAutoResize():Boolean
        {
            return _isAutoResize;
        }
        public function set isAutoResize(value:Boolean):void
        {
			if (_isAutoResize != value)
			{
				dispatchEvent(new Event("change"));
				_isAutoResize = value;
			}
        }

		private var _isQueryDisplay:Boolean;
		[Bindable(event="change")]
		public function get isQueryDisplay():Boolean
		{
			return _isQueryDisplay;
		}
		public function set isQueryDisplay(value:Boolean):void
		{
			if (_isQueryDisplay != value)
			{
				_isQueryDisplay = value;
				dispatchEvent(new Event("change"));
			}
		}
		
		private var _isCounterDisplay:Boolean;
		[Bindable(event="change")]
		public function get isCounterDisplay():Boolean
		{
			return _isCounterDisplay;
		}
		public function set isCounterDisplay(value:Boolean):void
		{
			if (_isCounterDisplay != value)
			{
				_isCounterDisplay = value;
				dispatchEvent(new Event("change"));
			}
		}
		
		private var _queryFileName:String = "";
		public function get queryFileName():String
		{
			return _queryFileName;
		}
		public function set queryFileName(value:String):void
		{
			if (_queryFileName != value)
			{
				_queryFileName = value;
				dispatchEvent(new Event("change"));
			}
		}
		
		private var _queryFieldName:String = "";
		public function get queryFieldName():String
		{
			return _queryFieldName;
		}
		public function set queryFieldName(value:String):void
		{
			if (_queryFieldName != value)
			{
				_queryFieldName = value;
				dispatchEvent(new Event("change"));
			}
		}
		
		private var _queryDelay:int = 750;
		public function get queryDelay():int
		{
			return _queryDelay;
		}
		public function set queryDelay(value:int):void
		{
			if (_queryDelay != value)
			{
				_queryDelay = value;
				dispatchEvent(new Event("change"));
			}
		}
		
		private var _minQueryLength:int = 4;
		public function get minQueryLength():int
		{
			return _minQueryLength;
		}
		public function set minQueryLength(value:int):void
		{
			if (_minQueryLength != value)
			{
				_minQueryLength = value;
				dispatchEvent(new Event("change"));
			}
		}
		
		private var _counter:String;
		public function get counter():String
		{
			return _counter;
		}
		public function set counter(value:String):void
		{
			if (_counter != value)
			{
				_counter = value;
				dispatchEvent(new Event("change"));
			}
		}
		
		private var _counterTemplate:String = "{0} characters remaining.";
		public function get counterTemplate():String
		{
			return _counterTemplate;
		}
		public function set counterTemplate(value:String):void
		{
			if (_counterTemplate != value)
			{
				_counterTemplate = value;
				dispatchEvent(new Event("change"));
			}
		}
		
		private var _maxLength:int = 100;
		[Bindable(event="change")] public function get maxLength():int
		{
			return _maxLength;
		}
		public function set maxLength(value:int):void
		{
			if (_maxLength != value)
			{
				_maxLength = value;
				dispatchEvent(new Event("change"));
			}
		}

        public function get propertyEditorClass():Class
        {
            return InputTextareaPropertyEditor;
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

            xml.@value = this.text;
            xml.@isAutoResize = this.isAutoResize;
			xml.@isQueryDisplay = this.isQueryDisplay;
			xml.@isCounterDisplay = this.isCounterDisplay;
			if (isQueryDisplay)
			{
				xml.@queryDelay = this.queryDelay.toString();
				xml.@minQueryLength = this.minQueryLength.toString();
				xml.@completeMethod = "#{"+ this.queryFileName +"."+ this.queryFieldName +"}";
			}
			if (isCounterDisplay)
			{
				xml.@maxlength = this.maxLength.toString();
				xml.@counterTemplate = this.counterTemplate;
				if (StringUtil.trim(counter).length != 0) xml.@counter = this.counter;
			}

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            this.text = xml.@value;
            this.isAutoResize = xml.@isAutoResize;
            if (String(xml.@isQueryDisplay) == "true")
			{
				this.isQueryDisplay = true;
				this.queryDelay = int(xml.@queryDelay);
				this.minQueryLength = int(xml.@minQueryLength);
				
				var tmpSubstr:String = String(xml.@completeMethod);
				tmpSubstr = tmpSubstr.substring(2, tmpSubstr.length-1);
				var tmpSplit:Array = tmpSubstr.split(".");
				this.queryFileName = tmpSplit[0];
				this.queryFieldName = tmpSplit[1];
			}
			if (String(xml.@isCounterDisplay) == "true")
			{
				this.isCounterDisplay = true;
				this.maxLength = int(xml.@maxlength);
				this.counterTemplate = String(xml.@counterTemplate);
				if (xml.@counter != undefined) this.counter = String(xml.@counter);
			}
        }

        public function toCode():XML
        {
            var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
            var primeFacesNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
            xml.addNamespace(primeFacesNamespace);
            xml.setNamespace(primeFacesNamespace);

            XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);

            xml.@value = this.text;
            if (isAutoResize) xml.@autoResize = this.isAutoResize.toString();
			if (isQueryDisplay)
			{
	            xml.@queryDelay = this.queryDelay.toString();
				xml.@minQueryLength = this.minQueryLength.toString();
				xml.@completeMethod = "#{"+ this.queryFileName +"."+ this.queryFieldName +"}";
			}
			if (isCounterDisplay)
			{
				xml.@maxlength = this.maxLength.toString();
				xml.@counterTemplate = this.counterTemplate;
				if (StringUtil.trim(counter).length != 0) xml.@counter = this.counter;
			}

            return xml;
        }
    }
}
