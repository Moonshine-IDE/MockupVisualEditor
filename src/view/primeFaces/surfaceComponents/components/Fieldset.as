package view.primeFaces.surfaceComponents.components
{
    import components.CollapsiblePanel;
    import components.primeFaces.Fieldset;

    import data.OrganizerItem;

    import flash.events.Event;
    import flash.events.MouseEvent;

	import interfaces.ILookup;

	import interfaces.components.IFieldset;

    import mx.core.IVisualElement;
    import mx.events.FlexEvent;

    import spark.components.HGroup;

    import utils.XMLCodeUtils;

    import view.interfaces.IDiv;
    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IInitializeAfterAddedComponent;
    import view.interfaces.IGetChildrenSurfaceComponent;
    import view.primeFaces.propertyEditors.FieldsetPropertyEditor;
    import view.primeFaces.surfaceComponents.skins.FieldsetSkin;
    import view.suportClasses.PropertyChangeReference;
    import view.suportClasses.events.SurfaceComponentEvent;

    /**
     * The icon designating a "closed" state
     */
    [Style(name="closedIcon", type="Object")]

    /**
     * The icon designating an "open" state
     */
    [Style(name="openIcon", type="Object")]

    [Exclude(name="closedIcon", kind="style")]
    [Exclude(name="openIcon", kind="style")]
    [Exclude(name="closeIcon", kind="property")]
    [Exclude(name="openIcon", kind="property")]
    [Exclude(name="addElement", kind="method")]
    [Exclude(name="removeElement", kind="method")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="onCollapsiblePanelCreationComplete", kind="method")]
    [Exclude(name="updateIsUpdating", kind="method")]

    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="div", kind="property")]
    [Exclude(name="updatePropertyChangeReference", kind="method")]
    [Exclude(name="componentAddedToEditor", kind="method")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]

    /**
     * <p>Representation of PrimeFaces fieldset component.</p>
     * <p>Fieldset component is generated with div inside where children are positioned using FlexBox</p>
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;Fieldset
     * <b>Attributes</b>
     * width="110"
     * height="120"
     * toggleable="false"
     * legend="Basic"
     * toggleSpeed="200"&gt;
     *  &lt;Div percentWidth="100" percentHeight="100"
     *          class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"
     *          wrap="false"/&gt;
     * &lt;/Fieldset&gt;
     * </pre>
     *
     * <strong>PrimeFaces output:</strong>
     * <pre>
     * &lt;p:fieldset
     * <b>Attributes</b>
     * style="width:110px;height:120px;"
     * toggleable="false"
     * legend="Basic"
     * toggleSpeed="200"
     *  &lt;div style="width:100%;height:100%;"
     *          class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;
     * &lt;/p:fieldset&gt;
     * </pre>
     */
    public class Fieldset extends CollapsiblePanel implements IGetChildrenSurfaceComponent, IDiv, IHistorySurfaceComponent, IInitializeAfterAddedComponent
    {
        public static const PRIME_FACES_XML_ELEMENT_NAME:String = "fieldset";
        public static const ELEMENT_NAME:String = "Fieldset";

        [Embed(source='/assets/minus_close.png')]
        public var closeIcon:Class;

        [Embed(source='/assets/plus_open.png')]
        public var openIcon:Class;
		
		private var component:IFieldset;
		
        public function Fieldset(isOpen:Boolean = true)
        {
            super(isOpen);
			
			component = new components.primeFaces.Fieldset(this);
			
            this.width = 110;
            this.height = 120;
            this.minHeight = 120;
            this.isCollapsible = false;

            this.setStyle("closedIcon", closeIcon);
            this.setStyle("openIcon", openIcon);
            this.setStyle("skinClass", FieldsetSkin);
            this.setStyle("dropShadowVisible", false);
            this.setStyle("borderColor", "#a8a8a8");

            this.title = "Basic";

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "toggleableChanged",
				"titleChanged",
				"durationChanged",
				"openChanged"
            ];
        }
		
		public function componentAddedToEditor():void
		{
            this.addEventListener(Event.REMOVED_FROM_STAGE, onFieldsetRemoved);
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

        public function get propertyEditorClass():Class
        {
            return FieldsetPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;

        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        private var _isUpdating:Boolean;
		public function get isUpdating():Boolean
		{
			return _isUpdating;
		}
		
		public function set isUpdating(value:Boolean):void
		{
			if (!isAnimationPlaying) _isUpdating = value;
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

        [SkinPart(required="true")]
        /**
         * @private
         */
        public var titleGroup:HGroup;

        private var _div:Div;
        public function get div():Div
        {
            return _div;
        }

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @default "110"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Fieldset width="110"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:fieldset style="width:110px;height:120px;"/&gt;</listing>
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
         * @default "120"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Fieldset height="120"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:fieldset style="width:110px;height:120px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        private var _toggleable:Boolean;
        private var toggleableChanged:Boolean;

        [Bindable(event="toggleableChanged")]
        /**
         * <p>PrimeFaces: <strong>toggleable</strong></p>
         *
         * @default "false"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Fieldset toggleable="false"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:fieldset toggleable="false"/&gt;</listing>
         */
        public function get toggleable():Boolean
        {
            return _toggleable;
        }

        public function set toggleable(value:Boolean):void
        {
            if (_toggleable != value)
            {
                _propertyChangeFieldReference = new PropertyChangeReference(this, "toggleable", _toggleable, value);

                this.isCollapsible = value;
                _toggleable = value;
                toggleableChanged = true;
                dispatchEvent(new Event("toggleableChanged"));

                this.invalidateSkinState();
            }
        }

        /**
         * <p>PrimeFaces: <strong>legend</strong></p>
         *
         * @default "Basic"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Fieldset legend="Basic"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:fieldset legend="Basic"/&gt;</listing>
         */
		override public function set title(value:String):void
		{
			if (title != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "title", super.title, value);
				
				super.title = value;
				dispatchEvent(new Event("titleChanged"));
			}
		}

        [Inspectable(defaultValue="200")]
        [Bindable(event="durationChanged")]
        /**
         * <p>PrimeFaces: <strong>toggleSpeed</strong></p>
         *
         * @default "200"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;Fieldset toggleSpeed="200"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;p:fieldset toggleSpeed="200"/&gt;</listing>
         */
        override public function get duration():Number
        {
            return super.duration;
        }

        override protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
        {
            _propertyChangeFieldReference = new PropertyChangeReference(this, fieldName, oldValue, newValue);
        }

        override protected function updateIsUpdating(value:Boolean):void
        {
            isUpdating = value;
        }

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME + "/>");

            XMLCodeUtils.setSizeFromComponentToXML(this, xml);

            if (cdataXML)
            {
                xml.appendChild(cdataXML);
            }

            xml.@legend = this.title;
            xml.@toggleable = this.toggleable;
            xml.@toggleSpeed = this.duration;

            var elementCount:int = this.numElements;
            for(var i:int = 0; i < elementCount; i++)
            {
                var element:IGetChildrenSurfaceComponent = this.getElementAt(i) as IGetChildrenSurfaceComponent;
                if(element === null)
                {
                    continue;
                }
                xml.appendChild(element.toXML());
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function, lookup:ILookup = null):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);

            _cdataXML = XMLCodeUtils.getCdataXML(xml);
            _cdataInformation = XMLCodeUtils.getCdataInformationFromXML(xml);

            this.ensureInternalDivIsAdded();

            component.fromXML(xml, callback, lookup);
			
			this.title = component.title;
			this.toggleable = component.toggleable;
			this.duration = component.duration;

			componentAddedToEditor();
        }

        public function toCode():XML
        {
            //In my opinion this is ans issue in PrimeFaces. If I add height to Fieldset and it's toggleable it doesn't work.
            component.title = this.title;
            component.toggleable = this.toggleable;
            component.duration = this.duration;

			component.isSelected = this.isSelected;
			(component as components.primeFaces.Fieldset).width = this.width;
			(component as components.primeFaces.Fieldset).height = this.width;
			(component as components.primeFaces.Fieldset).percentWidth = this.percentWidth;
			(component as components.primeFaces.Fieldset).percentHeight = this.percentHeight;

            return component.toCode();
        }
        public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
        public function toRora():XML
        {
            return null;
        }
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			var organizerItem:OrganizerItem;
			var element:IGetChildrenSurfaceComponent = this.getElementAt(0) as IGetChildrenSurfaceComponent;
			
			organizerItem = element.getComponentsChildren();
			organizerItem.name = ELEMENT_NAME;
			
			return organizerItem;
		}

        override protected function onCollapsiblePanelCreationComplete(event:FlexEvent):void
        {
            super.onCollapsiblePanelCreationComplete(event);

            titleDisplay.removeEventListener(MouseEvent.CLICK, onTitleDisplayClick);

            this.ensureInternalDivIsAdded();
        }

        override protected function commitProperties():void
        {
            super.commitProperties();

            if (toggleableChanged)
            {
                if (toggleable)
                {
                    titleGroup.addEventListener(MouseEvent.CLICK, onTitleDisplayClick);
                }
                else
                {
                    titleGroup.removeEventListener(MouseEvent.CLICK, onTitleDisplayClick);
                }
                toggleableChanged = false;

                this.measuredHeight = this.height;
            }
        }

        private function onFieldsetRemoved(event:Event):void
        {
            this.removeEventListener(Event.REMOVED_FROM_STAGE, onFieldsetRemoved);

            dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentRemoved, [this.div]));
        }

        private function ensureInternalDivIsAdded():void
        {
            if (!_div)
            {
                _div = new Div();
                super.addElement(this.div);
                dispatchEvent(new SurfaceComponentEvent(SurfaceComponentEvent.ComponentAdded, [this.div]));
				if (this.enabled) hookDivEventBypassing();

                this.div.percentWidth = this.div.percentHeight = 100;
                this.div.setStyle("borderVisible", false);
            }
        }
		
		private function hookDivEventBypassing():void
		{
			var propertiesChangedEventsCount:int = _div.propertiesChangedEvents.length;
			for(var i:int = 0; i < propertiesChangedEventsCount; i++)
			{
				if ((_div.propertiesChangedEvents[i] as String).toLowerCase().indexOf("width") == -1 && (_div.propertiesChangedEvents[i] as String).toLowerCase().indexOf("height") == -1) 
				{
					_propertiesChangedEvents.push(_div.propertiesChangedEvents[i]);
				}
			}
		}

        override public function addElement(element:IVisualElement):IVisualElement
        {
            if (this.div)
            {
                return this.div.addElement(element);
            }
            else
            {
                return super.addElement(element);
            }
        }

        override public function removeElement(element:IVisualElement):IVisualElement
        {
            if (this.div)
            {
                return this.div.removeElement(element);
            }
            else
            {
                return super.removeElement(element);
            }
        }
    }
}
