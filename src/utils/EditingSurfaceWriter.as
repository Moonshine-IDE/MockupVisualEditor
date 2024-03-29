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
    import mx.core.IVisualElementContainer;
    import mx.core.UIComponent;
    
    import view.EditingSurface;
    import view.interfaces.ISurfaceComponent;
    import view.primeFaces.surfaceComponents.components.MainApplication;
    import interfaces.IRoyaleComponentConverter;

	import mx.controls.Alert;
    import view.domino.formEditor.object.FormObject;

    public class EditingSurfaceWriter
	{
		public static function toXML(surface:EditingSurface, visualEditorType:String):XML
		{
			var xml:XML = <mockup/>;
            var container:XML = null;
           
            if (visualEditorType == VisualEditorType.PRIME_FACES)
            {
                container = surface.numElements == 0 ? MainApplicationCodeUtils.appendXMLMainTag(surface) : null;
            }

            if (visualEditorType == VisualEditorType.DOMINO)
            {
                 container = surface.numElements == 0 ? MainApplicationCodeUtils.appendDominoXMLMainTag(surface) : null;
            }

			var elementCount:int = surface.numElements;
         	for(var i:int = 0; i < elementCount; i++)
			{
				var element:ISurfaceComponent = surface.getElementAt(i) as ISurfaceComponent;
				if(element === null)
				{
					continue;
				}
                
				var elementXML:XML = element.toXML();
                    xml.appendChild(elementXML);
			}
           
           

            if (container)
            {
               
                xml.appendChild(container);
            }

         
			return xml;
		}

		CONFIG::MOONSHINE
        {
            public static function toCode(surface:EditingSurface):XML
             {
                var element:ISurfaceComponent = surface.getElementAt(0) as ISurfaceComponent;
                var title:String = (element as UIComponent).hasOwnProperty("path") ? element["path"] : "";
                var xml:XML = MainApplicationCodeUtils.getParentContent(surface, title, element as UIComponent);
                var mainContainer:XML = MainApplicationCodeUtils.getMainContainerTag(xml);

                var container:IVisualElementContainer = surface;
                if (element is ISurfaceComponent)
                {
                    container = element as IVisualElementContainer;
                }

                if(element is MainApplication){
                   // (element as MainApplication).setDomino(false); 
                }

                var elementCount:int = 0;
                if (!container)
                {
                    elementCount = surface.numElements;
                    container = surface;
                }
                else
                {
                    elementCount = container.numElements;
                }


                for (var i:int = 0; i < elementCount; i++)
                {
                    element = container.getElementAt(i) as ISurfaceComponent;

                    if (element === null)
                    {
                        continue;
                    }

					XML.ignoreComments = false;
                    var code:XML = element.toCode();
					var commentOnlyXML:XMLList = (code.elements(VisualEditorGlobalTags.PRIME_FACES_XML_COMMENT_ONLY).length() > 0) ?
						code.elements(VisualEditorGlobalTags.PRIME_FACES_XML_COMMENT_ONLY) : null;
                    if (mainContainer)
                    {
                        mainContainer.appendChild(!commentOnlyXML ? code : commentOnlyXML.children());
                    }
                    else
                    {
                        xml.appendChild(!commentOnlyXML ? code : commentOnlyXML.children());
                    }
                }

				return xml;
            }
            /**
             * Add the project_type parameter, so that the domino project type
             * can call this method 
             */
            public static function toDominoCode(surface:EditingSurface,projectName:String):XML
            {
                var element:ISurfaceComponent ;
                var title:String ="";
                var windowsTitle:String = "";
                var formObject:FormObject = new FormObject();
                if(surface.numChildren>0){
                    element = surface.getElementAt(0) as ISurfaceComponent;
                    title = (element as UIComponent).hasOwnProperty("title") ? element["title"] : "";
                    windowsTitle= (element as UIComponent).hasOwnProperty("windowsTitle") ? element["windowsTitle"] : "";
                    formObject.noreplace= (element as UIComponent).hasOwnProperty("noreplace")? element["noreplace"] : false;
                    formObject.propagatenoreplace= (element as UIComponent).hasOwnProperty("propagatenoreplace")? element["propagatenoreplace"] : false;
                    formObject.hide= (element as UIComponent).hasOwnProperty("hide")? element["hide"] : "";
                }

                if(!title)
                {
                    title=projectName
                }

                var xml:XML;
                var mainContainer:XML;
               
                if(surface.visualEditorFileType&& surface.visualEditorFileType=="page"){
                    xml= MainApplicationCodeUtils.getDominoPageMainContainer(title,windowsTitle);
                    mainContainer = MainApplicationCodeUtils.getDominPageMainContainerTag(xml);
                   
                }else if(surface.visualEditorFileType&& surface.visualEditorFileType=="shareField"){
                   
                }else if(surface.visualEditorFileType&& surface.visualEditorFileType=="subform"){
                    xml= MainApplicationCodeUtils.getDominoSubformMainContainer(title);
                    mainContainer = MainApplicationCodeUtils.getDominPageMainContainerTag(xml);
                }else{
                    xml  = MainApplicationCodeUtils.getDominoParentContent(title,windowsTitle,formObject);
                    mainContainer = MainApplicationCodeUtils.getDominMainContainerTag(xml);
                }

               



                var container:IVisualElementContainer = surface;
                if (element is ISurfaceComponent)
                {
                    container = element as IVisualElementContainer;
                }

                var elementCount:int = 0;
    
                elementCount = surface.numElements;
                container = surface;

              

              //------------get all field ---------------
            
            
                var hasRichText:Boolean=false;
                for (var i:int = 0; i < elementCount; i++)
                {
                    element = container.getElementAt(i) as ISurfaceComponent;

                    if (element === null){
                        continue;
                    }

					XML.ignoreComments = false;
                    var code:XML = element.toCode();
                    //Alert.show("element_title:"+code.toXMLString());
                    if(code!=null ){
                        if(code.name()=="div" || code.name()=="_moonshineSelected_div"){
                             code.setName("richtext");
                             hasRichText=true;
                          
                        }
                   }

                    if(hasRichText==false)
                    {
                        //add new richtext node
                        //Alert.show("add rich:"+code.toXMLString());
                        var richtext:XML = new XML("<richtext style='width:700px;height:700px;' class='flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop' direction='Horizontal' vdirection='Vertical'/>");
                        mainContainer.appendChild(richtext);
                        mainContainer=richtext;
                    }
                  
                  
                    if (mainContainer)
                    {
                        mainContainer.appendChild(code); 
                        if(code.name()=="richtext"){
                            mainContainer=code;
                        }              
                    }
                    else
                    {
                       xml.appendChild(code);
                    }
                }

                

                


                MainApplicationCodeUtils.fixDominField(xml);
                MainApplicationCodeUtils.fixPardefTableError(xml);
                MainApplicationCodeUtils.fixPardefAlign(xml);
                MainApplicationCodeUtils.fixDivInDxl(xml);
				

                  // if this is empty page , we need add some default element , then it can work fine with Notes client 
                if(surface.visualEditorFileType&& surface.visualEditorFileType=="page"){
                  if(elementCount<2){
                    var firstChildList:XMLList= xml..richtext;
                     if(firstChildList!=null){
                            var firstChild:XML=firstChildList[0];
                            if(firstChild!=null){
                                var firstChildChildList:XMLList=firstChild.children();

                                if(firstChildChildList.length()==0){
                                    firstChild.appendChild(new XML("<pardef id='1'/>"));
                                    firstChild.appendChild(new XML("<par def='1'/>"));
                                    firstChild.appendChild(new XML("<par def='1'>NOTE: This is a template for domino page.  DO NOT MODIFY THIS BY HAND.</par>"));
                                }
                            }
                    }
                   
                  }
                }
                //if it is empty form, it need some default element into it
                for each(var richtext:XML in xml..richtext){
                    if(richtext.children().length()==0){
                        richtext.appendChild(new XML("<pardef id='1'/>"));
                        richtext.appendChild(new XML("<par def='1'/>"));
                        richtext.appendChild(new XML("<par def='1'></par>"));
                    }
                }
                
                 return xml;
            }

             public static function aottoDominoCodeCovert(surfaceContainer:IVisualElementContainer):XML
             {
                var element:ISurfaceComponent ;
                var title:String ="";
                var windowsTitle:String = "";
                var formObject:FormObject = new FormObject();
                if(surfaceContainer==null){
                    Alert.show("surfaceContainer is null");
                }
                if(surfaceContainer.numElements>0){
                    element = surfaceContainer.getElementAt(0) as ISurfaceComponent;
                    title = (element as UIComponent).hasOwnProperty("title") ? element["title"] : "";
                    windowsTitle= (element as UIComponent).hasOwnProperty("windowsTitle") ? element["windowsTitle"] : "";
                    formObject.noreplace= (element as UIComponent).hasOwnProperty("noreplace")? element["noreplace"] : false;
                    formObject.propagatenoreplace= (element as UIComponent).hasOwnProperty("propagatenoreplace")? element["propagatenoreplace"] : false;
                    formObject.hide= (element as UIComponent).hasOwnProperty("hide")? element["hide"] : "";
                    
                }else{
                      Alert.show("surfaceContainer child is 0");
                }

               

                //Alert.show("title:"+title);

                // if(!title){
                //     title=projectName
                // }
                
                
                var xml:XML;
                var mainContainer:XML;
               
                xml  = MainApplicationCodeUtils.getDominoParentContent(title,windowsTitle,formObject);
                mainContainer = MainApplicationCodeUtils.getDominMainContainerTag(xml);
              
               
                
                var container:IVisualElementContainer;
                if (element is ISurfaceComponent)
                {
                    container = element as IVisualElementContainer;
                }else{
                    container=surfaceContainer;
                }
                
               

                var elementCount:int = 0;
    
                elementCount = surfaceContainer.numElements;
               
 
            
              //------------get all field ---------------
            
            
                var hasRichText:Boolean=false;
                for (var i:int = 0; i < elementCount; i++)
                {
                    element = container.getElementAt(i) as ISurfaceComponent;

                    if (element === null){
                        continue;
                    }

					XML.ignoreComments = false;
                    var code:XML = element.toCode();
                    //Alert.show("element_title:"+code.toXMLString());
                    if(code != null)
                    {
                        if(code.name()=="div" || code.name()=="_moonshineSelected_div"){
                             code.setName("richtext");
                             hasRichText=true;
                          
                        }
                   }

                    if(hasRichText==false){
                        //add new richtext node
                        //Alert.show("add rich:"+code.toXMLString());
                        var richtext:XML = new XML("<richtext style='width:700px;height:700px;' class='flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop' direction='Horizontal' vdirection='Vertical'/>");
                        mainContainer.appendChild(richtext);
                        mainContainer=richtext;
                    }

                    if (mainContainer)
                    {
                        mainContainer.appendChild(code); 
                        if(code.name()=="richtext"){
                            mainContainer=code;
                        }              
                    }
                    else
                    {
                       xml.appendChild(code);
                    }
                }

                MainApplicationCodeUtils.fixDominField(xml);
                MainApplicationCodeUtils.fixPardefTableError(xml);
                MainApplicationCodeUtils.fixPardefAlign(xml);
				return xml;
             }
            /**
             * we need make sure the form body must contain a richtext
             */
            
            // public  function checkRichTextNode(mainContainer:XML):Boolean{
               
            // }


            public static function toRoyaleCode(surface:EditingSurface,projectName:String):XML
            {
                var element:ISurfaceComponent;
                
                var xml:XML = MainApplicationCodeUtils.getRoyaleContainer();
                var container:IVisualElementContainer = surface;
                
                var elementCount:int = 0;
                if (!container)
                {
                    elementCount = surface.numElements;
                    container = surface;
                }
                else
                {
                    elementCount = container.numElements;
                }

                for (var i:int = 0; i < elementCount; i++)
                {
                    element = container.getElementAt(i) as ISurfaceComponent;
                	XML.ignoreComments = false;

                    var royaleElement:IRoyaleComponentConverter = (element as IRoyaleComponentConverter);

                    if (royaleElement)
                    {
                        var code:XML = royaleElement.toRoyaleConvertCode();

                        xml.appendChild(code);
                    }
                }

                xml = MainApplicationCodeUtils.fixRoyaleDataProvider(xml);

				return xml;
            }

            
        }
	}
}