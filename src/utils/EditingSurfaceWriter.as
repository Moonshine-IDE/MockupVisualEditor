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
                    title = (element as UIComponent).hasOwnProperty("path") ? element["path"] : "";
                
                }

              
                
               
                var xml:XML = MainApplicationCodeUtils.getDominoParentContent(projectName);
                var mainContainer:XML = MainApplicationCodeUtils.getDominMainContainerTag(xml);
                var container:IVisualElementContainer = surface;
                if (element is ISurfaceComponent)
                {
                    container = element as IVisualElementContainer;
                }
                
               

                var elementCount:int = 0;
                // if (!container )
                // {
                    elementCount = surface.numElements;
                    container = surface;
                // } 
                // else
                // {
                //     elementCount = container.numElements;
                // }

                
              //------------get all field ---------------
            
            
                
                for (var i:int = 0; i < elementCount; i++)
                {
                    element = container.getElementAt(i) as ISurfaceComponent;
                
                   
            
                    if (element === null){
                        continue;
                    }
                    
                  
					XML.ignoreComments = false;
                    var code:XML = element.toCode();

                    //If it is IDominoParagraph node ,it need add other node
                    
                    
                  
                    
                    //if element is field ,we need add it into textlist
                    
                    
					// var commentOnlyXML:XMLList = (code.elements(VisualEditorGlobalTags.PRIME_FACES_XML_COMMENT_ONLY).length() > 0) ?
					// 	code.elements(VisualEditorGlobalTags.PRIME_FACES_XML_COMMENT_ONLY) : null;
                   if(code!=null && code !=undefined){
                        if(code.name()=="div"){
                             code.setName("richtext");
                        }
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


            
        }
	}
}