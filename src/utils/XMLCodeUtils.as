////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) STARTcloud, Inc. 2015-2022. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the Server Side Public License, version 1,
//  as published by MongoDB, Inc.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  Server Side Public License for more details.
//
//  You should have received a copy of the Server Side Public License
//  along with this program. If not, see
//
//  http://www.mongodb.com/licensing/server-side-public-license
//
//  As a special exception, the copyright holders give permission to link the
//  code of portions of this program with the OpenSSL library under certain
//  conditions as described in each individual source file and distribute
//  linked combinations including the program with the OpenSSL library. You
//  must comply with the Server Side Public License in all respects for
//  all of the code used other than as permitted herein. If you modify file(s)
//  with this exception, you may extend this exception to your version of the
//  file(s), but you are not obligated to do so. If you do not wish to do so,
//  delete this exception statement from your version. If you delete this
//  exception statement from all source files in the program, then also delete
//  it in the license file.
//
////////////////////////////////////////////////////////////////////////////////
package utils
{
    import interfaces.IComponentPercentSizeOutput;
    import interfaces.IComponentSizeOutput;

    import mx.core.IUIComponent;
    import mx.core.UIComponent;
    import mx.utils.StringUtil;

    import spark.layouts.HorizontalAlign;
    import spark.layouts.VerticalAlign;

    import view.primeFaces.supportClasses.ContainerDirection;

    import view.primeFaces.supportClasses.Container;
    import view.primeFaces.surfaceComponents.components.Div;
    import view.domino.surfaceComponents.components.DominoParagraph;

    public class XMLCodeUtils
    {
        public static function addSizeHtmlStyleToXML(xml:XML, component:IUIComponent):void
        {
            var componentSizeOutput:IComponentSizeOutput = component as IComponentSizeOutput;
            var componentPercentSize:IComponentPercentSizeOutput = component as IComponentPercentSizeOutput;

            var styleDiv:String = xml.@style;

            if (!isNaN(component.percentWidth) || (componentPercentSize && !isNaN(componentPercentSize.widthPercent)))
            {
                var percentWidth:Number = !isNaN(component.percentWidth) ? component.percentWidth : componentPercentSize.widthPercent;
                if (componentSizeOutput)
                {
                    if (componentSizeOutput.widthOutput)
                    {
                        styleDiv += "width:" + String(percentWidth) + "%;";
                    }
                }
                else
                {
                    styleDiv += "width:" + String(percentWidth) + "%;";
                }
            }
            else if (!isNaN(component.width))
            {
                if (componentSizeOutput)
                {
                    if (componentSizeOutput.widthOutput)
                    {
                        styleDiv += "width:" + String(component.width) + "px;";
                    }
                }
                else
                {
                    styleDiv += "width:" + String(component.width) + "px;";
                }
            }

            if (!isNaN(component.percentHeight) || (componentPercentSize && !isNaN(componentPercentSize.heightPercent)))
            {
                var percentHeight:Number = !isNaN(component.percentHeight) ? component.percentHeight : componentPercentSize.heightPercent;
                if (componentSizeOutput)
                {
                    if (componentSizeOutput.heightOutput)
                    {
                        styleDiv += "height:" + String(percentHeight) + "%;";
                    }
                }
                else
                {
                    styleDiv += "height:" + String(percentHeight) + "%;";
                }
            }
            else if (!isNaN(component.height))
            {
                if (componentSizeOutput)
                {
                    if (componentSizeOutput.heightOutput)
                    {
                        styleDiv += "height:" + String(component.height) + "px;";
                    }
                }
                else
                {
                    styleDiv += "height:" + String(component.height) + "px;";
                }
            }

            if (styleDiv)
            {
                xml.@style += styleDiv;
            }
        }

        public static function setSizeFromComponentToXML(component:IUIComponent, xml:XML):void
        {
            var componentSizeOutput:IComponentSizeOutput = component as IComponentSizeOutput;

            if (!isNaN(component.percentWidth))
            {
                xml.@percentWidth = component.percentWidth;
            }
            else if (!isNaN(component.width))
            {
                if (componentSizeOutput)
                {
                    if (componentSizeOutput.widthOutput)
                    {
                        xml.@width = component.width;
                    }
                }
                else
                {
                    xml.@width = component.width;
                }
            }

            if (!isNaN(component.percentHeight))
            {
                xml.@percentHeight = component.percentHeight;
            }
            else if (!isNaN(component.height))
            {
                if (componentSizeOutput)
                {
                    if (componentSizeOutput.heightOutput)
                    {
                        xml.@height = component.height;
                    }
                }
                else
                {
                    xml.@height = component.height;
                }
            }
        }

        public static function setSizeFromXMLToComponent(xml:XML, component:UIComponent):void
        {
            var componentSizeOutput:IComponentSizeOutput = component as IComponentSizeOutput;

            if ("@width" in xml)
            {
                component.percentWidth = Number.NaN;
                component.width = xml.@width;

                if (componentSizeOutput && isNaN(component.width))
                {
                    (component as IComponentSizeOutput).widthOutput = false;
                }
                else if (componentSizeOutput)
                {
                    (component as IComponentSizeOutput).widthOutput = true;
                }
            }
            else if ("@percentWidth" in xml)
            {
                component.width = Number.NaN;
                component.percentWidth = xml.@percentWidth;
            }
            else if (componentSizeOutput)
            {
                (component as IComponentSizeOutput).widthOutput = false;
                component.width = Number.NaN;
            }

            if ("@height" in xml)
            {
                component.percentHeight = Number.NaN;
                component.height = xml.@height;

                if (componentSizeOutput && isNaN(component.height))
                {
                    (component as IComponentSizeOutput).heightOutput = false;
                }
                else if (componentSizeOutput)
                {
                    (component as IComponentSizeOutput).heightOutput = true;
                }
            }
            else if ("@percentHeight" in xml)
            {
                component.height = Number.NaN;
                component.percentHeight = xml.@percentHeight;
            }
            else if (componentSizeOutput)
            {
                (component as IComponentSizeOutput).heightOutput = false;
                component.height = Number.NaN;
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


        public static function applyChildrenPositionFromXMLParagraph(xml:XML, container:DominoParagraph):void
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

        // public static function getTitleForXML(container:Container):String
        // {
        //      var title:String="";
        //       if (container.title){
        //           title=container.title
        //       }
        //       return title;
        // }

        public static function getCdataInformationFromXML(component:XML):String
        {
            var script:XML = getCdataXML(component);

            return script ? String(script) : null;
        }

        public static function getCdataXML(component:XML):XML
        {
            var cdataInformation:String;
            var stringHelper:StringHelper = new StringHelper();
            var scripts:XMLList = component.Script;
            var scriptsCount:int = scripts.length();
            if (scriptsCount > 0)
            {
                for (var i:int = 0; i < scriptsCount; i++)
                {
                    cdataInformation = String(scripts[i].text());
                    if (cdataInformation)
                    {
                        cdataInformation = StringUtil.trim(cdataInformation);
                        if (cdataInformation.length <= 2)
                        {
                            cdataInformation = stringHelper.trim(cdataInformation, "\n");
                            cdataInformation = stringHelper.trim(cdataInformation, "\t");
                        }
                        if (cdataInformation)
                        {
                            return scripts[i];
                        }
                    }
                }
            }

            return null;
        }
    }
}
