package com.lios.hangman.game.views
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.ui.assets.Assets;
	
	import starling.display.Image;
	
	/**
	 * The root view of the game - contains all the other views,
	 * as well as the game background image.
	 */
	public class GameRootView extends CompositeView
	{
		public function GameRootView (aModel:GameModel, aController:Object)
		{
			super(aModel, aController);
			
			// add background
			var background:Image = new Image(Assets.getTexture("background"));
			background.x = (Constants.GAME_WIDTH - Constants.BASE_BG_WIDTH) * 0.5;
			background.y = (Constants.GAME_HEIGHT - Constants.BASE_BG_HEIGHT) * 0.5;
			
			this.addChild(background); 
		}
	}
}