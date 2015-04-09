package com.lios.hangman.util
{
	import com.lios.hangman.ui.assets.Assets;
	
	import flash.utils.Dictionary;

	public class Translator
	{
		// for now there is only Bulgarian
		public static const LANG_ID_BULGARIAN:String = "bg";
		
		private static var _instance:Translator = null;
		
		public static function load(selectedLanguage:String = LANG_ID_BULGARIAN):void
		{
			_instance = new Translator(selectedLanguage, new SingletonEnforcer());
		}
		
		public static function get instance():Translator
		{
			return _instance;
		}

		private var phrases:Dictionary;

		public function Translator(selectedLanguage:String, enforcer:SingletonEnforcer)
		{
			loadLanguage(selectedLanguage);
		}
		
		/**
		 * 
		 * @param id phrase id
		 * @param params parameters to replace
		 * 
		 * @return the translated phrase in the selected language
		 */
		public function getPhrase(id:String, params:Array = null):String
		{
			var result:String = phrases[id];
			
			CONFIG::debug {
				if (result == null)
				{
					throw new Error("Missing phrase: " + id);
				}
			}
				
			if (params != null)
			{
				for (var i:int = 0; i < params.length; i++)
				{
					result = result.replace("{" + i + "}", params[i]); 
				}
			}
			
			return result;
		}
		
		protected function loadLanguage(languageId:String):void
		{
			phrases = new Dictionary();
			var xml:XML = Assets.assetManager.getXml("lang-" + languageId);
			
			if (xml != null)
			{
				var phraseElements:XMLList = xml.phrase;
				
				var len:int = phraseElements.length();
				
				for (var i:int = 0; i < len; i++) 
				{
					var id:String = phraseElements[i].id.text();
					phrases[id] = phraseElements[i].text.text();
				}
			}
		}
	}
}

class SingletonEnforcer {}
