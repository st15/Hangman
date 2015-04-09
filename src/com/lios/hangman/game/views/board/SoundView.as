package com.lios.hangman.game.views.board
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.ui.assets.Assets;
	import com.lios.hangman.game.GameAction;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.game.views.ComponentView;
	
	import starling.events.Event;

	public class SoundView extends ComponentView
	{
		public function SoundView(aModel:Object, aController:Object=null)
		{
			super(aModel, aController);
		}
		
		override public function update(event:Event = null):void
		{
			if (event.data != GameAction.PAUSE && event.data != GameAction.RESUME)
			{
				if (GameModel(model).isGameOver()) // game over
				{
					// get data from model
					if (GameModel(model).hasWon())
					{
						//trace("sound : WIN");
						Assets.playSound(Constants.SOUND_GAME_OVER);
						Assets.playSound(Constants.SOUND_WIN);
					}
					else
					{
						//trace("sound : LOSE");
						Assets.playSound(Constants.SOUND_GAME_OVER);
					}
				}
				else if (GameModel(model).isInPlay)
				{
					// get data from model
					if (GameModel(model).isLastMoveCorrect)
					{
						trace("sound : SOUND_CORRECT");
						Assets.playSound(Constants.SOUND_CORRECT);
					}
					else
					{
						trace("sound : SOUND_MISTAKE");
						Assets.playSound(Constants.SOUND_MISTAKE);
					}
				}
			}
		}
	}
}