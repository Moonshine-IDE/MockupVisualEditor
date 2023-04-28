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
package view.primeFaces.supportClasses
{
    import mx.formatters.NumberBaseRoundType;
    import mx.formatters.NumberFormatter;

    public class InputNumberFormatter extends NumberFormatter
    {
        public function InputNumberFormatter()
        {
            super();
        }

        override public function format(value:Object):String
        {
            // Reset any previous errors.
            if (error)
                error = null;

            if (useThousandsSeparator &&
                    ((decimalSeparatorFrom == thousandsSeparatorFrom) ||
                            (decimalSeparatorTo == thousandsSeparatorTo)))
            {
                error = defaultInvalidFormatError;
                return "";
            }

            if (decimalSeparatorTo == "" || !isNaN(Number(decimalSeparatorTo)))
            {
                error = defaultInvalidFormatError;
                return "";
            }

            var dataFormatter:InputNumberBase = new InputNumberBase(decimalSeparatorFrom,
                    thousandsSeparatorFrom,
                    decimalSeparatorTo,
                    thousandsSeparatorTo);

            // -- value --

            if (value is String)
                value = dataFormatter.parseNumberString(String(value));

            if (value === null || isNaN(Number(value)))
            {
                error = defaultInvalidValueError;
                return "";
            }

            // -- format --

            var isNegative:Boolean = (Number(value) < 0);

            var numStr:String = value.toString();

            numStr = numStr.toLowerCase();
            var e:int = numStr.indexOf("e");
            if (e != -1)  //deal with exponents
                numStr = dataFormatter.expandExponents(numStr);

            var numArrTemp:Array = numStr.split(".");
            var numFraction:int = numArrTemp[1] ? String(numArrTemp[1]).length : 0;

            if (precision < numFraction)
            {
                if (rounding != NumberBaseRoundType.NONE)
                {
                    numStr = dataFormatter.formatRoundingWithPrecision(
                            numStr, rounding, int(precision));
                }
            }

            var numValue:Number = Number(numStr);
            if (Math.abs(numValue) >= 1)
            {
                numArrTemp = numStr.split(".");
                var front:String = useThousandsSeparator ?
                        dataFormatter.formatThousands(String(numArrTemp[0])) :
                        String(numArrTemp[0]);
                if (numArrTemp[1] != null && numArrTemp[1] != "")
                    numStr = front + decimalSeparatorTo + numArrTemp[1];
                else
                    numStr = front;
            }
            else if (Math.abs(numValue) > 0)
            {
                // Check if the string is in scientific notation
                numStr = numStr.toLowerCase();
                if (numStr.indexOf("e") != -1)
                {
                    var temp:Number = Math.abs(numValue) + 1;
                    numStr = temp.toString();
                }
                numStr = decimalSeparatorTo +
                        numStr.substring(numStr.indexOf(".") + 1);
            }

            numStr = dataFormatter.formatPrecision(numStr, int(precision));

            // If our value is 0, then don't show -0
            if (Number(numStr) == 0)
            {
                isNegative = false;
            }

            if (isNegative)
                numStr = dataFormatter.formatNegative(numStr, useNegativeSign);

            if (!dataFormatter.isValid)
            {
                error = defaultInvalidFormatError;
                return "";
            }

            return numStr;
        }
    }
}
