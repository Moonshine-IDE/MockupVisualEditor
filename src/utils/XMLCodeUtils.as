package utils
{
    import mx.core.IUIComponent;
    import mx.core.UIComponent;

    import spark.layouts.HorizontalAlign;
    import spark.layouts.VerticalAlign;

    import view.primeFaces.supportClasses.ContainerDirection;

    import view.primeFaces.surfaceComponents.components.Container;
    import view.primeFaces.surfaceComponents.components.Div;

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

        public static function applyChildrenPositionFromXML(xml:XML, container:Div):void
        {
            if (container.cssClass)
            {
                var classes:Array = container.cssClass.split(" ");

                for each (var className:String in classes)
                {
                    switch (className)
                    {
                        case "flexVerticalLayout":
                            container.wrap = false;
                            container.direction = ContainerDirection.VERTICAL_LAYOUT;
                            break;
                        case "flexHorizontalLayout":
                            container.wrap = false;
                            container.direction = ContainerDirection.HORIZONTAL_LAYOUT;
                            break;
                        case "flexVerticalLayoutWrap":
                            container.wrap = true;
                            break;
                    }

                    switch (className)
                    {
                        case "flexVerticalLayoutLeft":
                        case "flexHorizontalLayoutLeft":
                            container.horizontalAlign = HorizontalAlign.LEFT;
                            break;
                        case "flexVerticalLayoutRight":
                        case "flexHorizontalLayoutRight":
                            container.horizontalAlign = HorizontalAlign.RIGHT;
                            break;
                        case "flexCenter":
                            if (container.direction == ContainerDirection.VERTICAL_LAYOUT)
                            {
                                container.verticalAlign = VerticalAlign.MIDDLE;
                            }
                            else
                            {
                                container.horizontalAlign = HorizontalAlign.CENTER;
                            }
                            break;
                    }

                    switch (className)
                    {
                        case "flexVerticalLayoutTop":
                        case "flexHorizontalLayoutTop":
                            container.verticalAlign = VerticalAlign.TOP;
                            break;
                        case "flexVerticalLayoutBottom":
                        case "flexHorizontalLayoutBottom":
                            container.verticalAlign = VerticalAlign.BOTTOM;
                            break;
                        case "flexMiddle":
                            if (container.direction == ContainerDirection.VERTICAL_LAYOUT)
                            {
                                container.horizontalAlign = HorizontalAlign.CENTER;
                            }
                            else
                            {
                                container.verticalAlign = VerticalAlign.MIDDLE;
                            }
                            break;

                    }
                }
            }
        }

        public static function getChildrenPositionForXML(container:Container):String
        {
            var className:String;

            if (container.direction == ContainerDirection.HORIZONTAL_LAYOUT)
            {
                className = container.wrap ? "flexHorizontalLayoutWrap" : "flexHorizontalLayout";

                switch (container.horizontalAlign)
                {
                    case HorizontalAlign.LEFT:
                        className += " " + "flexHorizontalLayoutLeft";
                        break;
                    case HorizontalAlign.RIGHT:
                        className += " " + "flexHorizontalLayoutRight";
                        break;
                    case HorizontalAlign.CENTER:
                        className += " " + "flexCenter";
                        break;
                }

                switch (container.verticalAlign)
                {
                    case VerticalAlign.TOP:
                        className += " " + "flexHorizontalLayoutTop";
                        break;
                    case VerticalAlign.BOTTOM:
                        className += " " + "flexHorizontalLayoutBottom";
                        break;
                    case VerticalAlign.MIDDLE:
                        className += " " + "flexMiddle";
                        break;
                }
            }
            else if (container.direction == ContainerDirection.VERTICAL_LAYOUT)
            {
                className = container.wrap ? "flexVerticalLayoutWrap" : "flexVerticalLayout";

                switch (container.horizontalAlign)
                {
                    case HorizontalAlign.LEFT:
                        className += " " + "flexVerticalLayoutLeft";
                        break;
                    case HorizontalAlign.RIGHT:
                        className += " " + "flexVerticalLayoutRight";
                        break;
                    case HorizontalAlign.CENTER:
                        className += " " + "flexMiddle";
                        break;
                }

                switch (container.verticalAlign)
                {
                    case VerticalAlign.TOP:
                        className += " " + "flexVerticalLayoutTop";
                        break;
                    case VerticalAlign.BOTTOM:
                        className += " " + "flexVerticalLayoutBottom";
                        break;
                    case VerticalAlign.MIDDLE:
                        className += " " + "flexCenter";
                        break;
                }
            }

            return className;
        }
    }
}
