package com.lios 
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.data.WordProvider;
	import com.lios.hangman.game.HangmanGame;
	import com.lios.hangman.ui.assets.Assets;
	import com.lios.hangman.ui.themes.LightHangmanTheme;
	import com.lios.hangman.util.Settings;
	import com.lios.hangman.util.Translator;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.display3D.Context3DProfile;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;
	import starling.events.Event;
	// get the fullscreen extension from https://github.com/Brinkbit/StarlingFullScreenExtension
	import starling.extensions.brinkbit.fullscreenscreenextension.FullScreenExtension;

	/**
	 * Manages the starling instance. Initializes the game.
	 *  
	 */
	public class StarlingManager extends EventDispatcher
	{
		private var starlingInstance:Starling;
		private var nativeStage:Stage;
		private var splashScreen:flash.display.DisplayObject;
		private var resumeTimer:Timer;
		
		public function StarlingManager(nativeStage:Stage)
		{
			this.nativeStage = nativeStage;
		}
		
		/**
		 * Starts starling.
		 */
		public function startStarling():void
		{
			// start starling
			Starling.handleLostContext = true;
			
			// starling is created using FullScreenExtension - so that the game will fill the device screen
			starlingInstance = FullScreenExtension.createStarling(HangmanGame, nativeStage, 
				Constants.GAME_WIDTH, Constants.GAME_HEIGHT, // the game is resized in onStarlingRootCreated
				"center", "center", true,
				[ Context3DProfile.BASELINE, 
					Context3DProfile.BASELINE_CONSTRAINED]
			);
			starlingInstance.start();
			// добавя се listener за "rootCreated", за се предадат параметри на root класа
			starlingInstance.addEventListener(starling.events.Event.ROOT_CREATED, onStarlingRootCreated);
		}
		
		/**
		 * Resizes and initializes the game.
		 */
		private function onStarlingRootCreated(event:starling.events.Event):void
		{
			starlingInstance.removeEventListener(starling.events.Event.ROOT_CREATED, onStarlingRootCreated);
			
			resizeStarling();
			
			// init stuff
			Settings.init();
			WordProvider.init();
			SoundMixer.soundTransform = new SoundTransform(Number(Settings.instance.getSetting("volume"))); 
			
			// load assets
			Assets.assetManager.addEventListener(starling.events.Event.COMPLETE, onAssetsLoaded);
			Assets.loadAssets();
			
			nativeStage.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate); // fired when app is minimized
		}
		
		private function resizeStarling():void
		{
			// resize depending on the sreen size (tablet or phone)
			var gameWidth:Number;
			var gameHeight:Number;
			
			const isTablet:Boolean = DeviceCapabilities.isTablet(nativeStage);
			
			if (isTablet)
			{
				const aspectRatio:Number = nativeStage.stageWidth / nativeStage.stageHeight;
				
				if (aspectRatio < 1.6) // eg 4:3
					gameWidth = Constants.TABLET_4_3_BASE_WIDTH;
				else // >= 1.6
					gameWidth = Constants.BASE_BG_WIDTH;
				
				gameHeight = gameWidth / aspectRatio;
			}
			else
			{
				gameWidth = Constants.GAME_WIDTH;
				gameHeight = Constants.GAME_HEIGHT;
			}
			
			FullScreenExtension.resize(gameWidth, gameHeight, null, null, nativeStage.stageWidth, nativeStage.stageHeight);
		}
		
		/**
		 * Starts the game and dispatches Event.COMPLETE in order to hide the splash screen.
		 */
		private function onAssetsLoaded(e:starling.events.Event):void
		{
			trace("onAssetsLoaded");
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			
			// load translations from assets xml
			Translator.load(); 
			// load feathers theme
			new LightHangmanTheme();
			// initialize game 
			(HangmanGame(starlingInstance.root)).start();
			// hide splash, see also Hangman.as
			this.dispatchEvent(new flash.events.Event(flash.events.Event.COMPLETE));
		}
		
		/**
		 * Pauses game when app is minimized.
		 */
		private function onDeactivate(event:flash.events.Event):void
		{
			trace("onDeactivate");
			// pause game
			if (starlingInstance)
			{
				pauseGame();
				starlingInstance.stop(true); // if using ads: true - for interstitials
			}
			
			nativeStage.removeEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
			nativeStage.addEventListener(flash.events.Event.ACTIVATE, onActivate);
		}
		
		/**
		 * Resumes the app when it is activated.
		 */
		private function onActivate(event:flash.events.Event):void
		{
			trace("onActivate");
			nativeStage.removeEventListener(flash.events.Event.ACTIVATE, onActivate);
			// resume game
			if (starlingInstance)
			{
				starlingInstance.start();
			}
				
			// If the context is not lost, wait for a certain time and resume the game.
			startResumeTimer();
			
			// Wait for a CONTEXT3D_CREATE event but have in mind that it might not fire by the time the timer is complete.
			// Give the listener a priority of 20 so that it will be called before Starling's listener. 
			Starling.current.stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, stage3D_context3DCreateHandler);
			
			// add Listeners
			nativeStage.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
		}
		
		private function startResumeTimer():void
		{
			trace("startResumeTimer");
			resumeTimer = new Timer(1000, 1);
			resumeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, resumeTimer_timerCompleteHandler);
			
			resumeTimer.start();
		}
		
		protected function resumeTimer_timerCompleteHandler(e:TimerEvent):void
		{
			trace("resumeTimer_timerCompleteHandler");
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			Starling.current.stage3D.removeEventListener(flash.events.Event.CONTEXT3D_CREATE, stage3D_context3DCreateHandler);
			resumeGame();
		}
		
		private function stopResumeTimer():void
		{
			trace("stopResumeTimer");
			resumeTimer.stop();
		}
		
		private function stage3D_context3DCreateHandler(e:flash.events.Event):void
		{
			// the game will resume after the textures are restored, not when the timer is finished
			stopResumeTimer();
			trace("onContext3DEventCreate");
			
			Assets.assetManager.addEventListener(starling.events.Event.TEXTURES_RESTORED, assetManager_texturesRestoredHandler);
			
			e.currentTarget.removeEventListener(e.type, arguments.callee);
		}
		
		/** 
		 * Resumes the game when textures are restored.
		 */
		private function assetManager_texturesRestoredHandler(e:starling.events.Event):void
		{
			trace("onAssetManagerEventTexturesRestored");
			
			resumeGame();
			
			e.currentTarget.removeEventListener(e.type, arguments.callee);
		}
		
		private function resumeGame():void
		{
			removeSplashScreen();
			
			if (starlingInstance.root is HangmanGame)
			{
				trace("resume game");
				(HangmanGame(starlingInstance.root)).resume();
			}
		}
		
		private function pauseGame():void
		{
			if (starlingInstance.root is HangmanGame)
			{
				trace("pauseGame");
				(HangmanGame(starlingInstance.root)).pause();
			}
			
			// add loading (texture restoration) screen to the native display list
			addSplashScreen();
		}
		
		private function addSplashScreen():void
		{
			if (splashScreen == null)
			{
				splashScreen = new Splash();
			}
			nativeStage.addChild(splashScreen);
		}
		
		private function removeSplashScreen():void
		{
			if (splashScreen != null)
			{
				nativeStage.removeChild(splashScreen);
				splashScreen = null;
			}
		}
	}
}
