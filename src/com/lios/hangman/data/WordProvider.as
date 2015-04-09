package com.lios.hangman.data
{
	
	import com.lios.hangman.WordCategories;
	
	import flash.utils.Dictionary;

	/**
	 * Loads words from a DatabaseConnector instance and caches them in a Dictionary object.
	 * Provides words for the game and when all words in the cache are used, loads and caches 10 more words.
	 */
	public class WordProvider
	{
		private static var instance:WordProvider = null;
		
		public static function init():void
		{
			instance = new WordProvider(new SingletonEnforcer());
		}
		
		private var db:DatabaseConnector;
		private var cachedWords:Dictionary;
		
		public function WordProvider(enforcer:SingletonEnforcer)
		{
			trace("WordProvider");
			db = new DatabaseConnector();
			cachedWords = new Dictionary();
			
			cachedWords[WordCategories.BG_TOWNS] = db.loadWords(WordCategories.BG_TOWNS, 10);
			cachedWords[WordCategories.CAPITALS] = db.loadWords(WordCategories.CAPITALS, 10);
			cachedWords[WordCategories.COUNTRIES] = db.loadWords(WordCategories.COUNTRIES, 10);
			cachedWords[WordCategories.WORDS] = db.loadWords(WordCategories.WORDS, 10);
		}
		
		/**
		 * Gets a word from the specified category. 
		 * 
		 * @param category
		 * 
		 * @return word object, eg {"hint":"Европа","name":"Испания"}
		 */
		public static function getNextWord(category:String):Object
		{
			var words:Array = instance.cachedWords[category];
			trace("WordProvider getNextWord: " + words);
			
			// debug
			for each (var w:Object in words) {
				var hint:String = w.hint;				
				
				if (category == "countries")
					hint = "Държава в " + hint;
				else if (category == "capitals")
					hint = "Столица на " + hint;
			}
			
			// when there are no more cached words, load 10 new words from the database.
			if (words.length == 0) 
			{
				words = instance.db.loadWords(category, 10);
			}
			
			return words.pop();	

			// return  { name: "бесеница", hint : ""};
		}
	}
}

class SingletonEnforcer {}