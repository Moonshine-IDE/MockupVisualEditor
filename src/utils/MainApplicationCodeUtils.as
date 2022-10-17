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
package utils
{
    import mx.core.UIComponent;
    import view.EditingSurface;
    import view.interfaces.ISurfaceComponent;
    import view.primeFaces.supportClasses.Container;
    import view.primeFaces.surfaceComponents.components.MainApplication;
	import mx.controls.Alert;
	import global.domino.DominoGlobals;
    public class MainApplicationCodeUtils
	{


		public static function appendXMLMainTag(surface:EditingSurface):XML
		{
			var element:ISurfaceComponent = surface.numElements > 0 ? surface.getElementAt(0) as ISurfaceComponent : null;
			var isPrimeFacesMainApp:MainApplication = element as MainApplication;

            if (!isPrimeFacesMainApp && element === null)
			{
				var container:XML = new XML("<RootDiv />");
                container.@width = "700";
				container.@height = "450";

				return container;
			}

			return null;
		}

		/**
		 * return domino main xml tag
		 */
		public static function appendDominoXMLMainTag(surface:EditingSurface):XML
		{
			var element:ISurfaceComponent = surface.numElements > 0 ? surface.getElementAt(0) as ISurfaceComponent : null;
			var isDominoMainApp:MainApplication = element as MainApplication;

		
            if (element === null && !isDominoMainApp)
			{
				
				var container:XML = new XML("<MainApplication id='mainApplicationWindow' x='0' y='0' width='700' height='450'  />");

				return container;
			}

			return null;
		}

		public static function getMainContainerTag(xml:XML):XML
		{
            var body:XMLList = xml.children();
            for each (var item:XML in body)
            {
                var itemName:String = item.name();
                if (itemName.lastIndexOf("body") > -1||itemName.lastIndexOf("Body") > -1)
                {
                    return item.children()[0];
                }
            }

			return null;
		}
		public static function getDominPageMainContainerTag(xml:XML):XML
		{
			var body:XMLList = xml.children();
			var mainItem:XML=null;
			var item:XML = null;
			var itemName:String = "";
			for each (item in body)
            {
                itemName = item.name();
                if (itemName=="http://www.lotus.com/dxl::body")
                {
					mainItem = item;
                }
            }

			return mainItem;
		}


		public static function getDominMainContainerTag(xml:XML):XML
		{
            var body:XMLList = xml.children();
			var mainItem:XML=null;
			var item:XML = null;
			var itemName:String = "";
			for each (item in body)
            {
                itemName = item.name();
                if (itemName=="http://www.lotus.com/dxl::richtext")
                {
					mainItem = item;
                }
            }
			if(mainItem==null){
				for each (item in body)
				{
					itemName = item.name();
					if (itemName=="http://www.lotus.com/dxl::item" && item.@name=="$Body")
					{
						mainItem = item;
					}
				}
			}

			return mainItem;
		}


		public static function getRoyaleMainContainerTag(xml:XML):XML
		{
            var body:XMLList = xml.children();
			var mainItem:XML=null;
			var item:XML = null;
			var itemName:String = "";
			for each (item in body)
            {
                itemName = item.name();
				
				//			   library://ns.apache.org/royale/jewel::ApplicationMainContent
                if (itemName=="library://ns.apache.org/royale/jewel::ApplicationMainContent")
                {
					mainItem = item;
                }
            }
			

			return mainItem;
		}

		public static function getDominMainContainerTagByRichtext(xml:XML):XML
		{
            var body:XMLList = xml.children();
			var mainItem:XML=null;
			for each (var item:XML in body)
            {
                var itemName:String = item.name();
				
                if (itemName=="http://www.lotus.com/dxl::richtext")
                {
					mainItem=item
                   
                }
            }
		

			return mainItem;
		}


		public static function getDominTitleTag(xml:XML):XML
		{
            var body:XMLList = xml.children();
            for each (var item:XML in body)
            {
                var itemName:String = item.name();
				
                if (itemName=="http://www.lotus.com/dxl::item" && item.@name=="$TITLE")
                {
				
                    return item;
                }
            }

			return null;
		}


		public static function fixDominField(xml:XML):XML
		{
			var mainFieldsContainer:XML=getDominMainFieldListContainerTag(xml);
			var total_xml:XML=xml;
            handleFleldOneNode(xml,mainFieldsContainer,total_xml);
			return xml;
		}

		public static function fixPardefTableError(xml:XML):XML
		{
			var mainContainer:XML = MainApplicationCodeUtils.getDominMainContainerTag(xml);
			if(mainContainer){
				
				if( mainContainer.children()[0] && mainContainer.children()[0].name()=="richtext"){
						mainContainer=mainContainer.children()[0];
				}
				if(mainContainer.children().length()>0){
					
					var firstNode:XML = mainContainer.children()[0];
				
					if(firstNode){
					
						var sencodeNode:XML = mainContainer.children()[1];
						if(sencodeNode){
							
							if(firstNode.name()=="pardef"){
								if(sencodeNode.name()=="table"){
								 	delete firstNode.parent().children()[firstNode.childIndex()];
								}
							}
						}
					}
					
				
				}
				
				//var childName:String=child.name();

			}
			return xml;
		}

		public static function fixPardefAlign(xml:XML):XML
		{

			
			
			for each(var par:XML in xml..par) //no matter of depth Note here
			{
			
				
				if(par.@alignPardef && par.@alignPardef.toString().length>0 || par.@listPardef && par.@listPardef.toString().length>0 ||
				par.@indent && par.@indent.toString().length>0 ||
				par.@outdent && par.@outdent.toString().length>0 ||
				par.@spacingInterline && par.@spacingInterline.toString().length>0||
				par.@spacingAbove && par.@spacingAbove.toString().length>0||
				par.@spacingBelow && par.@spacingBelow.toString().length>0){
				
					var pardefId:String=par.@def;
					if(pardefId!=null){
						for each(var pardef:XML in xml..pardef)
						{
							var id:String = pardef.@id;
							if(pardefId==id){
							
								var needFix:Boolean =false;
								var needFixFirstLine:Boolean =false;

								//fix the pardef in here
								if(pardef.@alignPardef && pardef.@alignPardef.toString().length>0 || 
								pardef.@listPardef && pardef.@listPardef.toString().length>0 || 
								par.@indent && par.@indent.toString().length>0 ||
								par.@outdent && par.@outdent.toString().length>0||
								par.@spacingInterline && par.@spacingInterline.toString().length>0||
								par.@spacingAbove && par.@spacingAbove.toString().length>0||
								par.@spacingBelow && par.@spacingBelow.toString().length>0
								){
									if(pardef.@alignPardef!=par.@alignPardef || pardef.@listPardef!=par.@listPardef || 
									par.@indent && par.@indent.toString().length>0 ||  
									par.@outdent && par.@outdent.toString().length>0 ||
									par.@spacingInterline && par.@spacingInterline.toString().length>0||
									par.@spacingAbove && par.@spacingAbove.toString().length>0||
									par.@spacingBelow && par.@spacingBelow.toString().length>0
									){
										needFix= true;
									}else{
										needFix= false;
									}
								}else{
									needFix= true;
								}
								

								if(needFix==true){
									DominoGlobals.PardefPardefAlignId++;
									var newId:String=DominoGlobals.PardefPardefAlignId.toString();
									var pardefXml:XML = pardef.copy();
									pardefXml.@id=newId
									if(par.@listPardef && par.@listPardef.toString().length>0){
										pardefXml.@list=par.@listPardef;
									}
									if(par.@alignPardef && par.@alignPardef.toString().length>0){
										pardefXml.@align=par.@alignPardef;
									}
	

									if(par.@indent && par.@indent.toString().length>0){
										pardefXml.@firstlineleftmargin= (Number(par.@indent)+1).toString()+"in";
										if(par.@outdent==null || par.@outdent.toString() =="0"){
											pardefXml.@leftmargin="1in";
										}else{
											if(par.@leftmargin&&par.@leftmargin.toString().length>0){
												pardefXml.@leftmargin=par.@leftmargin;
											}
											
										}
									}
									
									if(par.@outdent && par.@outdent.toString().length>0){
										pardefXml.@leftmargin= (Number(par.@outdent)+1).toString()+"in";
										if(par.@indent==null || par.@indent.toString() =="0"){
											pardefXml.@firstlineleftmargin="1in";
										}else{
											if(par.@firstlineleftmargin&&par.@firstlineleftmargin.toString().length>0){
												pardefXml.@firstlineleftmargin=par.@firstlineleftmargin;
											}
											
										}
									}

									if(par.@spacingInterline && par.@spacingInterline.toString().length>0){
										pardefXml.@linespacing=par.@spacingInterline;
									}

									if(par.@spacingAbove && par.@spacingAbove.toString().length>0){
										pardefXml.@spacebefore = par.@spacingAbove;
									}
									if(par.@spacingBelow && par.@spacingBelow.toString().length>0){
										pardefXml.@spaceafter = par.@spacingBelow;
									}

									
									
									par.@def=newId;
									par.parent().insertChildBefore(par,pardefXml);
								}
								continue;
								
							}
						} 
								
					}
				}
					
			}

			return xml;
				
		}

		public static function fixRoyaleDataProvider(xml:XML):XML
		{
			var royaleNamespace:Namespace = new Namespace("j", "library://ns.apache.org/royale/jewel");
			var tabsXML:XMLList = xml..royaleNamespace::TabBar;
			var dataProvider:String = "";
			
			for each (var tab:XML in tabsXML ){

				if(tab.@labelString&& tab.@royaleDataVarName)
				{
					var tabProviderList:Array = tab.@labelString.split(",");
					var tabProviderListStr:String = " ";
					for each (var tabStr:String in tabProviderList )
					{
						tabProviderListStr=tabProviderListStr+"{label:\""+tabStr+"\"}, \n"
					}
					dataProvider=dataProvider+" [Bindable] \n"
					dataProvider=dataProvider+"	public var "+tab.@royaleDataVarName+":ArrayList = new ArrayList([ \n"+tabProviderListStr+"\n ])  \n";

				}

				delete tab.@labelString;
				delete tab.@royaleDataVarName;
				
			}

			var xmlString:String=xml.toString();
			xmlString=xmlString.replace("%tabViewDataProvider%",dataProvider)
			xml=new XML(xmlString);

			return xml;
		}


		private static function handleFleldOneNode(xml:XML,mainFieldsContainer:XML,total_xml:XML):void {
                var children:XMLList = xml.children();
                if ( children.length() == 0 ) {
					
                    //Handle Leaf node -> Create ui object, or whatever 
                } else {
                    //Non terminal node, check children
                    for each (var child:XML in children ) {
						
						var childName:String=child.name();
                        if(childName=="field" || childName== "_moonshineSelected_field"){
                             
                            xml=handleDominoFleldNode(child,mainFieldsContainer,total_xml)
                        }
                        handleFleldOneNode(child,mainFieldsContainer,total_xml);
                    }
                }

			
            }


			private static function handleDominoFleldNode(node:XML,mainFieldsContainer:XML,total_xml:XML):XML{

						var field_name:String = node.attribute("name").toString();
						 //Alert.show("field name 212:"+field_name);
						if(mainFieldsContainer){
							mainFieldsContainer.appendChild(new XML("<text>"+field_name+"</text>"))
						}
                       	return total_xml
			
			}


	





		public static function getDominMainFieldListContainerTag(xml:XML):XML
		{
            var body:XMLList = xml.children();
            for each (var item:XML in body)
            {
                var itemName:String = item.name();
                if (itemName=="http://www.lotus.com/dxl::item" && item.@name=="$Fields")
                {
				
                    return item.children()[0];
                }
            }

			return null;
		}
		
		public static function getParentContent(surface:EditingSurface, title:String, component:UIComponent):XML
		{
            var element:ISurfaceComponent = surface.getElementAt(0) as ISurfaceComponent;
			if (surface.isVisualEditorFlex)
			{
				return getFlexMainContainer(title, element.width, element.height);
			}
			
			return getPrimeFacesMainContainer(title, component,
                    element as view.primeFaces.supportClasses.Container);
		}
		public static function  getRoyaleContainer():XML{
				var dat:Date = new Date();
				var xml_str:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?> \n";
				xml_str=xml_str+"<j:ResponsiveView xmlns:fx=\"http://ns.adobe.com/mxml/2009\" \n";
				xml_str=xml_str+"xmlns:j=\"library://ns.apache.org/royale/jewel\" \n";
				xml_str=xml_str+"xmlns:js=\"library://ns.apache.org/royale/basic\" \n";
				xml_str=xml_str+"xmlns:html=\"library://ns.apache.org/royale/html\" \n";
				xml_str=xml_str+"xmlns:view=\"view.*\" xmlns:listing=\"view.listing.*\" xmlns:edit=\"view.edit.*\">";
				xml_str=xml_str+"<fx:Script>\n";
				xml_str=xml_str+"<![CDATA[ \n";
				xml_str=xml_str+"import classes.events.ScreenEvent; \n";
				xml_str=xml_str+"import view.edit.AddEditView; \n";
				xml_str=xml_str+"import org.apache.royale.collections.ArrayList; \n";
				xml_str=xml_str+"import view.vos.TabBarButtonVO; \n";
				
				


				

				xml_str=xml_str+"	%tabViewDataProvider% \n";

				xml_str=xml_str+"	private function onNavigationChangeRequest(event:ScreenEvent):void";

				xml_str=xml_str+"	{";
				xml_str=xml_str+"	mainContent.selectedContent = event.screenName;";
				xml_str=xml_str+"	}";
				xml_str=xml_str+"	]]>";
				
				xml_str=xml_str+"</fx:Script>";

				xml_str=xml_str+"<j:beads>";
				xml_str=xml_str+"  <js:ContainerDataBinding/>";
				xml_str=xml_str+"</j:beads>";

				// xml_str=xml_str+" <j:ApplicationMainContent id=\"mainContent\" hasTopAppBar=\"false\" hasFooterBar=\"false\" selectedContent=\"ItemsListing\">";

				// xml_str=xml_str+" </j:ApplicationMainContent>";
				xml_str=xml_str+" </j:ResponsiveView>	";



				var xml:XML = new XML(xml_str);
				
			
			

			return xml;
		}
		/**
		 * Overloaded this function, so that the domino project can call it
		 */

		public static function getDominoParentContent(title:String,windowsTitle:String):XML
		{	   
			return getDominoMainContainer(title,windowsTitle);	
		}
		public static function getDominoPageMainContainer(pageName:String):XML
		{
			var dat:Date = new Date();
			var xml_str:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
			xml_str=xml_str+"<!DOCTYPE page>";
			xml_str=xml_str+"<page name='"+pageName+"'";
			xml_str=xml_str+" xmlns='http://www.lotus.com/dxl'";
			xml_str=xml_str+" version='11.0' maintenanceversion='1.0' ";
			xml_str=xml_str+"replicaid='85257C8A00383F9C' publicaccess='false' renderpassthrough='true'>";
			xml_str=xml_str+"<body>" ;
			xml_str=xml_str+"</body>";
			xml_str=xml_str+"<item name='$$ScriptName' summary='false' sign='true'><text>"+pageName+"</text></item>";
			xml_str=xml_str+"</page>";
			var xml:XML = new XML(xml_str)
			
			return xml;
		}

		public static function getDominoSubformMainContainer(subFormName:String):XML
		{
			var dat:Date = new Date();
			var xml_str:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
			xml_str=xml_str+"<!DOCTYPE subform>";
			xml_str=xml_str+"<subform name='"+subFormName+"' version='11.0' maintenanceversion='1.4'  xmlns='http://www.lotus.com/dxl'> ";
			xml_str=xml_str+"<body>" ;
			// xml_str=xml_str+"<richtext>" ;
			// xml_str=xml_str+"</richtext>" ;
			xml_str=xml_str+"</body>";
			xml_str=xml_str+"</subform>";
			var xml:XML = new XML(xml_str);
			
			return xml;
		}
		
		private static function getFlexMainContainer(title:String, width:Number, height:Number):XML
		{
			var xml:XML = new XML("<WindowedApplication></WindowedApplication>");
            var sparkNamespace:Namespace = new Namespace("s", "library://ns.adobe.com/flex/spark");
            xml.addNamespace(sparkNamespace);
            xml.setNamespace(sparkNamespace);
			
            var fxNamespace:Namespace = new Namespace("fx", "http://ns.adobe.com/mxml/2009");
            xml.addNamespace(fxNamespace);
			xml.@title = title;
			xml.@width = width;
			xml.@height = height;
			
			return xml;
		}
		
		private static function getPrimeFacesMainContainer(title:String, element:UIComponent,
														   container:view.primeFaces.supportClasses.Container):XML
		{
			var xml:XML = new XML("<html/>");

            var htmlNamespace:Namespace = new Namespace("", "http://www.w3.org/1999/xhtml");
            xml.addNamespace(htmlNamespace);
            xml.setNamespace(htmlNamespace);

			var hNamespace:Namespace = new Namespace("h", "http://xmlns.jcp.org/jsf/html");
			xml.addNamespace(hNamespace);
			
			var uiNamespace:Namespace = new Namespace("ui", "http://xmlns.jcp.org/jsf/facelets");
			xml.addNamespace(uiNamespace);

			var fNamespace:Namespace = new Namespace("f", "http://xmlns.jcp.org/jsf/core");
			xml.addNamespace(fNamespace);

			var pNamespace:Namespace = new Namespace("p", "http://primefaces.org/ui");
			xml.addNamespace(pNamespace);

			var headXml:XML = new XML("<head/>");
			headXml.addNamespace(hNamespace);
			headXml.setNamespace(hNamespace);

            var relativeFilePath:String = MoonshineBridgeUtils.getRelativeFilePath();

			var cssStyleSheetXml:XML = new XML("<link></link>");
            cssStyleSheetXml.@rel = "stylesheet";
			cssStyleSheetXml.@type = "text/css";
			if (relativeFilePath == "..")
			{
                cssStyleSheetXml.@href = "resources/moonshine-layout-styles.css";
			}
			else
			{
                cssStyleSheetXml.@href = relativeFilePath.substring(relativeFilePath.indexOf("/") + 1) + "/resources/moonshine-layout-styles.css";
            }

            headXml.appendChild(cssStyleSheetXml);

            cssStyleSheetXml = new XML("<link></link>");
            cssStyleSheetXml.@rel = "stylesheet";
            cssStyleSheetXml.@type = "text/css";
            cssStyleSheetXml.@href = relativeFilePath + "/assets/moonshine-layout-styles.css";

			headXml.appendChild(cssStyleSheetXml);

			if (!title)
			{
				title = "";
			}		
			
			var titleXML:XML = new XML("<title>" + title + "</title>");
			headXml.appendChild(titleXML);
			
			var bodyXML:XML = new XML("<body/>");
			bodyXML.addNamespace(hNamespace);
			bodyXML.setNamespace(hNamespace);

			var mainDiv:XML = new XML("<"+ MxmlCodeUtils.getMXMLTagNameWithSelection(container as ISurfaceComponent, "div") +"/>");

            mainDiv["@class"] = XMLCodeUtils.getChildrenPositionForXML(container);
            XMLCodeUtils.addSizeHtmlStyleToXML(mainDiv, element);
			
			bodyXML.appendChild(mainDiv);
			
			xml.appendChild(headXml);
			xml.appendChild(bodyXML);

			return xml;
		}


		private static function getDominoMainContainer(title:String,windowsTitle:String):XML
		{
				var dat:Date = new Date();
				var xml_str:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
				xml_str=xml_str+"<note class='form' xmlns='http://www.lotus.com/dxl' version='9.0' maintenanceversion='1.4' replicaid='4825808B00336E81'>";
				xml_str=xml_str+"<!DOCTYPE note>";
				// xml_str=xml_str+"<noteinfo noteid='2116' unid='27C118EDE31483CB86256C6900644875' sequence='8'>";
				// xml_str=xml_str+"<created><datetime>"+dat+"</datetime></created> ";
				// xml_str=xml_str+"<modified><datetime>"+dat+"</datetime></modified> ";
				// xml_str=xml_str+"<revised dst=\"true\"><datetime>"+dat+"</datetime></revised>";
				// xml_str=xml_str+"<lastaccessed><datetime>"+dat+"</datetime></lastaccessed>";
				// xml_str=xml_str+"<lastaccessed><datetime>"+dat+"</datetime></lastaccessed>";
				// xml_str=xml_str+"<addedtofile><datetime>"+dat+"</datetime></addedtofile>";
				// xml_str=xml_str+"</noteinfo>"
				if(windowsTitle!=null  && windowsTitle!=""){
					xml_str=xml_str+"<item name='$WindowTitle' sign='true'><formula>"+windowsTitle+"</formula></item>"
				}
				xml_str=xml_str+"<item name='$Info' sign='true'><rawitemdata type='1'>hhgBAIAAAAAAgAAAAQABAP///wAQAAAA</rawitemdata></item>"
				xml_str=xml_str+"<item name='$Flags'><text/></item>"
				xml_str=xml_str+"<item name='$TITLE'><text>"+title+"</text></item>"
				xml_str=xml_str+"<item name='$Fields'><textlist></textlist></item>"
				xml_str=xml_str+"<item name='$Body' sign='true'></item>"
				
				xml_str=xml_str+"</note>";
			



				var xml:XML = new XML(xml_str);
				
			
			

			return xml;
		}
	}
}