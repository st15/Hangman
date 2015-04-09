package 
{
	import com.lios.Splash;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	/**
	 * Entry point of the application.
	 * 
	 * Shows splash screen until the game and the resources are loaded. 
	 * Then starts com.lios.StarlingManager and removes the splash when the game is ready.
	 */
	[SWF(width="480", height="320", frameRate="30", backgroundColor="#669933")]
	public class Hangman extends MovieClip
	{
		private var starlingManager:Object;
		private var splash:Splash;
		
		public function Hangman()
		{
			// These settings are recommended to avoid problems with touch handling
			stage.scaleMode = "noScale";
			stage.align = "topLeft";
			
			//the document class must be a MovieClip so that things can go on
			//the second frame.
			stop();
			
			//we listen to Event.COMPLETE to know when the SWF is completely loaded.
			loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			
			// add Splash Screen
			splash = new Splash();
			addChild(splash);
		}
		
		/**
		 * The entire SWF has finished loading when this listener is called.
		 */
		private function loaderInfo_completeHandler(event:Event):void
		{
			loaderInfo.removeEventListener(Event.COMPLETE, loaderInfo_completeHandler);
			
			//go to frame two because that's where the classes we need are located
			gotoAndStop(2);
			
			//getDefinitionByName() will let us access the classes without importing
			var StarlingManagerType:Class = getDefinitionByName("com.lios.StarlingManager") as Class;
			starlingManager = new StarlingManagerType(stage);
			starlingManager.addEventListener(Event.COMPLETE, removeSplash);
			starlingManager.startStarling();
		}
		
		private function removeSplash(e:Event):void
		{
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			if (splash != null && splash.parent != null)
			{
				splash.parent.removeChild(splash);
				splash = null;
			}
		}
	}
}