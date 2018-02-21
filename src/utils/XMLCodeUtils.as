package utils
{
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
    }
}
