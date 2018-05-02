package view
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	import mx.events.MoveEvent;
	import mx.events.ResizeEvent;
	import mx.managers.IFocusManagerComponent;
	
	import spark.components.Button;
	
	import utils.GenericUtils;
	
	import view.interfaces.INonResizibleSurfaceComponent;
	import view.interfaces.ISurfaceComponent;
	import view.models.PropertyChangeReferenceVO;

    public class ResizeHandles extends UIComponent
	{
		public function ResizeHandles(target:UIComponent = null)
		{
			this.target = target;
		}

		private var _target:IUIComponent;

		public function get target():IUIComponent
		{
			return this._target;
		}

		public function set target(value:IUIComponent):void
		{
			if(this._target === value)
			{
				return;
			}
			if(this._target !== null)
			{
				this._target.removeEventListener(MoveEvent.MOVE, target_moveHandler);
				this._target.removeEventListener(ResizeEvent.RESIZE, target_resizeHandler);
			}
			this._target = value;
			if(this._target !== null)
			{
				this._target.addEventListener(MoveEvent.MOVE, target_moveHandler, false, 0, true);
				this._target.addEventListener(ResizeEvent.RESIZE, target_resizeHandler, false, 0, true);
			}
			this.invalidateSize();
			this.invalidateDisplayList();
		}

		private var _topLeft:Button;
		private var _topRight:Button;
		private var _bottomLeft:Button;
		private var _bottomRight:Button;

		private var _startStageX:Number;
		private var _startStageY:Number;
		private var _startTargetX:Number;
		private var _startTargetY:Number;
		private var _startTargetWidth:Number;
		private var _startTargetHeight:Number;
		private var _resizingX:Boolean;
		private var _resizingY:Boolean;
		private var _resizingWidth:Boolean;
		private var _resizingHeight:Boolean;

		private function  get isTargetResizible():Boolean
		{
			return _target && !(_target is INonResizibleSurfaceComponent);
		}

		override protected function createChildren():void
		{
			super.createChildren();

			this._topLeft = new Button();
			this._topLeft.styleName = "resizeHandle";
			this._topLeft.addEventListener(MouseEvent.MOUSE_DOWN, topLeft_mouseDownHandler);
			this.addChild(this._topLeft);

			this._topRight = new Button();
			this._topRight.styleName = "resizeHandle";
			this._topRight.addEventListener(MouseEvent.MOUSE_DOWN, topRight_mouseDownHandler);
			this.addChild(this._topRight);

			this._bottomLeft = new Button();
			this._bottomLeft.styleName = "resizeHandle";
			this._bottomLeft.addEventListener(MouseEvent.MOUSE_DOWN, bottomLeft_mouseDownHandler);
			this.addChild(this._bottomLeft);

			this._bottomRight = new Button();
			this._bottomRight.styleName = "resizeHandle";
			this._bottomRight.addEventListener(MouseEvent.MOUSE_DOWN, bottomRight_mouseDownHandler);
			this.addChild(this._bottomRight);
		}

		override protected function measure():void
		{
			if(this._target !== null)
			{
				this.measuredWidth = this._target.width;
				this.measuredHeight = this._target.height;
			}
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var position:Point = new Point(0, 0);
			if(this._target !== null)
			{
				position = this._target.localToGlobal(position);
			}

			this.move(position.x, position.y);

            hideResizeButtonsIfNonResizibleComponent();

			if (isTargetResizible)
            {
                this._topLeft.setActualSize(this._topLeft.getExplicitOrMeasuredWidth(), this._topLeft.getExplicitOrMeasuredHeight());
                this._topLeft.x = -this._topLeft.getExplicitOrMeasuredWidth() / 2;
                this._topLeft.y = -this._topLeft.getExplicitOrMeasuredHeight() / 2;

                this._topRight.setActualSize(this._topRight.getExplicitOrMeasuredWidth(), this._topRight.getExplicitOrMeasuredHeight());
                this._topRight.x = unscaledWidth - this._topRight.getExplicitOrMeasuredWidth() / 2;
                this._topRight.y = -this._topRight.getExplicitOrMeasuredHeight() / 2;

                this._bottomLeft.setActualSize(this._bottomLeft.getExplicitOrMeasuredWidth(), this._bottomLeft.getExplicitOrMeasuredHeight());
                this._bottomLeft.x = -this._bottomLeft.getExplicitOrMeasuredWidth() / 2;
                this._bottomLeft.y = unscaledHeight - this._bottomLeft.getExplicitOrMeasuredHeight() / 2;

                this._bottomRight.setActualSize(this._bottomRight.getExplicitOrMeasuredWidth(), this._bottomRight.getExplicitOrMeasuredHeight());
                this._bottomRight.x = unscaledWidth - this._bottomRight.getExplicitOrMeasuredWidth() / 2;
                this._bottomRight.y = unscaledHeight - this._bottomRight.getExplicitOrMeasuredHeight() / 2;
            }
		}

        private function hideResizeButtonsIfNonResizibleComponent():void
        {
			var isResizible:Boolean = isTargetResizible;

            this._topLeft.visible = this._topLeft.includeInLayout = isResizible;
            this._topRight.visible = this._topRight.includeInLayout = isResizible;
            this._bottomLeft.visible = this._bottomLeft.includeInLayout = isResizible;
            this._bottomRight.visible = this._bottomRight.includeInLayout = isResizible;
        }

		private function topLeft_mouseDownHandler(event:MouseEvent):void
		{
			if(this._target is IFocusManagerComponent)
			{
				IFocusManagerComponent(this._target).setFocus();
			}
			this._startStageX = event.stageX;
			this._startStageY = event.stageY;
			this._resizingX = true;
			this._resizingY = true;
			this._resizingWidth = false;
			this._resizingHeight = false;
			this._startTargetX = this._target.x;
			this._startTargetY = this._target.y;
			this._startTargetWidth = this._target.width;
			this._startTargetHeight = this._target.height;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler, false, 0, true);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler, false, 0, true);
		}

		private function topRight_mouseDownHandler(event:MouseEvent):void
		{
			if(this._target is IFocusManagerComponent)
			{
				IFocusManagerComponent(this._target).setFocus();
			}
			this._startStageX = event.stageX;
			this._startStageY = event.stageY;
			this._resizingX = false;
			this._resizingY = true;
			this._resizingWidth = true;
			this._resizingHeight = false;
			this._startTargetY = this._target.y;
			this._startTargetWidth = this._target.width;
			this._startTargetHeight = this._target.height;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler, false, 0, true);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler, false, 0, true);
		}

		private function bottomLeft_mouseDownHandler(event:MouseEvent):void
		{
			if(this._target is IFocusManagerComponent)
			{
				IFocusManagerComponent(this._target).setFocus();
			}
			this._startStageX = event.stageX;
			this._startStageY = event.stageY;
			this._resizingX = true;
			this._resizingY = false;
			this._resizingWidth = false;
			this._resizingHeight = true;
			this._startTargetX = this._target.x;
			this._startTargetWidth = this._target.width;
			this._startTargetHeight = this._target.height;
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler, false, 0, true);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler, false, 0, true);
		}

		private function bottomRight_mouseDownHandler(event:MouseEvent):void
		{
			if(this._target is IFocusManagerComponent)
			{
				IFocusManagerComponent(this._target).setFocus();
			}
			this._startStageX = event.stageX;
			this._startStageY = event.stageY;
			this._resizingX = false;
			this._resizingY = false;
			this._resizingWidth = true;
			this._resizingHeight = true;
			this._startTargetWidth = this._target.width;
			this._startTargetHeight = this._target.height;
			
			// TO-DO: Needs to updated with typed interface methods
			//
			// Updating width/height on every keyframe may cause several entries to
			// history manager, thus we should add the change entry only when
			// resizing event is over
			if (Object(this._target).hasOwnProperty("isUpdating"))
			{
				this._target["isUpdating"] = true;
				
				this._target["propertyChangeFieldReference"] = new PropertyChangeReferenceVO(this._target as ISurfaceComponent);
				this._target["propertyChangeFieldReference"].fieldLastValue = [{field:"width", value:this._target.width}, {field:"percentWidth", value:this._target.percentWidth},
					{field:"height", value:this._target.height}, {field:"percentHeight", value:this._target.percentHeight}];
			}
			
			this.stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler, false, 0, true);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler, false, 0, true);
		}

		private function stage_mouseMoveHandler(event:MouseEvent):void
		{
			if(this._resizingX)
			{
				var offsetX:Number = event.stageX - this._startStageX;
				var newWidth:Number = this._startTargetWidth - offsetX;
				if(newWidth < this._target.minWidth)
				{
					newWidth = this._target.minWidth;
				}
				else if(newWidth > this._target.maxWidth)
				{
					newWidth = this._target.maxWidth;
				}
				this._target.x = this._startTargetX + this._startTargetWidth - newWidth;
				this._target.width = newWidth;
			}
			if(this._resizingY)
			{
				var offsetY:Number = event.stageY - this._startStageY;
				var newHeight:Number = this._startTargetHeight - offsetY;
				if(newHeight < this._target.minHeight)
				{
					newHeight = this._target.minHeight;
				}
				else if(newHeight > this._target.maxHeight)
				{
					newHeight = this._target.maxHeight;
				}
				this._target.y = this._startTargetY + this._startTargetHeight - newHeight;
				this._target.height = newHeight;
			}
			if(this._resizingWidth)
			{
				newWidth = this._startTargetWidth + (event.stageX - this._startStageX);
				if(newWidth < this._target.minWidth)
				{
					newWidth = this._target.minWidth;
				}
				else if(newWidth > this._target.maxWidth)
				{
					newWidth = this._target.maxWidth;
				}
				this._target.width = newWidth;
			}
			if(this._resizingHeight)
			{
				newHeight = this._startTargetHeight + (event.stageY - this._startStageY);
				if(newHeight < this._target.minHeight)
				{
					newHeight = this._target.minHeight;
				}
				else if(newHeight > this._target.maxHeight)
				{
					newHeight = this._target.maxHeight;
				}
				this._target.height = newHeight;
			}
		}

		private function stage_mouseUpHandler(event:MouseEvent):void
		{
			// TO-DO: Needs to updated with typed interface methods
			//
			// Updating width/height on every keyframe may cause several entries to
			// history manager, thus we should add the change entry only when
			// resizing event is over
			if (Object(this._target).hasOwnProperty("isUpdating"))
			{
				this._target["isUpdating"] = false;
				
				this._target["propertyChangeFieldReference"].fieldNewValue = [{field:"width", value:this._target.width}, {field:"percentWidth", value:NaN},
																				{field:"height", value:this._target.height}, {field:"percentHeight", value:NaN}];
				this._target.dispatchEvent(new Event("widthChanged"));
			}
			
			this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		private function target_moveHandler(event:MoveEvent):void
		{
			this.invalidateDisplayList();
		}

		private function target_resizeHandler(event:ResizeEvent):void
		{
			this.invalidateSize();
			this.invalidateDisplayList();
		}
	}
}
