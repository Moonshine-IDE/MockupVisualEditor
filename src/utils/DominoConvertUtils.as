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
    
    public class DominoConvertUtils
	{
        import flash.text.TextField;
        import flash.text.StyleSheet;
        import spark.components.gridClasses.GridColumn;
        import view.domino.viewEditor.object.ColumnObject
        import mx.utils.StringUtil;
        import global.domino.DominoGlobals;
        public static function convertColumnObjectToXML(c:ColumnObject):XML
        {
            var colXML:XML = new XML("<column />");
            if(c.columnSort!=null && c.columnSort!=""){
					colXML.@sort=c.columnSort;
				}else{
					colXML.@sort="none";
				}
				if(c.columnSortType!=null && c.columnSortType!=""){
					colXML.@categorized=c.columnSortType;
				}else{
					colXML.@categorized="false";
				}

				
				if(c.twisties!=null && c.twisties!=""){
					colXML.@twisties=c.twisties
				}
				if(c.separatemultiplevalues!=null && c.separatemultiplevalues!=""){
					colXML.@separatemultiplevalues=c.separatemultiplevalues
				}

				if(c.totals!=null && c.totals!=""){
					colXML.@totals=c.totals
				}
				
				colXML.@hidedetailrows="false";
				colXML.@width=c.columnWidth.toString();
				colXML.@resizable="true";
				
				colXML.@sortnoaccent="true" 
				colXML.@sortnocase="true" 
				colXML.@showaslinks="false"
				var colFont:XML=new XML("<font/>");
				if(c.columnFont!=null && c.columnTitleFont!=""){
					colFont.@name=c.columnFont;
				}

				if(c.columnStyle!=null && c.columnStyle!=""){
					colFont.@style=StringUtil.trim(c.columnStyle);
				}

				if(c.columnSize!=null && c.columnSize!=""){
					colFont.@size=c.columnSize;
				}

				if(c.columnColor!=null && c.columnColor!=""){
					colFont.@color=c.columnColor;
				}else{
					colFont.@color="#000000";
				}

				colXML.appendChild(colFont);


				var colHeader:XML=new XML("<columnheader />");
				colHeader.@title=c.columnHeaderTitle;

				var colHeaderFont:XML=new XML("<font/>");
				if(c.columnTitleFont!=null && c.columnTitleFont!=""){
					colHeaderFont.@name=c.columnTitleFont;
				}
				
				if(c.columnTitleStyle!=null && c.columnTitleStyle!=""){
					colHeaderFont.@style=StringUtil.trim(c.columnTitleStyle);
				}
				if(c.columnTitleSize!=null && c.columnTitleSize!=""){
					colHeaderFont.@size=c.columnTitleSize;
				}else{
					colHeaderFont.@size="9";
				}

				if(c.columnTitleColor!=null && c.columnTitleColor!=""){
					colHeaderFont.@color=c.columnTitleColor;
				}else{
					colHeaderFont.@color="#000000";
				}

				colHeader.appendChild(colHeaderFont);
				

				
				
				colXML.appendChild(colHeader);


				if(c.columnFormatStyle!=null && c.columnFormatStyle!=""){
					if(c.columnFormatStyle=="number"){
						var numberXML:XML = new XML("<numberformat />");
						if(c.columnNumberFormat!=null && c.columnNumberFormat!=""){
							numberXML.@format=c.columnNumberFormat;
						}else{
							numberXML.@format="fixed";
						}

						//if(numberXML.@format=="fixed"){
							if(c.columnNumberFormatDigits!=null && c.columnNumberFormatDigits!=""){
								numberXML.@digits=c.columnNumberFormatDigits;
							}else{
								numberXML.@digits="0"
							}
						//}

						if(c.columnNumberFormatPunctuated!=null && c.columnNumberFormatPunctuated!=""){
							numberXML.@punctuated=c.columnNumberFormatPunctuated
						}else{
							numberXML.@punctuated="false"
						}

						if(c.columnNumberFormatParens!=null && c.columnNumberFormatParens!=""){
							numberXML.@parens=c.columnNumberFormatParens
						}else{
							numberXML.@parens="false"
						}

						if(c.columnNumberFormatPercent!=null && c.columnNumberFormatPercent!=""){
							if(c.columnNumberFormatPercent=="true"){
								numberXML.@format="fixed";
							}
							numberXML.@percent=c.columnNumberFormatPercent;
							
						}else{
							numberXML.@percent="false"
						}


						if(c.columnNumberFormatBytes!=null && c.columnNumberFormatBytes!=""){
							if(c.columnNumberFormatBytes=="true"){
								numberXML.@format="fixed";
							}
							numberXML.@bytes=c.columnNumberFormatBytes;
							
						}else{
							numberXML.@bytes="false"
						}


						if(c.columnNumberFormatDecimalsym!=null && c.columnNumberFormatDecimalsym!=""){
							numberXML.@decimalsym=c.columnNumberFormatDecimalsym;
						}else{
							numberXML.@decimalsym=".";
						}
						if(c.columnNumberFormatThousandssep!=null && c.columnNumberFormatThousandssep!=""){
							numberXML.@thousandssep=c.columnNumberFormatThousandssep;
						}else{
							numberXML.@thousandssep=",";
						}

						if(c.columnNumberFormatPreference!=null && c.columnNumberFormatPreference!=""){
							
							numberXML.@preference=c.columnNumberFormatPreference;
						}else{
							numberXML.@preference="usersetting"
						}
						
						if(c.columnNumberFormatCurrencysymtype!=null && c.columnNumberFormatCurrencysymtype!=""){
							numberXML.@currencysymtype=c.columnNumberFormatCurrencysymtype;
						}else{
							numberXML.@currencysymtype="custom"
							
						}

						if(c.columnNumberFormatCurrencysym!=null && c.columnNumberFormatCurrencysym!=""){
							numberXML.@currencysym=c.columnNumberFormatCurrencysym;
						}else{
							numberXML.@currencysym="$";
						}
						if(c.columnNumberFormatUsecustomsym!=null && c.columnNumberFormatUsecustomsym!=""){
							numberXML.@usecustomsym=c.columnNumberFormatUsecustomsym;
						}else{
							numberXML.@usecustomsym="false"
						}


						colXML.appendChild(numberXML);
					}else if(c.columnFormatStyle=="datetime"){
						var datetimeXML:XML = new XML("<datetimeformat />");
						if(c.columnDateDisplayFormatPreferences!=null && c.columnDateDisplayFormatPreferences!=""){
							datetimeXML.@preference=c.columnDateDisplayFormatPreferences;
						}else{
							datetimeXML.@preference="usersetting"
						}

						var showVal:String="datetime";
						if(c.columnDateFormatDisplayDate=="true"&& c.columnDateFormatDisplayTime=="true")
						{
							showVal="datetime";
						}else  if(c.columnDateFormatDisplayDate=="true"){
							showVal="date";
						} else  if(c.columnDateFormatDisplayTime=="true"){
							showVal="time";
						}
						datetimeXML.@show=showVal;

						if(c.columnDateFormatDisplayDate&& c.columnDateFormatDisplayDate=="true"){
							if(c.columnDateFormatDateShow!=null && c.columnDateFormatDateShow!=""){
								datetimeXML.@date=c.columnDateFormatDateShow;
							}else{
								datetimeXML.@date="monthdayyear"
							}

							if(c.columnDateFormatSpecial!=null && c.columnDateFormatSpecial!=""){
								var _iniList:Array=c.columnDateFormatSpecial.split(" ");
								for (var j:int = 0; j < _iniList.length; j++){
									if(_iniList[j]){
										var elementStr:String = _iniList[j].toString();
										if(elementStr=="fourdigityearfor21stcentury"){
											datetimeXML.@fourdigityearfor21stcentury="true"
										}
										if(elementStr=="showtodaywhenappropriate"){
											datetimeXML.@showtodaywhenappropriate="true"
										}
										if(elementStr=="fourdigityear"){
											datetimeXML.@fourdigityear="true"
										}
										if(elementStr=="omitthisyear"){
											datetimeXML.@omitthisyear="true"
										}

									}
								}
							}else{
								datetimeXML.@fourdigityearfor21stcentury="true"
							}


							if(c.columnDateFormatCalendar!=null && c.columnDateFormatCalendar!=""){
								datetimeXML.@calendar=c.columnDateFormatCalendar;
							}else{
								datetimeXML.@calendar="gregorian";
							}


							if(c.columnDateFormatDateFormat!=null && c.columnDateFormatDateFormat!=""){
								datetimeXML.@dateformat=c.columnDateFormatDateFormat;
							}else{
								datetimeXML.@dateformat="weekdaymonthdayyear";
							}


							if(c.columnDateFormatDay!=null && c.columnDateFormatDay!=""){
								datetimeXML.@dayformat=c.columnDateFormatDay;
							}else{
								datetimeXML.@dayformat="twodigitday";
							}

							if(c.columnDateFormatMonth!=null && c.columnDateFormatMonth!=""){
								datetimeXML.@monthformat=c.columnDateFormatMonth;
							}else{
								datetimeXML.@monthformat="twodigitmonth";
							}

							if(c.columnDateFormatYear!=null && c.columnDateFormatYear!=""){
								datetimeXML.@yearformat=c.columnDateFormatYear;
							}else{
								datetimeXML.@yearformat="fourdigityear";
							}

							if(c.columnDateFormatWeekday!=null && c.columnDateFormatWeekday!=""){
								datetimeXML.@weekdayformat=c.columnDateFormatWeekday;
							}else{
								datetimeXML.@weekdayformat="shortname";
							}

							if(c.columnDateFormatDateseparator1!=null && c.columnDateFormatDateseparator1!=""){
								datetimeXML.@dateseparator1=c.columnDateFormatDateseparator1;
							}else{
								datetimeXML.@dateseparator1=" ";
							}
							if(c.columnDateFormatDateseparator2!=null && c.columnDateFormatDateseparator2!=""){
								datetimeXML.@dateseparator2=c.columnDateFormatDateseparator2;
							}else{
								datetimeXML.@dateseparator2="/";
							}

							if(c.columnDateFormatDateseparator3!=null && c.columnDateFormatDateseparator3!=""){
								datetimeXML.@dateseparator3=c.columnDateFormatDateseparator3;
							}else{
								datetimeXML.@dateseparator3="/";
							}

							//columnDateFormatDateseparator1
						}

						if(c.columnDateFormatDisplayTime&& c.columnDateFormatDisplayTime=="true"){
							if(c.columnDateFormatTimeShow!=null && c.columnDateFormatTimeShow!=""){
								datetimeXML.@time=c.columnDateFormatTimeShow;
							}else{
								datetimeXML.@time="hourminutesecond";
							}


							if(c.columnDateFormatTimeZone!=null && c.columnDateFormatTimeZone!=""){
								datetimeXML.@zone=c.columnDateFormatTimeZone;
							}else{
								datetimeXML.@zone="never";
							}

							if(c.columnDateFormatTimeFormat!=null && c.columnDateFormatTimeFormat!=""){
								if(c.columnDateFormatTimeFormat=="24"){
									datetimeXML.@timeformat24="true";
								}else{
									datetimeXML.@timeformat12="true"
								}
								
							}else{
								datetimeXML.@timeformat24="true";
							}

							if(c.columnDateFormatTimeSeparator!=null && c.columnDateFormatTimeSeparator!=""){
								datetimeXML.@timeseparator=c.columnDateFormatTimeSeparator;
							}else{
								datetimeXML.@timeseparator=":";
							}

							//timeseparator


						}

					
						
						colXML.appendChild(datetimeXML);
						
						
						
					}else if(c.columnFormatStyle=="names"){
						var namesXML:XML = new XML("<columnnamesformat />");
						if(c.columnNameContain!=null && c.columnNameContain!=""){
							namesXML.@columncontainsname=c.columnNameContain;
						}else{
							namesXML.@columncontainsname="false"
						}
						if(c.columnNameStatus!=null && c.columnNameStatus!=""){
							namesXML.@showonline=c.columnNameStatus;
						}else{
							namesXML.@showonline="false"
						}

						if(c.columnNameProgramName!=null && c.columnNameProgramName!=""){
							namesXML.@columnname=c.columnNameProgramName;
						}else{
							namesXML.@columnname=""
						}


						if(c.columnNameVertival!=null && c.columnNameVertival!=""){
							namesXML.@verticalorientation=c.columnNameVertival;
						}
						colXML.appendChild(namesXML);

					}
				}

				if(c.columnTypeValue=="Field"){
					colXML.@itemname=c.columnCodeFormula;
				}else if (c.columnTypeValue=="Formula"){
					colXML.@itemname="$"+DominoGlobals.DominoViewSharedColumnCount;
                    DominoGlobals.DominoViewSharedColumnCount++;
					var colCode:XML=new XML(" <code event=\"value\" />");
					var colCodeFormual:XML=new XML(" <formula>"+c.columnCodeFormula+"</formula>");
					colCode.appendChild(colCodeFormual);
					colXML.appendChild(colCode)
				}

                return colXML;

        }
        public static function convertDominoCharacterWidthToPixelWidth(sizeNum:Number,fontName:String,fontWeight:String,charNum:Number):Number
        {
            
            var newStyle:StyleSheet =  setTextStyle(sizeNum,fontName,fontWeight) ; 
            var textFiled:TextField = new TextField();
            textFiled.styleSheet=newStyle;
            var labelText:String="";
            for (var i:int = 0; i < charNum; i++) {
                labelText=labelText+"X";
            }
            textFiled.htmlText=labelText;
            return textFiled.textWidth;

        }

        public static function convertPixelWidthToDominoCharacterWidth(sizeNum:Number,fontName:String,fontWeight:String,pixelWidth:Number):Number
        {
            var newStyle:StyleSheet =  setTextStyle(sizeNum,fontName,fontWeight) ; 
            var textFiled:TextField = new TextField();
            textFiled.styleSheet=newStyle;
            var labelText:String="X";
            textFiled.htmlText=labelText;
            var width:Number=textFiled.textWidth;
            var charNum:Number=Math.round(pixelWidth/width)+1;
            return charNum;

        }

        private static function setTextStyle(sizeNum:Number,fontName:String,fontWeight:String):StyleSheet{
            var newStyle:StyleSheet = new StyleSheet();
            var styleObj:Object = new Object();
                //normal and bold.
                styleObj.fontWeight = fontWeight;
                //Recognized values are normal and italic. -- fontStyle
                styleObj.fontSize = sizeNum;
                styleObj.fontFamily = fontName;
                newStyle.setStyle(".defStyle", styleObj);
                return   newStyle ;
        }

        // public static function resizeColumn(col:GridColumn, size:int):GridColumn
        // {
        //     var owner:* = col.mx_internal::owner
        //     col.mx_internal::owner = null;

        //     col.width = size;

        //     col.mx_internal::owner = owner;
        //     return col
        // }
        
    }
}