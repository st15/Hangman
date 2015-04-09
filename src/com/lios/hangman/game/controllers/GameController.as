package com.lios.hangman.game.controllers
{
	import com.lios.hangman.game.models.GameModel;
	
	public class GameController
	{
		private var model:GameModel;
		
		public function GameController(aModel:GameModel)
		{
			this.model = aModel;
		}
		
		public function startNewGame(category:String):void
		{
			model.startNewGame(category);
		}
		
		public function showStartMenu():void
		{
			model.reset();
		}
		
		public function setLastGameTime(seconds:Number):void
		{
			model.timeUsed = seconds;
		}
		
		public function setLastGameHint(isUsed:Boolean):void
		{
			model.hintUsed = isUsed;
		}
		
		public function selectLetter(letter:String):void
		{
			model.checkForLetter(letter);
		}
		
		public function onTimeOver():void
		{
			model.makeGameOver(false);
		}
		
		public function pauseGame():void
		{
			model.pauseGame();
		}
		
		public function resumeGame():void
		{
			model.resumeGame();
		}
	}
}

