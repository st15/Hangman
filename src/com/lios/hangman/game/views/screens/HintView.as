package com.lios.hangman.game.views.screens
{
	import com.lios.hangman.game.GameAction;
	import com.lios.hangman.game.controllers.GameController;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.game.views.ComponentView;
	import com.lios.hangman.ui.AnimatedCallout;
	import com.lios.hangman.ui.PullDownScreen;
	import com.lios.hangman.ui.themes.LightHangmanTheme;
	import com.lios.hangman.util.Settings;
	import com.lios.hangman.util.Translator;
	
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Label;
	
	import starling.core.Starling;
	import starling.events.Event;

	public class HintView extends ComponentView
	{
		private var pullDownScreen:PullDownScreen;
		private var hintLabel:Label;
		private var hintButton:Button;
		
		private var hintTipCallout:AnimatedCallout;
		
		public function HintView(aModel:Object, aController:Object=null)
		{
			super(aModel, aController);
			
			pullDownScreen = new PullDownScreen(false, 140);
			
			hintLabel = new Label();
			hintLabel.text = "";
			hintLabel.width = pullDownScreen.baseWidth - 100;
			hintLabel.wordWrap = false;
			
			hintLabel.x = 50;
			hintLabel.y = 650;
			pullDownScreen.addChild(hintLabel);
			
			hintButton = new Button();
			hintButton.addEventListener(Event.TRIGGERED, button_triggeredHandler);
			hintButton.styleNameList.add(LightHangmanTheme.THEME_STYLE_NAME_TEXT_BUTTON);
			hintButton.label = "?";
			hintButton.scaleX = hintButton.scaleY = 0.6;
			hintButton.x = 16; //16;
			hintButton.y = 30; //36;
			
			this.addChild(hintButton);
		}
		
		override public function update(event:Event = null):void 
		{
			// get data from model
			if (event.data == GameAction.BEGIN_NEW_GAME)
			{
				hintLabel.text = GameModel(model).hint;
				
				initHintTip();
			}
			else if (hintTipCallout != null && ! GameModel(model).isInPlay)
			{
				// stop hint timer
				hintTipCallout.hide();
			}
		}
		
		private function button_triggeredHandler(e:Event):void
		{
			trace("hint");
			resetHintTip();
			
			showHint();
		}
		
		private function showHint():void
		{
			pullDownScreen.show(this);
			hintButton.isEnabled = false;
			Starling.juggler.delayCall(onHideScreen, 3);
			(this.controller as GameController).setLastGameHint(true);
		}
		
		private function onHideScreen():void
		{
			pullDownScreen.hide(function ():void {hintButton.isEnabled = true;});
		}
		
		private function initHintTip():void
		{
			// users may not notice that the "?" button shows hints, that's why we show them a tip
			if (int(Settings.instance.getSetting("hintsUsed")) < 5)
			{
				trace("hintsUsed : " + int(Settings.instance.getSetting("hintsUsed")));
				// show hint tip after a delay
				const calloutDelay:int = 5;
				var content:Label = new Label();
				content.text = Translator.instance.getPhrase("aboutHint");
				hintTipCallout = AnimatedCallout.show(content, hintButton, Callout.DIRECTION_DOWN, calloutDelay);
			}
		}
		
		private function resetHintTip():void
		{
			if (hintTipCallout != null)
			{
				hintTipCallout.hide();
				// set hints used 
				var newHintsUsed:int = int(Settings.instance.getSetting("hintsUsed"));
				newHintsUsed++;
				Settings.instance.setSetting("hintsUsed", newHintsUsed, true);
			}
		}
	}
}