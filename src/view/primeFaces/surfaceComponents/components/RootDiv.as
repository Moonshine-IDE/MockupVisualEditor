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
package view.primeFaces.surfaceComponents.components
{
    import interfaces.IComponentPercentSizeOutput;
    import interfaces.ILookup;
    import interfaces.ISurface;

    import view.interfaces.INonDeletableSurfaceComponent;

    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="updateDisplayList", kind="method")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="widthPercent", kind="property")]
    [Exclude(name="heightPercent", kind="property")]

    /**
     * <p>This component is special representation of Div, which is root component for newly created file.</p>
     *
     * @see view.primeFaces.surfaceComponents.components.Div
     */
    public class RootDiv extends Div implements INonDeletableSurfaceComponent, IComponentPercentSizeOutput
    {
        public static var ELEMENT_NAME:String = "RootDiv";

        public function RootDiv()
        {
            super();
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
         * @see view.primeFaces.surfaceComponents.components.Div#percentHeight
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

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * @see view.primeFaces.surfaceComponents.components.Div#percentHeight
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

        override public function fromXML(xml:XML, callback:Function, surface:ISurface, lookup:ILookup):void
        {
            var localSurface:ISurface = surface;

            super.fromXML(xml, callback, localSurface, lookup);

            contentChanged = true;
            this.invalidateDisplayList();
        }

        override public function toXML():XML
        {
            mainXML = new XML("<RootDiv/>");

            mainXML = super.internalToXML();

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
