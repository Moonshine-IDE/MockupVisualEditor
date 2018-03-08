package utils
{
    import mx.core.IUIComponent;
    import mx.core.UIComponent;

    public class XMLCodeUtils
    {

        public static function addSizeHtmlStyleToXML(xml:XML, width:Number, height:Number,
                                                percentWidth:Number, percentHeight:Number):void
        {
            var styleDiv:String = xml.@style;
            if (!isNaN(percentWidth))
            {
                styleDiv += "width:" + String(percentWidth) + "%;";
            }
            else if (!isNaN(width))
            {
                styleDiv += "width:" + String(width) + "px;";
            }

            if (!isNaN(percentHeight))
            {
                styleDiv += "height:" + String(percentHeight) + "%;";
            }
            else if (!isNaN(height))
            {
                styleDiv += "height:" + String(height) + "px;";
            }

            xml.@style += styleDiv;
        }

        public static function setSizeFromComponentToXML(component:IUIComponent, xml:XML):void
        {
            if (!isNaN(component.percentWidth))
            {
                xml.@percentWidth = component.percentWidth;
            }
            else if (!isNaN(component.width))
            {
                xml.@width = component.width;
            }

            if (!isNaN(component.percentHeight))
            {
                xml.@percentHeight = component.percentHeight;
            }
            else if (!isNaN(component.height))
            {
                xml.@height = component.height;
            }
        }

        public static function setSizeFromXMLToComponent(xml:XML, component:UIComponent):void
        {
            if ("@width" in xml)
            {
                component.percentWidth = Number.NaN;
                component.width = xml.@width;
            }
            else if ("@percentWidth" in xml)
            {
                component.width = Number.NaN;
                component.percentWidth = xml.@percentWidth;
            }

            if ("@height" in xml)
            {
                component.percentHeight = Number.NaN;
                component.height = xml.@height;
            }
            else if ("@percentHeight" in xml)
            {
                component.height = Number.NaN;
                component.percentHeight = xml.@percentHeight;
            }
        }
    }
}
