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
package view.primeFaces.supportClasses
{
    import mx.formatters.NumberBase;

    public class InputNumberBase extends NumberBase
    {
        public function InputNumberBase(decimalSeparatorFrom:String = ".", thousandsSeparatorFrom:String = ",", decimalSeparatorTo:String = ".", thousandsSeparatorTo:String = ",")
        {
            super(decimalSeparatorFrom, thousandsSeparatorFrom, decimalSeparatorTo, thousandsSeparatorTo);
        }

        override public function formatThousands(value:String):String
        {
            var v:Number = Number(value);

            var isNegative:Boolean = (v < 0);

            var numStr:String = value;

            numStr.toLowerCase();
            var e:int = numStr.indexOf("e");
            if (e != -1)  //deal with exponents
                numStr = expandExponents(numStr);

            var numArr:Array =
                    numStr.split((numStr.indexOf(decimalSeparatorTo) != -1) ? decimalSeparatorTo : ".");
            var numLen:int = String(numArr[0]).length;

            if (numLen > 3)
            {
                var numSep:int = int(Math.floor(numLen / 3));

                if ((numLen % 3) == 0)
                    numSep--;

                var b:int = numLen;
                var a:int = b - 3;

                var arr:Array = [];
                for (var i:int = 0; i <= numSep; i++)
                {
                    arr[i] = numArr[0].slice(a, b);
                    a = int(Math.max(a - 3, 0));
                    b = int(Math.max(b - 3, 1));
                }

                arr.reverse();

                numArr[0] = arr.join(thousandsSeparatorTo);
            }

            numStr = numArr.join(decimalSeparatorTo);

            if (isNegative)
                numStr = "-" + numStr;

            return numStr.toString();
        }
    }
}
