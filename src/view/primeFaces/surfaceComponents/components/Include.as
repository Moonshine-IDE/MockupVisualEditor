package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import mx.events.CollectionEvent;
    import mx.events.CollectionEventKind;
    import mx.graphics.SolidColor;
    
    import spark.components.BorderContainer;
    import spark.components.Button;
    import spark.components.Label;
    import spark.layouts.VerticalLayout;
    
    import utils.MoonshineBridgeUtils;
    import utils.XMLCodeUtils;
    
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IInitializeAfterAddedComponent;
    import view.interfaces.IPrimeFacesSurfaceComponent;
    import view.primeFaces.propertyEditors.IncludePropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.events.SurfaceComponentEvent;

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

    /**
     * <p>Representation of PrimeFaces include component.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;Include
     * <b>Attributes</b>
     * width="110"
     * height="110"
     * src=""/&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;ui:include
     * <b>Attributes</b>
     * style="width:110px;height:110px;"
     * src=""/&gt;
     * </pre>
     */
    public class Include extends BorderContainer implements IPrimeFacesSurfaceComponent, IHistorySurfaceComponent, IInitializeAfterAddedComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "include";
        public static var ELEMENT_NAME:String = "Include";
		
		private var includeLabel:Label;
		private var includeButton:spark.components.Button;
		
        public function Include()
        {
            super();

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "pathChanged"
            ];
			
			backgroundFill = new SolidColor(0xFCFCFC);
			
            var vLayout:VerticalLayout = new VerticalLayout();
			vLayout.horizontalAlign = "center";
			vLayout.verticalAlign = "middle";
			vLayout.gap = 10;
            layout = vLayout;
			
			toolTip = "";
			width = 110;
			height = 110;
        }
		
		public function componentAddedToEditor():void
		{
			// central repository to use in different Include property editor components
			// at same time 
			MoonshineBridgeUtils.moonshineBridge.getXhtmlFileUpdates(MoonshineBridgeUtils.onXHtmlFilesUpdated);
			MoonshineBridgeUtils.filesList.addEventListener(CollectionEvent.COLLECTION_CHANGE, onFileListUpdated, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onIncludeRemoved);
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

        public function get propertyEditorClass():Class
        {
            return IncludePropertyEditor;
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
         * <listing version="3.0">&lt;Include width="110"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;ui:include style="width:110px;height:110px;"/&gt;</listing>
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
         * @default "110"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Include height="110"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;ui:include style="width:110px;height:110px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        private var _path:String;
		private var pathChanged:Boolean;

		[Bindable("pathChanged")]
        /**
         * <p>PrimeFaces: <strong>src</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Include src=""/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;ui:include src=""/&gt;</listing>
         */
        public function get path():String
        {
            return _path;
        }

        public function set path(value:String):void
        {
			if (!value) return;

            if (_path != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "path", _path, value);

                _path = value;
                pathChanged = true;

                this.invalidateProperties();
                dispatchEvent(new Event("pathChanged"));
            }
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
			xml.@src = this.path;
            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
			XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
			
			this.path = xml.@src;
			
			componentAddedToEditor();
        }

        public function toCode():XML
        {
			var xml:XML = new XML("<" + PRIME_FACES_XML_ELEMENT_NAME + "/>");
			var primeFacesNamespace:Namespace = new Namespace("ui", "http://xmlns.jcp.org/jsf/facelets");
			xml.addNamespace(primeFacesNamespace);
			xml.setNamespace(primeFacesNamespace);
			
			XMLCodeUtils.addSizeHtmlStyleToXML(xml, this.width, this.height, this.percentWidth, this.percentHeight);
			
			xml.@src = this.path;
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
			
			if (!includeLabel)
			{
				includeLabel = new Label();
				includeLabel.maxDisplayedLines = 2;
				includeLabel.showTruncationTip = true;
				includeLabel.percentWidth = 90;
				includeLabel.text = "File Name";
				includeLabel.setStyle("textAlign", "center");
				includeLabel.setStyle("fontSize", 12);
				includeLabel.setStyle("fontWeight", "bold");
				includeLabel.setStyle("textDecoration", "underline");
				addElement(includeLabel);
				
				includeButton = new spark.components.Button();
				includeButton.label = "Open in editor";
				includeButton.addEventListener(MouseEvent.CLICK, onIncludeButtonClicked, false, 0, true);
				addElement(includeButton);
			}
		}

        override protected function commitProperties():void
        {
            if (pathChanged)
            {
                includeLabel.text = this.path;
                pathChanged = false;
            }

            super.commitProperties();
        }

        private function onIncludeButtonClicked(event:MouseEvent):void
		{
			MoonshineBridgeUtils.moonshineBridge.openXhtmlFile(path);
		}
		
		private function onFileListUpdated(event:CollectionEvent):void
		{
			if (event.kind == CollectionEventKind.REMOVE && event.items[0].resourcePathWithoutRoot == this.path)
			{
				path = (MoonshineBridgeUtils.filesList.length != 0) ? MoonshineBridgeUtils.filesList[0].resourcePathWithoutRoot : "Undefined";
			}
		}
		
		private function onIncludeRemoved(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onIncludeRemoved);
			MoonshineBridgeUtils.filesList.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onFileListUpdated);
		}
    }
}
