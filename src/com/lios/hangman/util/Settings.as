package com.lios.hangman.util
{
	import flash.net.SharedObject;

	/**
	 * Loads and saves settings to SharedObject
	 */
	public class Settings
	{
		private static var _instance:Settings = null;
		
		public static function get instance():Settings
		{
			return _instance;
		}

		public static function init():void
		{
			_instance = new Settings(new SingletonEnforcer());
		}
		
		private var settings:Object = {};
		
		public function Settings(enforcer:SingletonEnforcer)
		{
			loadSettings();
		}	
		
		public function getSetting(name:String):Object
		{
			return instance.settings[name];
		}
		
		public function setSetting(key:String, value:*, autoSave:Boolean = false):void
		{
			settings[key] = value;
			if (autoSave)
				saveSettings();
		}
		
		public function saveSettings():void
		{
			try {
				var so:SharedObject = SharedObject.getLocal("com.hangman");
				for (var key:String in settings)
				{
					so.setProperty(key, settings[key]);
				}
				so.flush(1024); //1KB
			} 
			catch(error:Error) {
				trace("Could not write SharedObject to disk. " + error);
			}
		}
		
		private function loadSettings():void
		{
			try {
				var so:SharedObject = SharedObject.getLocal("com.hangman");
				settings = so.data;
			}
			catch (error:Error) {
				trace("Could not read SharedObject. " + error);
			}
			
			// on the first time that the app is running
			if ( ! settings.hasOwnProperty("totalScore")) 
			{
				settings["totalGames"] = 0;
				settings["wins"] = 0;
				settings["luckyStreak"] = 0;
				settings["bestTime"] = 60;
				settings["totalScore"] = 0;
				settings["bestTime"] = 60;
				settings["volume"] = 1;
				saveSettings();
			}
			
			if ( ! settings.hasOwnProperty("isRateDialogShown"))
			{
				settings["isRateDialogShown"] = false;
				saveSettings();
			}
			
			if ( ! settings.hasOwnProperty("hintsUsed")) 
			{
				settings["hintsUsed"] = 0;
				saveSettings();
			}
		}
	}
}

class SingletonEnforcer {}