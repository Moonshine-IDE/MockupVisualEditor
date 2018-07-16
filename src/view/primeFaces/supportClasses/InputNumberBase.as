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
