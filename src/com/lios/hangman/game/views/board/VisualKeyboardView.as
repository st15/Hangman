package com.lios.hangman.game.views.board
{
	import com.lios.hangman.game.GameAction;
	import com.lios.hangman.game.controllers.GameController;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.game.views.ComponentView;
	import com.lios.hangman.ui.LetterButton;
	
	import starling.events.Event;

	public class VisualKeyboardView extends ComponentView
	{
		private var alphabetButtons:Vector.<LetterButton>;
		
		public function VisualKeyboardView(aModel:Object, aController:Object=null)
		{
			super(aModel, aController);
			
			// alphabet buttons
			const lettersChars:String = "абвгдежзийклмнопрстуфхцчшщъьюя";
			alphabetButtons = new Vector.<LetterButton>();
			var letterButton:LetterButton;
			const lettersLen:int = lettersChars.length;
			
			for (var i:int = 0; i < lettersLen; i++)
			{
				letterButton = new LetterButton(lettersChars.charAt(i));
				letterButton.x = (i % 10) * 84 + (Math.floor(i / 10) % 2) * 40;
				letterButton.y = Math.floor(i / 10) * 80;
				letterButton.addEventListener(Event.TRIGGERED, onLetterTriggered);
				this.addChild(letterButton);
				
				alphabetButtons.push(letterButton);
			}
		}
		
		override public function update(event:Event = null):void
		{
			
			if (GameModel(model).isGameOver()) // game over
			{
				this.touchable = false;
			}
			else if (event.data == GameAction.BEGIN_NEW_GAME)
			{
				this.touchable = true;
			}
			// get data from model and update view
			var keysPressed:Array = GameModel(model).keysPressed;
			var letterButton:LetterButton;
			
			for each (letterButton in alphabetButtons)
			{
				// set enabled 
				letterButton.enabled = keysPressed.indexOf(letterButton.text) == -1;
			}
			
		}		
		
		private function onLetterTriggered(event:Event):void
		{
			var letter:String = (event.currentTarget as LetterButton).text;
			
			// delegate to the controller (strategy) to handle it
			(controller as GameController).selectLetter(letter);
		}
	}
}