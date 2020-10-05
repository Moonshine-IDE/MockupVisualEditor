package view.domino.surfaceComponents.components
{
    import flash.events.Event;

    import interfaces.IComponentPercentSizeOutput;

    import view.interfaces.IMainApplication;
    import view.interfaces.INonDeletableSurfaceComponent;

    import view.domino.propertyEditors.WindowPropertyEditor;
    import view.primeFaces.surfaceComponents.components.Div;
    import view.global.Globals;
    import mx.controls.Alert;
    import mx.collections.ArrayList;
    import utils.StringHelper;

    [Exclude(name="toXML", kind="method")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="updateDisplayList", kind="method")]
    [Exclude(name="widthPercent", kind="property")]
    [Exclude(name="heightPercent", kind="property")]
    [Exclude(name="webqueryopenChanged", kind="property")]
    [Exclude(name="webquerysaveChanged", kind="property")]
    [Exclude(name="formpropertyChanged", kind="property")]
    

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


        [Bindable]
        private var _formpropertys:ArrayList = new ArrayList([
       // {label:"Windows Title",value: "windowtitle",description:"Generates the text that appears in the title bar of documents using the form."},
        {label:"Web QueryOpen",value: "webqueryopen",description:"Executes before a Web document is displayed."},
        {label:"Web Querysave",value: "webquerysave",description:"Executes before a Web document is saved."},
        //{label:"Hide When",value: "hidewhen",description:"Hides the object if the formula you provide is true."},
        //{label:"Value",value: "value",description:"Specifies the contents of a computed field."},
        // {label:"Selection",value: "selection",description:"selects the documents that appear in a view."},
        // {label:"Html Attributes",value: "htmlattributes",description:"Specifies characteristics for the associated HTML object. Applies to fields."},
        // {label:"Html Head",value: "htmlhead",description:"Information that resides in the HTML Head tag for an object. Applies to forms and pages."},
        // {label:"Html Body",value: "htmlbody",description:"Information that resides in the HTML Body tag for an object. Applies to forms and pages."},
        // {label:"Target Frame",value: "targetframe",description:"Defines which frame in a frameset the result of a command should display in."},
        // {label:"Help Request",value: "helprequest",description:"Executes when Help is selected."},
        // {label:"Form",value: "form",description:"Defines which form to open from a view."},
        // {label:"Alternate Html",value: "alternatehtml",description:"Alternate text to display if the user's browser cannot execute the code. For example, if a Java applet cannot be run by the user's browser, this text would describe the applet and inform the user that their browser's capabilities do not support it."},
        // {label:"Form",value: "form",description:"Defines which form to open from a view."},
        // {label:"Showsinglecategory",value: "showsinglecategory",description:"In embedded views, limits the documents displayed in the view to those contained in one category. The category is defined by a formula or text."},
        // {label:"Label",value: "label",description:"Specifies the label to display on an action button."},
        //{label:"Displayvalue",value: "displayvalue",description:"Determines the value that displays for an action checkbox."},


           

         
        ]);

        public function get formpropertys():ArrayList
        {
            return _formpropertys;
        }

        private var _formproperty:String = "webqueryopen";
        public function get formproperty():String
        {
            return _formproperty;
        }

        public function set formproperty(value:String):void
        {
            if (_formproperty != value)
            {
                _formproperty = value;
                dispatchEvent(new Event("formpropertyChanged"));
            }
        }
        

        [Bindable("webqueryopenChanged")]
        private var _webqueryopen:String = "";
        public function get webqueryopen():String
        {
            return _webqueryopen;
        }

        public function set webqueryopen(value:String):void
        {
            if (_webqueryopen != value)
            {
                _webqueryopen = value;
                dispatchEvent(new Event("webqueryopenChanged"));
            }
        }


        [Bindable("webquerysaveChanged")]
        private var _webquerysave:String = "";
        public function get webquerysave():String
        {
            return _webquerysave;
        }

        public function set webquerysave(value:String):void
        {
            if (_webquerysave != value)
            {
                _webquerysave = value;
                dispatchEvent(new Event("webquerysaveChanged"));
            }
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
            if(this.webquerysave){
                 var encodeFormulaStr:String= StringHelper.base64Encode(this.webquerysave);
                 mainXML.@webquerysave=encodeFormulaStr;
            }

            if(this.webqueryopen){
                 var encodeFormulaStr:String= StringHelper.base64Encode(this.webqueryopen);
                 mainXML.@webqueryopen=encodeFormulaStr
            }

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

        override public function fromXML(xml:XML, callback:Function):void
        {
            //Alert.show("fromXML:"+xml.@title);
            if(xml.@title){
                this.title = xml.@title
            }

            if(xml.@webqueryopen){
                this.webqueryopen=  StringHelper.base64Decode(xml.@webqueryopen);
            }

            if(xml.@webquerysave){
                this.webquerysave= StringHelper.base64Decode(xml.@webquerysave);
            }
            super.fromXML(xml, callback);

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