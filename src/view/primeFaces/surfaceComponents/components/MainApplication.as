package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import interfaces.IComponentPercentSizeOutput;
    import interfaces.ILookup;
    import interfaces.ISurface;

    import view.interfaces.IMainApplication;
    import view.interfaces.INonDeletableSurfaceComponent;

    import view.primeFaces.propertyEditors.WindowPropertyEditor;

    import view.global.Globals;
    import mx.controls.Alert;

    [Exclude(name="toXML", kind="method")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="updateDisplayList", kind="method")]
    [Exclude(name="widthPercent", kind="property")]
    [Exclude(name="heightPercent", kind="property")]

    /**
     * <p>Representation of index.html file.</p>
     *
     * <strong>Visual Editor XML:</strong>
     * <pre>
     * &lt;MainApplication
     * <b>Attributes</b>
     * width="700"
     * height="450"
     * title=""
     * wrap=""
     * class="flexHorizontalLayoutWrap flexHorizontalLayoutLeft flexHorizontalLayoutTop"&gt;
     *  &lt;Script&gt;
     *      &lt;![CDATA[ Some information ]]&gt;
     *  &lt;/Script&gt;
     * &lt;/MainApplication&gt;
     * </pre>
     *
     * <strong>HTML output:</strong>
     * <pre>
     *  &lt;?xml version="1.0" encoding="utf-8"?&gt;
     *  &lt;html xmlns="http://www.w3.org/1999/xhtml"
     *        xmlns:h="http://xmlns.jcp.org/jsf/html"
     *        xmlns:ui="http://xmlns.jcp.org/jsf/facelets"
     *        xmlns:p="http://primefaces.org/ui"&gt;
     *  &lt;h:head&gt;
     *      &lt;link rel="stylesheet" type="text/css" href="resources/moonshine-layout-styles.css"/&gt;
     *      &lt;title/&gt;
     *  &lt;/h:head&gt;
     *  &lt;h:body&gt;
     *      &lt;div class="flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop"
     *           style="width:700px;height:450px;"/&gt;
     *  &lt;/h:body&gt;
     *  &lt;/html&gt;
     * </pre>
     */
    public class MainApplication extends Div implements INonDeletableSurfaceComponent, IMainApplication, IComponentPercentSizeOutput
	{
		public static const ELEMENT_NAME:String = "MainApplication";


       
         public function setDominoProject(value:Boolean):void 
        {
            //super.isDomino= value;
            Alert.show("setDomino:");
        }
        

		public function MainApplication()
		{
			super();

			this.setStyle("backgroundColor", "#FCFCFC");

            Globals.MainApplicationWidth=super.width;
		}

        override public function get propertyEditorClass():Class
        {
            return WindowPropertyEditor;
        }

        private var _widthPercent:Number;

        public function get widthPercent():Number
        {
            return _widthPercent;
        }

        private var  _heightPercent:Number;

        public function get heightPercent():Number
        {
            return _heightPercent;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;MainApplication percentWidth="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:80%;"/&gt;</listing>
         */
        override public function get percentWidth():Number
        {
            return super.percentWidth;
        }

        override public function set percentWidth(value:Number):void
        {
            if (isNaN(value))
            {
                if (super.percentWidth != value)
                {
                    _widthPercent = super.percentWidth;
                }
            }
            else
            {
                _widthPercent = Number.NaN;
            }

            super.percentWidth = value;
        }

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>PrimeFaces: <strong>none</strong></p>
         *
         * @default "700"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;MainApplication width="700"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:700px;height:450px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            Globals.MainApplicationWidth=super.width;
            return super.width;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>PrimeFaces: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;MainApplication percentHeight="80"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="height:80%;"/&gt;</listing>
         */
        override public function get percentHeight():Number
        {
            return super.percentHeight;
        }

        override public function set percentHeight(value:Number):void
        {
            if (isNaN(value))
            {
                if (super.percentHeight != value)
                {
                    _heightPercent = super.percentHeight;
                }
            }
            else
            {
                _heightPercent = Number.NaN;
            }

            super.percentHeight = value;
        }

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>PrimeFaces: <strong>none</strong></p>
         *
         * @default "450"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;MainApplication height="450"/&gt;</listing>
         * @example
         * <strong>PrimeFaces:</strong>
         * <listing version="3.0">&lt;div style="width:700px;height:450px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        

        private var _title:String = "";

        /**
         * <p>PrimeFaces: <strong>none</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;MainApplication title=""/&gt;</listing>
         * @example
         * <strong>HTML:</strong>
         * <listing version="3.0">&lt;title&gt;&lt;/title&gt;</listing>
         */
         public function get title():String
        {
            return _title;
        }

         public function set title(value:String):void
        {
            if (_title != value)
            {
                _title = value;
                dispatchEvent(new Event("titleChanged"));
            }
        }

        override public function toXML():XML
        {
            mainXML = new XML("<MainApplication/>");

            mainXML.@title = this.title;

            mainXML = super.internalToXML();

            Globals.MainApplicationWidth=super.width;

            if (isNaN(this.percentWidth) && !isNaN(this.widthPercent))
            {
                delete mainXML.@width;
                mainXML.@percentWidth = this.widthPercent;
            }

            if (isNaN(this.percentHeight) && !isNaN(this.heightPercent))
            {
                delete mainXML.@height;
                mainXML.@percentHeight = this.heightPercent;
            }

            return mainXML;
        }

        override public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
            var localSurface:ISurface = surface;

            super.fromXML(xml, callback, localSurface, lookup);

            contentChanged = true;
            this.invalidateDisplayList();
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);

            if (contentChanged)
            {
                callLater(resetPercentWidthHeightBasedOnLayout);
                contentChanged = false;
            }
        }

        override protected function commitProperties():void
        {
            var resetWidthPercent:Boolean = false;
            if (this.widthOutputChanged)
            {
                resetWidthPercent = true;
            }

            var resetHeightPercent:Boolean = false;
            if (this.heightOutputChanged)
            {
                resetHeightPercent = true;
            }

            super.commitProperties();

            if (resetWidthPercent)
            {
                this._widthPercent = Number.NaN;
            }

            if (resetHeightPercent)
            {
                this._heightPercent = Number.NaN;
            }
        }
    }
}