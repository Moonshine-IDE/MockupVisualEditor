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
