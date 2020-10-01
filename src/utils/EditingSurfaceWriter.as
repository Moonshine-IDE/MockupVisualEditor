package utils
{
    import mx.core.IVisualElementContainer;
    import mx.core.UIComponent;
    
    import view.EditingSurface;
    import view.interfaces.ISurfaceComponent;

    import view.interfaces.IDominoParagraph;

    import mx.controls.Alert;
    import view.domino.surfaceComponents.components.DominoInputText;

    import components.domino.DominoParagraph;
    import view.primeFaces.surfaceComponents.components.MainApplication;
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
                if(surface.numChildren>0){
                    element = surface.getElementAt(0) as ISurfaceComponent;
                    title = (element as UIComponent).hasOwnProperty("title") ? element["title"] : "";
                }

                //Alert.show("title:"+title);

                if(!title){
                    title=projectName
                }
                
                
                var xml:XML = MainApplicationCodeUtils.getDominoParentContent(title);
                var mainContainer:XML = MainApplicationCodeUtils.getDominMainContainerTag(xml);
                var container:IVisualElementContainer = surface;
                if (element is ISurfaceComponent)
                {
                    container = element as IVisualElementContainer;
                }
                
               

                var elementCount:int = 0;
    
                elementCount = surface.numElements;
                container = surface;
 

              //------------get all field ---------------
            
            
                
                for (var i:int = 0; i < elementCount; i++)
                {
                    element = container.getElementAt(i) as ISurfaceComponent;
                
                   
            
                    if (element === null){
                        continue;
                    }

                    var  element_title:String = (element as UIComponent).hasOwnProperty("title") ? element["title"] : "no title";
                    
                    
                   var hasRichText:Boolean=false;
					XML.ignoreComments = false;
                    var code:XML = element.toCode();
                    //Alert.show("element_title:"+code.toXMLString());
                    if(code!=null ){
                        if(code.name()=="div" || code.name()=="_moonshineSelected_div"){
                             code.setName("richtext");
                             hasRichText=true;
                        }
                   }

               
               

              
                
                if(hasRichText==false){
                    //add new richtext node
                    var richtext:XML = new XML("<richtext style='width:700px;height:700px;' class='flexHorizontalLayout flexHorizontalLayoutLeft flexHorizontalLayoutTop' direction='Horizontal' vdirection='Vertical'/>");
                    mainContainer.appendChild(richtext);
                    mainContainer=richtext;
                }
                  
                  
                    if (mainContainer)
                    {
                        mainContainer.appendChild(code);               
                    }
                    else
                    {
                       xml.appendChild(code);
                    }
                }

                

                


                MainApplicationCodeUtils.fixDominField(xml);

				return xml;
            }
            /**
             * we need make sure the form body must contain a richtext
             */
            
            // public  function checkRichTextNode(mainContainer:XML):Boolean{
               
            // }


            
        }
	}
}