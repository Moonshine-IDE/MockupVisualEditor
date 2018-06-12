package view.primeFaces.surfaceComponents.components
{
    import flash.events.Event;

    import view.interfaces.IMainApplication;
    import view.interfaces.INonDeletableSurfaceComponent;
    import view.primeFaces.propertyEditors.WindowPropertyEditor;

    [Exclude(name="toXML", kind="method")]
    [Exclude(name="propertyEditorClass", kind="property")]

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
     * class="flexHorizontalLayoutWrap flexHorizontalLayoutLeft flexHorizontalLayoutTop"/&gt;
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
    public class MainApplication extends Div implements INonDeletableSurfaceComponent, IMainApplication
	{
		public static const ELEMENT_NAME:String = "MainApplication";

		public function MainApplication()
		{
			super();

			this.setStyle("backgroundColor", "#FCFCFC");
		}

        override public function get propertyEditorClass():Class
        {
            return WindowPropertyEditor;
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
            return super.width;
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

            return super.internalToXML();
        }
    }
}