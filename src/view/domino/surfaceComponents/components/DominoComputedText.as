package view.domino.surfaceComponents.components
{
    import interfaces.dominoComponents.IDominoComputedText;
    import view.interfaces.IDominoSurfaceComponent;
    import view.interfaces.IHistorySurfaceComponent;
    import interfaces.IComponentSizeOutput;
    import view.interfaces.ICDATAInformation;
    import flash.events.Event;

    import interfaces.IComponentSizeOutput;

    import spark.layouts.VerticalAlign;
    import spark.components.Label;
    
    import data.OrganizerItem;
    
    import utils.MxmlCodeUtils;
    import utils.XMLCodeUtils;

    import view.interfaces.IHistorySurfaceComponent;
    import view.interfaces.IDominoSurfaceComponent;
    import view.interfaces.IDominoSurfaceComponent;
    import view.primeFaces.propertyEditors.OutputLabelPropertyEditor;
    import view.domino.propertyEditors.DominoComputedTextPropertyEditor;
    import view.suportClasses.PropertyChangeReference;
    import interfaces.components.IOutputLabel;
    //import components.Domino.OutputLabel;

    import components.domino.DominoPar;
    import components.domino.DominoRun;
    import components.domino.DominoFont;
    import components.domino.DominoLabel;

    import mx.collections.ArrayList;

    import mx.controls.Alert;
    import utils.StringHelper;
    [Exclude(name="propertiesChangedEvents", kind="property")]
    [Exclude(name="propertyChangeFieldReference", kind="property")]
    [Exclude(name="propertyEditorClass", kind="property")]
    [Exclude(name="isUpdating", kind="property")]
    [Exclude(name="toXML", kind="method")]
    [Exclude(name="fromXML", kind="method")]
    [Exclude(name="toCode", kind="method")]
    [Exclude(name="commitProperties", kind="method")]
    [Exclude(name="isSelected", kind="property")]
    [Exclude(name="getComponentsChildren", kind="method")]
    [Exclude(name="cdataXML", kind="property")]
    [Exclude(name="cdataInformation", kind="property")]
    public class DominoComputedText extends Label implements IDominoSurfaceComponent, IHistorySurfaceComponent, ICDATAInformation, IComponentSizeOutput
    {
        public static const DOMINO_ELEMENT_NAME:String = "ComputedText";
       
        public static const ELEMENT_NAME:String = "ComputedText";
		private var component:IDominoComputedText;
        public function DominoComputedText()
        {
            super();
            component = new components.domino.DominoComputedText();
			
            this.text = "ComputedText";

            this.setStyle("verticalAlign", VerticalAlign.MIDDLE);

            this.toolTip = "";
            this.width = 100;
            this.height = 30;
            this.minWidth = 20;
            this.minHeight = 20;
            this.maxDisplayedLines = -1;

            _propertiesChangedEvents = [
                "widthChanged",
                "heightChanged",
                "explicitMinWidthChanged",
                "explicitMinHeightChanged",
                "textChanged",
                "sizeChanged",
                "forAttributeChanged",
				"indicateRequiredChanged",
                "colorAttributeChanged",
                "fontStyleAttributeChanged",
                "hidewhenAttributeChanged",
                "formulaAttributeChanged"
            ];
        }
        private var _hidewhen:String;
        /**
         * <p>Domino:Contains formula ,Represents  hide or show the element.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>Domino</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * <img src="data:image/png;base64,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xa5du3w39gPAhAkTfAHv3J+di6tnz8E118xBz549AXjPLW7Y8AZ+99CDAZnu27cPANCrVy++LJYShnWPiMLhuyp12LBhAICqqipUVlai6OxR+O6773wJxVH4oUP+cdu3fwEAuOiiCwMy3bRpEwBgxIgRMSo2ERFRbPgC46RJkwAAr776KrlpYBYAACAASURBVHr37gO3240511yLF198ES+++CKun3cD8vPzkZc3yDfxJ3//BAAwaNCggExfffXVgDyJiIhShS8wzpgxA9nZ2aisrMQPPzTgvXffQc+ePTF/wSLMX7AI06ZNxeuvvRpwznDggIH473vuDsjwk08+QWVlJbKzszFjxoz4LQkREVEUBLx26uGHH8a9996LwsJCvPvuu76rS6364YcfMHnyZNTW1uKBBx7AHXfcEXIaviyWookvKqZUxPsYk0vAs1IXLVqE008/HTt37kRJSQmOHj1qOaOjR4+ipKQEtbW1OPPMM1FWVmZpOrNL6+WnW9h9/mSs8akbqS/UbR3h1j+jvMKZJtF1LNZlCLV+7TwdKl7rKhm2C8VWQGDMysrC888/j759+2LLli244IILsHnz5pCZbN68GRdccAG2bNmCfv364dVXX0WnTp0sF8LosnqzJ+ybCecByXbxPqq2wajuiRv47bzlwkw4ediZJlo7am0+sa7nodav3TeMxAN/+21f0PsYhwwZgo0bN2LWrFn4xz/+gUsvvRTFxcW47LLLMGHCBPTv3x8nT57E3r17UVVVhVdffRUulwsA8JOf/AQvvvii7wpXoraCO0Oi9iMoMAJAXl4ePvzwQzz22GN45JFH4HK5fMFPT05ODm6++WbceOONyMrKinoh5Ycua/83+047vaD3ndGDorXp9fKj9seo3gl6dczoLSh634Vz6sBOHY5WPnbyl9NbmcbubzmcctrZt+jNn9qmNKMvsrKycNttt6GmpgYPPfQQpkyZggEDBiAzMxOZmZkYMGAApkyZgoceegg1NTW47bbbYhIUgeDuFrOXrdp96anRy07lvLVP9Y9W9xqlJr26YaWOWclHO94Ku3XYbj5inFk5reQf7nIZlVFvvnbKabYd9crK3377odtilOXm5mLevHmYN29ePMpjS6wrKI8OKdZSvY6FW/5kCC5mAT0ZykeJEzIwtmf8cZAQq7dppHodS+Xy672nkgjQ3McY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sgV79zZg81Y31r2yHR986L0KlS8qJqL2IiAwnn766di6dSvOO++8lDg315boPXzdKofDgV27duH00083DYwAkJ/XDVtcC/HIY1vwcPlH+ODDr33BT09uThYWl43DzTf+nC1FImoXfBffNDY2oqqqCo888giOHuXjvlJNnz59MHfuXIwePdr30INQjniO4cWXarDx3a+wfce3+PbbRgDeBwKMOKMvLr5wOK66ciS65fL1UlHGKyrIEl58kxi+wHj8+HE0NTWFbHFQ8nI4HMjKykLHjtZfQkwJwb0dWcLAmBi+wEhEccO9HVnCwJgYPJFIREQkYWAkIiKSMDASERFJGBiJiIgkDIxEREQSBkYiIiIJAyMREZGEgZGIiEjCwEhERCRhYCQiIpIwMBIREUkYGImIiCQZ8j+NjY34wx/+oJvwwgsvxMiRI+NSKDPPPvssDh48iPnz51t+vRIREZFVAW/X+OabbzBo0CDdhI8//jgWLlwYt4IZOfvss1FdXY3du3cjPz8/0cUhCgdfmUCW8O0aiZGhNzInJwcvvPBCwLgzzzwzLgUiIiJKJN1zjB07dsQll1wSMIiW5MaNGzF58mR06dIFQ4cOhdPpxMmTJwEADz74IAoLC7Fo0SLk5ubioosuwj333IPCwkLcf//9KCgoQG5uLm666Sa8/PLLGD58OLp3746FCxf6XpA8ZcoUFBYW4siRIwCARx99FIWFhXj22Wd1F+BPf/oTxo4di06dOqF79+6YP38+Tpw4AQC44oorUFhYiL1790Z3rRERUdulSPbs2aMAUDp27Kj88pe/9A333HOPoiiK8uGHHyodO3ZUHA6HMn78eKVr164KAOXGG29UFEVRFi9erABQACgFBQXK/Pnzleuvv14BoHTq1EmZN2+e0r17dwWAkp6ersyZM0fp1q2bAkB5/fXXFUVRlMLCQgWAUl9fryiKojidTgWAUl5eriiKohQVFSkAlN27dys1NTVKZmam0r9/f2XRokXKwIEDFQDKK6+8oiiKoowaNUoBoHz99dcKURIBBw5WBkoM3Rbj8ePH8cILL/iGN998EwDwxBNP4Pjx41i6dCkqKyvx+eefA/Cef2xsbPRNP2vWLOzcuROrVq3yjfuv//ovrF69GjNmzAAAzJ8/H88++yxmz54NAPjXv/5lu/DDhg3Dpk2b8Oabb2LmzJk444wzAABff/01AOCDDz7A999/j8GDB9vOm4iI2ifdc4w9e/ZEbW2tP1GGN1lNTQ0AYNKkSQCAoUOHYvDgwdi9e3dAYDv//PMBBJ44Hj58OAAgNzcXAFBYWAgA6Nu3LwD4uj+F1tZWAEBzc7Nh4VtbW7FixQq88sorOHHiBLp06QIAvq7d7Oxsw2mJiIj06LYY09LS0K1bN98gbos4/fTTAQCffvopAODgwYOoq6sDAOTl5fmmP+WUU4Ly7NixIwB/sMzKytItkAjCP/74IwCgvr7esPArV67E2rVrMW3aNOzbtw933XVXwDyIiIjssnWD/+WXXw4A+PWvf43rrrsOY8eORWtrK6666ipfSxDwBtZwDRs2DABw2223wel04umnnzZMK+Zz5MgRvPnmm1i5ciUA4OjRowC8LdsePXr4gjcREVEotiLY1VdfjccffxzZ2dmoqKjA7t27MXv27KCHAui12IyCpRgvPu+66y706tUL69evxx/+8AfMmTMnIE85n7lz52Ls2LF4//33ceONN2LixIkAgL/97W8AgIaGBhw+fNjXLUtERBRKwA3+duzfvx89evTwdZFGk6Io2L9/P/r3728p/aFDh5CdnR2TshDFAPv6yRKeFkqMsAMjEYWNezuyhIExMfgQcSIiIgkDIxERkYSBkYiISMLASEREJGFgJCIikgQ8Eu6BBx7gmyiIQhgwYADuvPPORBeDiGIkIDDu3bsXv/71rxNVFqKU8NBDDyW6CEQUQ0EPERfvXSQiImqPeI6RiIhIwsBIREQkYWAkIiKSMDASERFJGBiJiIgkDIxEREQSBkYiIiIJAyMREZGEgZGIiEjCwEhERCRhYCQiIpIwMBIREUkYGImIiCQMjERERBIGRiIiIgkDIxERkYSBkYiISMLASEREJGFgJCIikjAwEhERSRgYiYiIJAyMREREEgZGIiIiCQMjERGRhIGRiIhIwsBIREQkYWAkIiKSMDASERFJGBiJiIgkDIxEREQSBkYiIiIJAyMREZGEgZGIiEjCwEhERCRhYCQiIpIwMBIREUkYGImIiCQMjERERBIGRiIiIgkDIxERkYSBkYiISMLASEREJGFgJCIikjAwEhERSRgYiYiIJAyMREREEgZGIiIiCQMjERGRhIGRiIhIwsBIREQkYWAkIiKSMDASERFJGBiJiIgkDIxEREQSBkYiIiIJAyMREZGEgZGIiEjCwEhERCRhYCQiIpIwMBIREUkYGImIiCQMjERERJL/344do0gMQ1EQXOFJdFWDr+PTGjxpR5MtwrgqU/aCDw0SRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSAEEYACGEEgBBGAAhhBIAQRgAIYQSA+PQx5/w7jmPVFniEOefqCcA/Gvd936tHwMuM1QN4hjGcygq+UgEghBEAQhgBIIQRAEIYASCEEQBCGAEghBEAQhgBIIQRAEIYASCEEQBCGAEghBEAQhgBIIQRAEIYASCEEQBCGAEghBEAQhgBIIQRAEIYASCEEQBCGAEghBEAQhgBIIQRAEIYASCEEQBCGAEgPvu+r94Ar3Ke5+oJwA/juq579Qh4k23bxuoNPMMYTmUFX6kAEMIIACGMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAC8xRcWzNCnknJh7AAAAABJRU5ErkJggg=="  width="454" height="794"/>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText hidewhen=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;formula &gt; &lt;formula /&gt;</listing>
         */
        [Bindable(event="hidewhenAttributeChanged")]
		public function get hidewhen():String
		{
			return _hidewhen;
		}
		public function set hidewhen(value:String):void
		{
			if (_hidewhen != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "hidewhen", _hidewhen, value);
				
                _hidewhen = value;
                dispatchEvent(new Event("hidewhenAttributeChanged"))
            }
		}


        [Inspectable(category="General", defaultValue="Label")]
        [Bindable("textChanged")]
        
        override public function get text():String
        {
            return super.text;
        }

		override public function set text(value:String):void
		{
			if (super.text != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "text", super.text, value);
				
				super.text = value;
				dispatchEvent(new Event("textChanged"));
			}
		}


        private var _widthOutput:Boolean = true;
        protected var widthOutputChanged:Boolean;
         /**
         * <p>General:This is a general property to set if allow seting width.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText widthOutput=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText widthOutput=""/&gt;</listing>
         */

        [Bindable]
        public function get widthOutput():Boolean
        {
            return _widthOutput;
        }

        public function set widthOutput(value:Boolean):void
        {
            if (_widthOutput != value)
            {
                _widthOutput = value;

                if (!value)
                {
                    widthOutputChanged = true;
                    this.invalidateProperties();
                }
            }
        }

        private var _heightOutput:Boolean = true;
        /**
         * <p>General:This is a general property to set if allow seting heght.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText heightOutput=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText heightOutput=""/&gt;</listing>
         */
        protected var heightOutputChanged:Boolean;

        [Bindable]
        public function get heightOutput():Boolean
        {
            return _heightOutput;
        }

        public function set heightOutput(value:Boolean):void
        {
            if (_heightOutput != value)
            {
                _heightOutput = value;

                if (!value)
                {
                    heightOutputChanged = true;
                    this.invalidateProperties();
                }
            }
        }

        public function get propertyEditorClass():Class
        {
            return DominoComputedTextPropertyEditor;
        }

        private var _propertiesChangedEvents:Array;

        public function get propertiesChangedEvents():Array
        {
            return _propertiesChangedEvents;
        }

        private var _propertyChangeFieldReference:PropertyChangeReference;
        public function get propertyChangeFieldReference():PropertyChangeReference
        {
            return _propertyChangeFieldReference;
        }

        public function set propertyChangeFieldReference(value:PropertyChangeReference):void
        {
            _propertyChangeFieldReference = value;
        }

        private var _isUpdating:Boolean;
        /**
         * <p>General:This is a general property to show the field already be updating or not.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText isUpdating=""/&gt;</listing>
         */
        public function get isUpdating():Boolean
        {
            return _isUpdating;
        }

        public function set isUpdating(value:Boolean):void
        {
            _isUpdating = value;
        }
		
		private var _isSelected:Boolean;
        /**
         * <p>General:This is a general property to show the field already be selected or not.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText isSelected=""/&gt;</listing>
         */

		public function get isSelected():Boolean
		{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void
		{
			_isSelected = value;
		}

        private var _cdataXML:XML;

        public function get cdataXML():XML
        {
            return _cdataXML;
        }

        private var _cdataInformation:String;

        public function get cdataInformation():String
        {
            return _cdataInformation;
        }

        private var _indicateRequired:Boolean;
        private var indicateRequiredChanged:Boolean;
		
		[Bindable("indicateRequiredChanged")]
        /**
         * <p>General:This is a general property to show the field if need indicate.</p>
         * <table border="1"><tr><td>notes Client</td><td>N/A</td></tr>
         * <tr><td>Apache Royale</td><td>N/A</td></tr>
         * <tr><td>Domino</td><td>N/A</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>N/A</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText indicateRequired=""/&gt;</listing>
         */
        public function get indicateRequired():Boolean
        {
            return _indicateRequired;
        }
		
        public function set indicateRequired(value:Boolean):void
        {
            if (_indicateRequired != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "indicateRequired", _indicateRequired, value);
				
                _indicateRequired = value;
                indicateRequiredChanged = true;
                invalidateProperties();
				dispatchEvent(new Event("indicateRequiredChanged"));
            }
        }

      
        /****************************************************************
         * font color for lable
         * https://help.hcltechsw.com/dom_designer/10.0.1/basic/H_DEFINED_ENTITIES_XML.html
         * aqua | black | blue | fuchsia | gray | green | lime | 
         * maroon | navy | olive |purple | red | silver | teal |
         * white | yellow | none | system " 
         */
        [Bindable]
        private var _colors:ArrayList = new ArrayList([
        {label: "aqua",description: "aqua color.",htmlcolor:"#00FFFF"},
        {label: "black",description:"",htmlcolor:"#000000"},
        {label: "blue",description:"",htmlcolor:"#0000FF"}, 
        {label: "fuchsia",description:"",htmlcolor:"#FF00FF"},
        {label: "gray",description:"",htmlcolor:"#808080"},
        {label: "green",description:"",htmlcolor:"#008000"},
        {label: "lime",description:"",htmlcolor:"#00FF00"},
        {label: "maroon",description:"",htmlcolor:"#800000"},
        {label: "navy",description:"",htmlcolor:"#000080"},
        {label: "olive",description:"",htmlcolor:"#808000"},
        {label: "purple",description:"",htmlcolor:"#800080"},
        {label: "red",description:"",htmlcolor:"#FF0000"},
        {label: "silver",description:"",htmlcolor:"#C0C0C0"},
        {label: "teal",description:"",htmlcolor:"#008080"},
        {label: "white",description:"",htmlcolor:"#ffffff"},
        {label: "yellow",description:"",htmlcolor:"#FFFF00"},
        {label: "none",description:"",htmlcolor:"#000000"},
        {label: "system",description:"A preset color. For instance, the font color of a hotspot link is 'system' because it is determined by the %link.color.attrs; property settings for a form.",
        htmlcolor:"#4B0082"}
        ]);

        public function get colors():ArrayList
        {
            return _colors;
        }


        private var _color:String = "system";
		[Bindable(event="colorAttributeChanged")]
        public function get color():String
        {
            return _color;
        }
		
        public function set color(value:String):void
        {
            if (_color != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "color", _color, value);
				
                _color = value;
                var html_color:String =null;
                for(var i:int=0; i<_colors.length; i++)
                {
                 
                  if(_colors.getItemAt(i).label==value){
                      html_color=_colors.getItemAt(i).htmlcolor
                  }
                }

                if(html_color!=null){
                     super.setStyle("color",html_color);
                }
               
                dispatchEvent(new Event("colorAttributeChanged"))
            }
        }


        private var _formula:String;
        [Bindable(event="formulaAttributeChanged")]
         /**
         * <p>Domino:A field that contains an function or command formula, the formual will calculation and show the result when it display.</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>Domino</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * <img src="data:image/png;base64,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BsIIAICBMAIAYCCMAAAYCCMAAAbCCACAgTACAGAgjAAAGAgjAAAGwggAgIEwAgBgIIwAABgIIwAABsIIAICBMAIAYCCMAAAYCCMAAAbCCACAgTACAGAgjAAAGAgjAAAGwggAgIEwAgBgIIwAABgIIwAABsIIAICBMAIAYCCMAAAYCCMAAAbCCACAgTACAGAgjAAAGAgjAAAGwggAgIEwAgBgIIwAABgIIwAABsIIAICBMAIAYCCMAAAYCCMAAAbCCACAgTACAGAgjAAAGAgjAAAGwggAgIEwAgBgIIwAABgIIwAABsIIAICBMAIAYCCMAAAYCCMAAAbCCACAgTACAGAgjAAAGAgjAAAGwggAgIEwAgBgIIwAABgIIwAABsIIAICBMAIAYCCMAAAYCCMAAAbCCACAgTACAGAgjAAAGAgjAAAGwggAgIEwAgBgIIwAABgIIwAABsIIAICBMAIAYCCMAAAYCCMAAAbCCACAgTACAGAgjAAAGAgjAAAGwggAgIEwAgBgIIwAABgIIwAABsIIAICBMAIAYCCMAAAYCCMAAAbCCACAgTACAGAgjAAAGAgjAAAGwggAgIEwAgBgIIwAABgIIwAABsIIAICBMAIAYCCMAAAYCCMAAAbCCACAgTACAGAgjAAAGAgjAACG/weiJAnOhRi0EgAAAABJRU5ErkJggg=="  width="454" height="794"/>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText hidewhen=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0"> &lt;code /&gt;   &lt;formula &gt; &lt;formula /&gt; &lt;code /&gt;</listing>
         */
		public function get formula():String
		{
			return _formula;
		}
		public function set formula(value:String):void
		{
			if (_formula != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "formula", _formula, value);
				
                _formula = value;
                dispatchEvent(new Event("formulaAttributeChanged"))
            }
		}

        //------------font style--------------------------------------------

        //<!ENTITY % font.styles "normal | bold | italic | underline | strikethrough | superscript | subscript | shadow | emboss | extrude">
        [Bindable]
        private var _fontStyles:ArrayList = new ArrayList([
              {label: "normal",description: "normal",value:"normal",enabled:true},
              {label: "bold",description: "bold",value:"bold",enabled:true},
              {label: "italic",description: "italic",value:"italic",enabled:true},
              {label: "underline",description: "underline",value:"underline",enabled:true},
              {label: "strikethrough",description: "strikethrough",value:"strikethrough",enabled:true},
              {label: "superscript",description: "superscript",value:"superscript",enabled:true},
              {label: "shadow",description: "shadow",value:"shadow",enabled:true},
              {label: "emboss",description: "emboss",value:"emboss",enabled:true},
              {label: "extrude",description: "extrude",value:"extrude",enabled:true},
              {label: "subscript",description: "subscript",value:"subscript",enabled:true},
              
        ])


         public function get fontStyles():ArrayList
        {
            return _fontStyles;
        }



        private var _fontStyle:String = "normal";
		[Bindable(event="fontStyleAttributeChanged")]
        public function get fontStyle():String
        {
            return _fontStyle;
        }
		
        public function set fontStyle(value:String):void
        {
            if (_fontStyle != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "fontStyle", _fontStyle, value);
				
                _fontStyle = value;
                
               
                dispatchEvent(new Event("colorAttributeChanged"))
            }
        }

        //------------color setting end------------------------------------------------
        [Bindable("sizeChanged")]
        /**
         * <p>Domino:text size .</p>
         * <table border="1"><tr><td>notes Client</td><td>Supported</td></tr>
         * <tr><td>Apache Royale</td><td>Planned</td></tr>
         * <tr><td>Domino</td><td>Planned</td></tr>
         * <tr><td>Flex</td><td>Supported</td></tr>
         * <tr><td>GSP</td><td>Supported</td></tr>
         * </table>
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;InputText size=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;InputText size=""/&gt;</listing>
         */

         private var _size:String = "12";
         public function get size():String
        {
            return  this._size ;
        }

		 public function set size(value:String):void
		{
			if (this._size != value)
			{
				_propertyChangeFieldReference = new PropertyChangeReference(this, "size", this._size, value);
				
				this._size = value;
               
                super.setStyle("fontSize",value);
				dispatchEvent(new Event("sizeChanged"));
			}
		}


        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>Domino: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel percentWidth="80"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="width:80%;"/&gt;</listing>
         */
        override public function get percentWidth():Number
        {
            return super.percentWidth;
        }

        [PercentProxy("percentWidth")]
        [Inspectable(category="General")]
        [Bindable("widthChanged")]
        /**
         * <p>Domino: <strong>style</strong></p>
         *
         * @default "100"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel width="100"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get width():Number
        {
            return super.width;
        }

        [Inspectable(environment="none")]
        [Bindable("resize")]
        /**
         * <p>Domino: <strong>style</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel percentHeight="80"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="height:80%;"/&gt;</listing>
         */
        override public function get percentHeight():Number
        {
            return super.percentHeight;
        }

        [PercentProxy("percentHeight")]
        [Inspectable(category="General")]
        [Bindable("heightChanged")]
        /**
         * <p>Domino: <strong>height</strong></p>
         *
         * @default "30"
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel height="30"/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;p:outputLabel style="width:100px;height:30px;"/&gt;</listing>
         */
        override public function get height():Number
        {
            return super.height;
        }

        private var _forAttribute:String;

        [Bindable("forAttributeChanged")]
        /**
         * <p>Domino: <strong>for</strong></p>
         *
         * @example
         * <strong>Visual Editor XML:</strong>
         * <listing version="3.0">&lt;OutputLabel for=""/&gt;</listing>
         * @example
         * <strong>Domino:</strong>
         * <listing version="3.0">&lt;h:outputLabel for=""/&gt;</listing>
         */
        public function get forAttribute():String
        {
            return _forAttribute;
        }

        public function set forAttribute(value:String):void
        {
            if (_forAttribute != value)
            {
				_propertyChangeFieldReference = new PropertyChangeReference(this, "forAttribute", _forAttribute, value);
				
                _forAttribute = value;
                dispatchEvent(new Event("forAttributeChanged"));
            }
        }

        	//-------------other componetn end-------------
		
		

        public function toXML():XML
        {
            var xml:XML = new XML("<" + ELEMENT_NAME +">computed text</"+ELEMENT_NAME+ ">");
            if(this.size){
                xml.@size = this.size;
            }

            if(this.color){
                xml.@color = this.color;
            }
            if(this.formula){
                 xml.@formula = StringHelper.base64Encode(this.formula);;
            }

            if(this.fontStyle){
                xml.@style = this.fontStyle;
            }
            
            if(this.hidewhen){
                var encodeFormulaStr:String= StringHelper.base64Encode(this.hidewhen);
                 xml.@hidewhen = encodeFormulaStr;
            }

            return xml;
        }

        public function fromXML(xml:XML, callback:Function):void
        {
            XMLCodeUtils.setSizeFromXMLToComponent(xml, this);
           
			component.fromXML(xml, callback);
           
            this.formula = component.formula;
            this.color = component.color;
            this.size = component.size;
            this.fontStyle=component.fontStyle;
            if(component.formula){
                
               this.formula=  StringHelper.base64Decode(component.formula);
            }


        }

        public function toCode():XML
        {
			component.formula = this.formula;
            component.size = this.size;
            component.color = this.color;
            component.fontStyle = this.fontStyle;
			//component.forAttribute = this.forAttribute;
			//component.indicateRequired = this.indicateRequired;
			
			component.isSelected = this.isSelected;
            component.hidewhen = this.hidewhen;
		
            return component.toCode();
        }

        public	function toRoyaleConvertCode():XML
		{
			var xml:XML = new XML("");
			return xml;
		}
        public function toRora():XML
        {
            return null;
        }
		
		public function getComponentsChildren(...params):OrganizerItem
		{
			// @note @return
			// children = null (if not a drop acceptable component, i.e. text input, button etc.)
			// children = [] (if drop acceptable component, i.e. div, tab etc.)
			return (new OrganizerItem(this, ELEMENT_NAME, null));
		}

         override protected function commitProperties():void
        {
            super.commitProperties();

          

            if (this.widthOutputChanged)
            {
                this.percentWidth = Number.NaN;
                this.width = Number.NaN;
                this.widthOutputChanged = false;
            }

            if (this.heightOutputChanged)
            {
                this.percentHeight = Number.NaN;
                this.height = Number.NaN;
                this.heightOutputChanged = false;
            }
        }
    }

}