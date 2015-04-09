package com.lios.hangman.game
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.game.controllers.GameController;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.game.views.ComponentView;
	import com.lios.hangman.game.views.CompositeView;
	import com.lios.hangman.game.views.GameRootView;
	import com.lios.hangman.game.views.board.HangingManView;
	import com.lios.hangman.game.views.board.SoundView;
	import com.lios.hangman.game.views.board.TimerView;
	import com.lios.hangman.game.views.board.VisualKeyboardView;
	import com.lios.hangman.game.views.board.WordView;
	import com.lios.hangman.game.views.screens.GameOverView;
	import com.lios.hangman.game.views.screens.HintView;
	import com.lios.hangman.game.views.screens.MainMenuView;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.brinkbit.fullscreenscreenextension.FullScreenExtension;
	
	/** 
	 * Starling root class. 
	 * Contains the model, the view and the controller for the game.
	 */
	public class HangmanGame extends Sprite
	{
		private var model:GameModel;
		private var rootView:CompositeView;
		private var controller:GameController;
		
		public function HangmanGame()
		{
			super();
		}
		
		/**
		 * Initialize Game after assets are loaded.
		 */
		public function start():void
		{
			model = new GameModel();
			controller = new GameController(model);
			
			// composite view
			rootView = new GameRootView(model, controller);
			
			// add child leaf views
			// board
			var timer:TimerView = new TimerView(model, controller);
			rootView.add(timer);
			
			var hangingMan:ComponentView = new HangingManView(model, controller);
			hangingMan.x = 56;
			hangingMan.y = 134;
			rootView.add(hangingMan);
			
			var word:ComponentView = new WordView(model, controller);
			word.x = 300;
			word.y = 108;
			rootView.add(word);
			
			var visualKeyboard:ComponentView = new VisualKeyboardView(model, controller);
			visualKeyboard.x = 54;
			visualKeyboard.y = 350; //336; ads
			rootView.add(visualKeyboard);
			
			var sounds:ComponentView = new SoundView(model, controller);
			rootView.add(sounds);
			
			// screens
			var hintView:HintView = new HintView(model, controller);
			rootView.add(hintView);
			
			var gameOverView:GameOverView = new GameOverView(model, controller);
			rootView.add(gameOverView);
			
			var menuView:MainMenuView = new MainMenuView(model, controller);
			rootView.add(menuView);
			
			// register view to receive notifications 
			model.addEventListener(Event.CHANGE, rootView.update);
			
			rootView.x = (FullScreenExtension.stageWidth - Constants.GAME_WIDTH) * 0.5;
			rootView.y = (FullScreenExtension.stageHeight - Constants.GAME_HEIGHT) * 0.5;
			FullScreenExtension.stage.addChildAt(rootView, 0);
			
			controller.showStartMenu();
		}
		
		public function pause():void
		{
			if (controller != null)
				controller.pauseGame();
		}
		
		public function resume():void
		{
			if (controller != null)
				controller.resumeGame();
		}
	}
}
