package com.lios.hangman.ui
{
	import com.lios.hangman.Constants;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import com.lios.hangman.ui.assets.Assets;
	
	public class PullDownScreen extends Sprite
	{
		private var isModal:Boolean;
		private var heightDisplayed:Number;
		private var background:Image;
		private var underlay:Quad;
		private var onHideCallback:Function;
		
		public function PullDownScreen(isModal:Boolean, heightDisplayed:Number = 650)
		{
			this.heightDisplayed = heightDisplayed;
			this.isModal = isModal;
			background = new Image(Assets.getTexture("podium"));
			background.x = (Constants.GAME_WIDTH - background.width) * 0.5;
			this.addChild(background);
			
			// add modal underlay
			if (isModal)
			{
				var w:Number = Constants.BASE_BG_WIDTH; 
				var h:Number = Constants.BASE_BG_HEIGHT; 
				underlay = new Quad(w, h, 0x0);
				underlay.x = (Constants.GAME_WIDTH - w) * 0.5;
				underlay.y = (Constants.GAME_HEIGHT - h) * 0.5 - (heightDisplayed - background.height);
				underlay.alpha = 0.3;
			}
		}

		public function get baseWidth():Number
		{
//			return background.width;
			return Constants.GAME_WIDTH;
		}
		
		public function get baseHeight():Number
		{
			return background.height;
		}
		
		public function show(parent:DisplayObjectContainer):void
		{
			this.y = -background.height + 100;
			
			var transition:Tween;
			transition = new Tween(this, 0.6, Transitions.EASE_OUT_BACK); //EASE_OUT_BOUNCE);
			transition.animate("y", heightDisplayed - background.height);
			transition.delay = 0;
			Starling.juggler.add(transition);
			
			if (isModal)
			{
				underlay.alpha = 0;
				this.addChildAt(underlay, 0); 
				transition = new Tween(underlay, 0.5, Transitions.EASE_IN_BACK); 
				transition.animate("alpha", 0.3);
				transition.delay = 0.5;
				Starling.juggler.add(transition);
			}
			parent.addChild(this);
			Assets.playSound(Constants.SOUND_ROLL_SCREEN);
		}
		
		public function hide(callback:Function = null):void
		{
			Assets.playSound(Constants.SOUND_ROLL_SCREEN);
			onHideCallback = callback;
			var transition:Tween;
			transition = new Tween(this, 1, Transitions.EASE_IN_OUT);
			transition.animate("y", -background.height - 76);
			transition.delay = 0;
			transition.onComplete = onHide;
			Starling.juggler.add(transition);
			
			if (underlay != null)
				underlay.removeFromParent(); 
		}
		
		private function onHide():void
		{
			this.removeFromParent(); 
			if (onHideCallback != null)
			{
				onHideCallback();
				onHideCallback = null;
			}
		}
	}
}