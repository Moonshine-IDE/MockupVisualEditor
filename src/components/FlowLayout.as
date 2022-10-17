////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2016-present Prominic.NET, Inc.
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
package components
{
    import mx.core.ILayoutElement;

    import spark.components.supportClasses.GroupBase;
    import spark.layouts.HorizontalAlign;
    import spark.layouts.VerticalAlign;
    import spark.layouts.supportClasses.LayoutBase;

    public class FlowLayout extends LayoutBase
    {
        public function FlowLayout()
        {
            super();
        }
        //---------------------------------------------------------------
        //
        //  Class properties
        //
        //---------------------------------------------------------------

        //---------------------------------------------------------------
        //  horizontalGap
        //---------------------------------------------------------------

        private var _horizontalGap:int = 6;

        [Inspectable(defaultValue="6")]
        public function get horizontalGap():int
        {
            return _horizontalGap;
        }

        public function set horizontalGap(value:int):void
        {
            if (_horizontalGap != value)
            {
                _horizontalGap = value;

                // We must invalidate the layout
                var layoutTarget:GroupBase = target;
                if (layoutTarget)
                {
                    layoutTarget.invalidateDisplayList();
                }
            }
        }

        //---------------------------------------------------------------
        //  verticalAlign
        //---------------------------------------------------------------

        private var _verticalAlign:String = "top";

        [Inspectable(enumeration="top,bottom,middle", defaultValue="top")]
        public function get verticalAlign():String
        {
            return _verticalAlign;
        }

        public function set verticalAlign(value:String):void
        {
            if (_verticalAlign != value)
            {
                _verticalAlign = value;

                // We must invalidate the layout
                var layoutTarget:GroupBase = target;
                if (layoutTarget)
                {
                    layoutTarget.invalidateDisplayList();
                }
            }
        }

        //---------------------------------------------------------------
        //  horizontalAlign
        //---------------------------------------------------------------

        private var _horizontalAlign:String = "left"; // center, right

        [Inspectable(enumeration="left,right,center", defaultValue="left")]
        public function get horizontalAlign():String
        {
            return _horizontalAlign;
        }

        public function set horizontalAlign(value:String):void
        {
            if (_horizontalAlign != value)
            {
                _horizontalAlign = value;

                // We must invalidate the layout
                var layoutTarget:GroupBase = target;
                if (layoutTarget)
                {
                    layoutTarget.invalidateDisplayList();
                }
            }
        }

        //---------------------------------------------------------------
        //
        //  Class methods
        //
        //---------------------------------------------------------------

        override public function updateDisplayList(containerWidth:Number,
                                                   containerHeight:Number):void
        {
            var element:ILayoutElement;
            var layoutTarget:GroupBase = this.target;
            var count:int = layoutTarget.numElements;
            var hGap:int = this.horizontalGap;

            // The position for the current element
            var x:Number = 0;
            var y:Number = 0;
            var elementWidth:Number;
            var elementHeight:Number;

            var vAlign:Number = 0;
            switch (this.verticalAlign)
            {
                case VerticalAlign.MIDDLE:
                    vAlign = 0.5;
                    break;
                case VerticalAlign.BOTTOM:
                    vAlign = 1;
                    break;
            }

            // Keep track of per-row height, maximum row width
            var maxRowWidth:Number = 0;

            // loop through the elements
            // while we can start a new row
            var rowStart:int = 0;
            while (rowStart < count)
            {
                // The row always contains the start element
                element = useVirtualLayout ? layoutTarget.getVirtualElementAt(rowStart) :
                        layoutTarget.getElementAt(rowStart);

                var rowWidth:Number = element.getPreferredBoundsWidth();
                var rowHeight:Number =  element.getPreferredBoundsHeight();

                // Find the end of the current row
                var rowEnd:int = rowStart;
                while (rowEnd + 1 < count)
                {
                    element = useVirtualLayout ? layoutTarget.getVirtualElementAt(rowEnd + 1) :
                            layoutTarget.getElementAt(rowEnd + 1);

                    // Since we haven't resized the element just yet, get its preferred size
                    elementWidth = element.getPreferredBoundsWidth();
                    elementHeight = element.getPreferredBoundsHeight();

                    // Can we add one more element to this row?
                    if (rowWidth + hGap + elementWidth > containerWidth)
                        break;

                    rowWidth += hGap + elementWidth;
                    if (elementHeight > rowHeight)
                    {
                        rowHeight = elementHeight;
                    }

                    rowEnd++;
                }

                x = 0;
                switch (this.horizontalAlign)
                {
                    case HorizontalAlign.CENTER:
                        x = Math.round(containerWidth - rowWidth) / 2;
                        break;
                    case HorizontalAlign.RIGHT:
                        x = containerWidth - rowWidth;
                        break;
                }

                // Keep track of the maximum row width so that we can
                // set the correct contentSize
                var xRowWidth:Number = x + rowWidth;
                if (xRowWidth > maxRowWidth)
                {
                    maxRowWidth = xRowWidth;
                }

                // Layout all the elements within the row
                for (var i:int = rowStart; i <= rowEnd; i++)
                {
                    element = useVirtualLayout ? layoutTarget.getVirtualElementAt(i) :
                            layoutTarget.getElementAt(i);

                    // Resize the element to its preferred size by passing
                    // NaN for the width and height constraints
                    element.setLayoutBoundsSize(NaN, NaN);

                    // Find out the element's dimensions sizes.
                    // We do this after the element has been already resized
                    // to its preferred size.
                    elementWidth = element.getLayoutBoundsWidth();
                    elementHeight = element.getLayoutBoundsHeight();

                    // Calculate the position within the row
                    var elementY:Number = Math.round((rowHeight - elementHeight) * vAlign);

                    // Position the element
                    element.setLayoutBoundsPosition(x, y + elementY);

                    x += hGap + elementWidth;
                }

                // Next row will start with the first element after the current row's end
                rowStart = rowEnd + 1;

                // Update the position to the beginning of the row
                x = 0;
                y += rowHeight;
            }

            // Set the content size which determines the scrolling limits
            // and is used by the Scroller to calculate whether to show up
            // the scrollbars when the the scroll policy is set to "auto"
            layoutTarget.setContentSize(maxRowWidth, y);
        }
    }
}
