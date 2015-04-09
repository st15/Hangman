package com.lios.hangman.ui
{
	import flash.ui.Keyboard;
	
	import feathers.controls.Callout;
	import feathers.core.PopUpManager;
	
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	public class AnimatedCallout extends Callout
	{
		public static function show(content:DisplayObject, origin:DisplayObject, supportedDirections:String = DIRECTION_ANY, delay:int = 0):AnimatedCallout
		{
			if(!origin.stage)
			{
				throw new ArgumentError("Callout origin must be added to the stage.");
			}
			var callout:AnimatedCallout = new AnimatedCallout();
			callout.content = content;
			callout.supportedDirections = supportedDirections;
			callout.origin = origin;
			
			// fade in
			Starling.juggler.tween(callout, 1, {
				transition: Transitions.EASE_IN_OUT,
				delay: delay,
				alpha: 1,
				onStart: function():void {
					
					callout.alpha = 0;
					PopUpManager.addPopUp(callout, false, false);
				},
				onComplete: function():void {
					
					callout.closeOnTouchBeganOutside = true;
					callout.closeOnTouchEndedOutside = true;
					callout.closeOnKeys = new <uint>[Keyboard.BACK, Keyboard.ESCAPE];
				}
			});
			
			return callout;
		}
		
		public function hide():void
		{
			close(disposeOnSelfClose);
		}
		
		/**
		 * Closes the callout.
		 */
		override public function close(dispose:Boolean = false):void
		{
			Starling.juggler.removeTweens(this);
			
			if (this.parent)
			{
				// fade out
				Starling.juggler.tween(this, 1, {
					transition: Transitions.EASE_IN_OUT,
					alpha: 0,
					onComplete: super.close,
					onCompleteArgs: [dispose]
				});
			}
			else
			{
				super.close(dispose);
			}
		}
	}
}