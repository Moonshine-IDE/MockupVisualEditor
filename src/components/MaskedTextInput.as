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
package components
{
    import flash.events.Event;
    import flash.events.TextEvent;

    import flashx.textLayout.edit.EditManager;

    import flashx.textLayout.edit.SelectionState;
    import flashx.textLayout.operations.CompositeOperation;
    import flashx.textLayout.operations.CopyOperation;
    import flashx.textLayout.operations.DeleteTextOperation;
    import flashx.textLayout.operations.InsertTextOperation;

    import mx.utils.StringUtil;

    import spark.components.RichEditableText;

    import spark.components.TextInput;
    import spark.events.TextOperationEvent;
    import flashx.textLayout.tlf_internal;
    use namespace tlf_internal;

    public class MaskedTextInput extends TextInput
    {
        private static const RESTRICTION_NUMBERS:String = "9";
        private static const RESTRICTION_CHARS:String = "*";
        private static const RESTRICTION_ANY:String = "?";

        public function MaskedTextInput()
        {
            super();

            addEventListener(TextOperationEvent.CHANGING, verifyInsertedText);
            addEventListener(TextOperationEvent.CHANGE, formatAsYouType);
            addEventListener(TextEvent.TEXT_INPUT, overrideText);
        }

        protected var textChanged:Boolean = false;
        protected var storean:int;
        protected var storeac:int;

        private var _maskText:String = "";
        protected var maskedTextChanged:Boolean = true;

        private var _separators:String = "- +/|()[]{}.";
        protected var separatorsChanged:Boolean = true;

        /**
         * internal character to represent blank space in text
         */
        private static const BLANK_SEPARATOR:String = " ";

        /**
         * an internal array to maintain the insertion point of separators. This array is filled based on the
         * mask text pattern and the separators available
         */
        protected var separatorLocations:Array = null;

        /**
         * user defined text prompt. For example for date mask ("##/##/####") you could use textMaskPrompt "dd/mm/yyyy"
         */
        public var textMaskPrompt:String = "";

        /**
         * the character to represent a input character location
         */
        [Bindable]
        public var placeHolder:String = "_";

        /**
         * substitute the prompt with the selected place holder for all special characters (#,@ and ?)
         */
        [Bindable]
        public var usePlaceHolder:Boolean = true;

        /**
         * get text formated with separators
         */
        public function get fullText():String
        {
            return super.text;
        }

        /**
         * get the raw text removing separators
         */
        override public function get text():String
        {
            return cleanText(fullText);
        }
		
		protected function updatePropertyChangeReference(fieldName:String, oldValue:*, newValue:*):void
		{
			throw new Error("needs to be override in an ISurfaceComponent class.");
		}

        /**
         * remove not allowed separators
         * @param value
         * @return
         */
        private function cleanText(value:String):String
        {
            var rawText:String = "";
            for (var index:int = 0; index < value.length; index++)
            {
                var aChar:String = value.charAt(index);
                for (var sepIndex:int = 0; sepIndex < separators.length; sepIndex++)
                {
                    var sepChar:String = separators.charAt(sepIndex);
                    var found:Boolean = false;
                    if (aChar == sepChar)
                    {
                        found = true;
                        break;
                    }
                }
                if (!found)
                {
                    rawText += aChar;
                }
            }
            return rawText;
        }

        /**
         * program a format of the entered text based on mask text and separators
         * @param value
         */
        [Bindable("change")]
        [Bindable("textChanged")]
        // Compiler will strip leading and trailing whitespace from text string.
        [CollapseWhiteSpace]
        override public function set text(value:String):void
        {
            if (super.text !== value)
            {
				updatePropertyChangeReference("text", super.text, value);
				
                storean = selectionAnchorPosition;
                storeac = selectionActivePosition;
                super.text = value;
                textChanged = true;
                invalidateProperties();
            }
        }

        /**
         * use blank character instead of separator character
         */
        [Bindable]
        public var hideSeparatorInText:Boolean = true;

        [Bindable("maskTextChanged")]
        public function get maskText():String
        {
            return _maskText;
        }

        public function set maskText(value:String):void
        {
            if (maskText !== value)
            {
				updatePropertyChangeReference("maskText", _maskText, value);
				
                _maskText = value;
                maskedTextChanged = true;
                dispatchEvent(new Event("maskTextChanged"));

                invalidateProperties();
            }
        }

        [Bindable]
        public function get separators():String
        {
            return _separators;
        }

        public function set separators(value:String):void
        {
            if (separators !== value) {
                separatorsChanged = true;
                _separators = value;
                invalidateProperties();
            }
        }

        [Bindable]
        public function get showMaskWhileWrite():Boolean
        {
            return _showMaskWhileWrite;
        }

        public function set showMaskWhileWrite(value:Boolean):void
        {
            _showMaskWhileWrite = value;
            invalidateSkinState();
        }

        /**
         * show the mask text while user writes, removing characters as user types
         */
        private var _showMaskWhileWrite:Boolean = true;

        //----------------------------------
        //  COMPONENT LIFE CYCLE
        //----------------------------------

        /**
         * getCurrentSkinState
         * @return the new state
         */
        override protected function getCurrentSkinState():String
        {
            if (showMaskWhileWrite) {
                if (enabled && skin && skin.hasState("normalWithPrompt"))
                    return "normalWithPrompt";
                if (!enabled && skin && skin.hasState("disabledWithPrompt"))
                    return "disabledWithPrompt";
            }

            return super.getCurrentSkinState();
        }

        /**
         * commit properties
         */
        override protected function commitProperties():void
        {
            super.commitProperties();

            if (maskedTextChanged) {
                typicalText = maskText;
                maxChars = maskText.length;
            }

            if (separatorsChanged || maskedTextChanged) {
                // create the array of separator locations based on mask text and available separators
                separatorLocations = [];
                for (var maskIndex:int = 0; maskIndex < maskText.length; maskIndex++) {
                    var maskChar:String = getMaskCharAt(maskIndex);
                    for (var sepIndex:int = 0; sepIndex < separators.length; sepIndex++) {
                        var sepChar:String = separators.charAt(sepIndex);
                        if (maskChar == sepChar) {
                            separatorLocations.push(maskIndex);
                        }
                    }
                }
            }

            if (textChanged) {
                selectAll();
                insertText(formatTextWithMask(text));
                selectRange(storean, storeac);
            }

            separatorsChanged = maskedTextChanged = textChanged = false;

            updatePrompt();
        }

        //----------------------------------
        //  PROTECTED
        //----------------------------------

        /**
         * format programmatic text (not introduced by user) in textDisplay control with the mask
         * (i.e.: assigned string to text property, trigger, binding, ...)
         */
        protected function formatTextWithMask(value:String):String
        {
            var stack:Array = value.split("");
            var outputText:String = "";

            for (var i:int = 0; i < maskText.length; i++) {
                if (stack.length == 0) {
                    break;
                }
                if (isSeparator(i)) {//if is separator location add separator
                    outputText += getMaskCharAt(i);
                } else { // if not add the expected value char
                    outputText += restrictToMaskPattern(stack.shift(), i);
                }
            }

            return outputText;
        }

        /**
         * verify insertion to avoid characters not allowed in mask
         * @param event the TextOperationEvent event
         */
        protected function verifyInsertedText(event:TextOperationEvent):void
        {
            // filter now allowed characters
            var an:int = selectionAnchorPosition;
            var insertTextOp:InsertTextOperation = null;
            if (event.operation is InsertTextOperation && an != maxChars) {
                insertTextOp = event.operation as InsertTextOperation;
                if (restrictToMaskPattern(insertTextOp.text, an) == ""
                        || (restrictToMaskPattern(insertTextOp.text, an + 1) == "" && isMaskSeparatorLocation(an))) {
                    event.preventDefault();
                }
            }
        }

        /**
         * add or remove separator character as we type in the text input.
         * Note that override text when all characters are in place
         * is not supported (see overrideText method)
         * @param event the TextOperationEvent event
         */
        protected function formatAsYouType(event:TextOperationEvent):void
        {
            var stack:Array = text.split("");
            var outputText:String = "";
            var an:int = selectionAnchorPosition;
            var ac:int = selectionAnchorPosition;
            var offset:int = 0;//caret advances one position by default (on insert and deletion)

            //copy/paste
            if (event.operation is CompositeOperation) {
                var operations:Array = (event.operation as CompositeOperation).operations;

                if (operations[1] is InsertTextOperation) {
                    var copyedText:String = cleanText((operations[1] as InsertTextOperation).text);
                    outputText = formatTextWithMask(copyedText);
                    an = ac = outputText.length;
                }
            }
            //insert
            else if (event.operation is InsertTextOperation) {
                var insertOp:InsertTextOperation = event.operation as InsertTextOperation;
                if (insertOp.deleteSelectionState != null && !insertOp.deleteSelectionState.tlf_internal::selectionManagerOperationState) {
                    //OVERRIDING INSERT
                    if (EditManager.overwriteMode) {
                        //windows insert mode on (note that Flash Player does not track insertion mode state before running a SWF)
                        if (isSeparator(ac - 1)) {
                            outputText = super.text.substring(0, insertOp.originalSelectionState.anchorPosition + 1) + super.text.substring(insertOp.originalSelectionState.anchorPosition + 2);
                        } else {
                            outputText = super.text;
                        }
                        an -= 1;
                        ac -= 1;
                    }
                    else if (isSeparator(ac)) {
                        outputText = super.text.substring(0, insertOp.originalSelectionState.anchorPosition + 1) + insertOp.text + super.text.substring(insertOp.originalSelectionState.activePosition + 1);
                    } else {
                        outputText = super.text.substring(0, insertOp.originalSelectionState.anchorPosition) + insertOp.text + super.text.substring(insertOp.originalSelectionState.activePosition);
                    }

                    outputText = formatTextWithMask(cleanText(outputText));

                    if (isSeparator(ac)) {
                        an = an + 2;
                        ac = ac + 2;
                    }
                    else {
                        an = an + 1;
                        ac = ac + 1;
                    }
                } else {
                    //INSERT (TEXT NOT COMPLETE)
                    for (var i:int = 0; i < maskText.length; i++) {
                        if (stack.length == 0) {
                            break;
                        }
                        if (isMaskSeparatorLocation(i)) {
                            outputText += getMaskCharAt(i);
                            offset += 1;
                        } else {
                            outputText += restrictToMaskPattern(stack.shift(), i);
                        }
                    }

                    //on override caret does not advance
                    if (super.text.length > an) {
                        //override on separator
                        if (isSeparator(an - 1)) {
                            offset = getDeletePosition(an) + 1;
                        }
                        else if (isSeparator(an)) {
                            offset = 1;
                        }
                        else {
                            offset = 0;
                        }
                    }

                    an = ac = selectionAnchorPosition + offset;
                }
            }
            //delete
            else if (event.operation is DeleteTextOperation) {
                if (isSeparator(an - 1)) {
                    offset = consecutiveSeparators(an - 1);
                }
                else if (isSeparator(an)) {
                    stack.splice(an - getDeletePosition(an) - 1, 1);
                    offset = 1;
                }

                for (i = 0; i < maskText.length; i++) {
                    if (stack.length == 0) {
                        break;
                    }
                    if (isMaskSeparatorLocation(i)) {
                        outputText += getMaskCharAt(i);
                    } else {
                        outputText += restrictToMaskPattern(stack.shift(), i);
                    }
                }

                an = ac = selectionActivePosition - offset;
            }
            //copy
            else if (event.operation is CopyOperation) {
                return; // avoid to remove all text on copy operation
            }


            selectAll();
            insertText(outputText);
            selectRange(an, ac);

            updatePrompt();

            dispatchEvent(new Event("textChanged"));
        }

        /**
         * used when text exist and is as long as maxChars and cursor is not at
         * the end of the text.
         * overrides the actual text as we type (replacing text as we type)
         * @param event the TextEvent
         */
        protected function overrideText(event:TextEvent):void
        {
            //windows insert mode on (note that Flash Player does not track insertion mode state before running a SWF)
            if (EditManager.overwriteMode)
            {
                return;
            }

            var an:int = selectionAnchorPosition;
            var ac:int = selectionActivePosition;

            // text is full, overwrite characters
            if (super.text.length == maxChars)
            {
                // filter now allowed characters
                if (restrictToMaskPattern(event.text, an) == ""
                        || (restrictToMaskPattern(event.text, an + 1) == "" && isMaskSeparatorLocation(an)))
                {
                    return;
                }

                var operationState:SelectionState = new SelectionState(RichEditableText(textDisplay).textFlow, an, ac + 1);
                var operation:InsertTextOperation = new InsertTextOperation(operationState, event.text, operationState);
                var changeEvent:TextOperationEvent = new TextOperationEvent(TextOperationEvent.CHANGE, false, true, operation);
                dispatchEvent(changeEvent);
            }
        }

        //----------------------------------
        //  PRIVATE
        //----------------------------------

        /**
         * update prompt
         */
        protected function updatePrompt():void
        {
            var _prompt:String = "";
            var textLength:int = super.text.length;
            for (var i:int = 0; i < textLength; i++) {
                if (isSeparator(i)) {//if is separator location add separator
                    _prompt += hideSeparatorInText ? getMaskCharAt(i) : BLANK_SEPARATOR;
                } else { // if not add the expected value char
                    _prompt += BLANK_SEPARATOR;
                }
            }
            _prompt += textMaskPrompt == "" ? maskText.substring(textLength) : textMaskPrompt.substring(textLength);

            if (usePlaceHolder && textMaskPrompt == "") {
                _prompt = _prompt.replace(/\9/g, placeHolder);
                _prompt = _prompt.replace(/\*/g, placeHolder);
                _prompt = _prompt.replace(/?/g, placeHolder);
            }

            prompt = _prompt;
        }

        /**
         * Manage template rules:
         *      # - numeric-only,
         *      @ - alphabetic-only,
         *      ? - any
         * @param inputChar
         * @param position
         * @return the restricted character or the mask character
         */
        protected function restrictToMaskPattern(inputChar:String, position:int):String
        {
            var maskChar:String = getMaskCharAt(position);
            switch (maskChar) {
                case RESTRICTION_NUMBERS:
                    return StringUtil.restrict(inputChar, "0-9");
                case RESTRICTION_CHARS:
                    return StringUtil.restrict(inputChar, "a-zA-Z");
                case RESTRICTION_ANY:
                    return inputChar;
            }
            return maskChar;
        }


        //----------------------------------
        //  PRIVATE AUTOMATA'S LOGIC
        //----------------------------------

        /**
         * get the mask char at index location
         * @param index
         * @return
         */
        protected function getMaskCharAt(index:int):String
        {
            return maskText.charAt(index);
        }

        /**
         *
         * @param index
         * @return true if location in maskText is separator, false if is placeHolder location
         */
        private function isMaskSeparatorLocation(index:int):Boolean
        {
            for (var sepIndex:int = 0; sepIndex < separators.length; sepIndex++)
            {
                var sepChar:String = separators.charAt(sepIndex);
                if (getMaskCharAt(index) == sepChar)
                {
                    return true;
                }
            }
            return false;
        }

        /**
         * @param index
         * @return true if there is separator at index, false otherwise
         */
        private function isSeparator(index:int):Boolean
        {
            for (var i:int = 0; i < separatorLocations.length; i++)
            {
                if (index == separatorLocations[i])
                {
                    return true;
                }
            }
            return false;
        }

        /**
         * @param index
         * @return return value to rest from anchor to splice chars when remove, 0 otherwise.
         */
        private function getDeletePosition(index:int):int {
            for (var i:int = 0; i < separatorLocations.length; i++) {
                if (index == separatorLocations[i]) {
                    return i;
                }
            }
            return 0;
        }

        /**
         * @param index
         * @return return value to rest from anchor to splice chars when remove, 0 otherwise.
         */
        private function consecutiveSeparators(index:int):int
        {
            if (isSeparator(index - 1))
            {
                return 1 + consecutiveSeparators(index - 1);
            }
            else
            {
                return 1;
            }
            return 0;
        }
    }
}
