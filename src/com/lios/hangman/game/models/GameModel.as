package com.lios.hangman.game.models
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.WordCategories;
	import com.lios.hangman.data.WordProvider;
	import com.lios.hangman.game.GameAction;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * Contains the logic for the game.
	 */
	public class GameModel extends EventDispatcher
	{
		public var isLastMoveCorrect:Boolean;
		public var isInPlay:Boolean; // is guessing word
		public var score:int = -1;
		
		private var _category:String;
		private var _hint:String; // "държава"
		private var _keysPressed:Array = [];
		private var _mistakesCount:uint;
		private var _wordShown:String; // "__ст_а_ия"
		private var _word:String; // "австралия"
		private var _timeUsed:int;
		private var _hintUsed:Boolean;
		
		private var _isPaused:Boolean = false;

		public function set hintUsed(value:Boolean):void
		{
			_hintUsed = value;
		}
		
		public function get timeUsed():int
		{
			return _timeUsed;
		}

		public function set timeUsed(value:int):void
		{
			_timeUsed = value;
		}

		public function get category():String
		{
			return _category;
		}

		public function get keysPressed():Array
		{
			return _keysPressed;
		}
		
		public function get mistakesCount():uint
		{
			return _mistakesCount;
		}
		
		public function get wordShown():String
		{
			return _wordShown;
		}
		
		public function get hint():String
		{
			return _hint;
		}
		
		public function get word():String
		{
			return _word;
		}
		
		public function hasWon():Boolean
		{
			return score > 0;
		}
		
		private function isWordGuessed():Boolean
		{
			return word == _wordShown;
		}

		public function checkForLetter(letter:String):void
		{
			if (word == null)
				return;
			
			_keysPressed.push(letter);
			
			// check if the word contains the letter
			var letterIndex:int = word.indexOf(letter);
			if (letterIndex == -1)
			{
				_mistakesCount++;
				isLastMoveCorrect = false;
			}
			else
			{
				isLastMoveCorrect = true;
			}
			
			// open all the letters
			while (letterIndex != -1)
			{
				_wordShown = _wordShown.substring(0, letterIndex) + letter + _wordShown.substring(letterIndex + 1);
				letterIndex = word.indexOf(letter, letterIndex + 1);
			}
			trace("model mistakes: " + mistakesCount);
			
			if (isWordGuessed())
			{
				makeGameOver(true);
			}
			else if (_mistakesCount == Constants.MAX_MISTAKES) // is Hanged
			{
				makeGameOver(false);
			}
			else
			{
				update();
			}
		}

		public function startNewGame(category:String):void
		{
			_category = category;
			var newWord:Object = WordProvider.getNextWord(category);
			
			this._word = String(newWord["name"]).toLowerCase();
			
			switch (category)
			{
				case WordCategories.CAPITALS:
					this._hint = "Играеш за столица на " + newWord["hint"];
					break;
				case WordCategories.COUNTRIES:
					this._hint = "Играеш за държава в "+ newWord["hint"];
					break;
				case WordCategories.BG_TOWNS:
					this._hint = "Играеш за "+ newWord["hint"];
					break;
				default:
					this._hint = "Играеш за " + newWord["hint"];
			}
			
			_wordShown = this.word.replace(/[а-я]/g, '_');
			
			isInPlay = true;
			
			update(GameAction.BEGIN_NEW_GAME);
		}
		
		public function makeGameOver(hasWon:Boolean):void
		{
			trace("makeGameOver win: " + hasWon);
			
			isInPlay = false;
			
			// calculate score
			if (hasWon)
			{
				trace("_timeUsed : " + _timeUsed);
				
				if (_timeUsed <= 20 && _mistakesCount <= 4)
					score = 3;
				else if (_timeUsed <= 30)
					score = 2;
				else
					score = 1;
//				if ( ! _hintUsed)
//					score++;
			}
			else
			{
				score = 0;
			}
			
			update();
		}

		public function isGameOver():Boolean
		{
			return ! isInPlay && score >= 0;
		}
		
		public function reset():void
		{
			_keysPressed = [];
			_mistakesCount = 0;
			score = -1;
			// show menu
			update(GameAction.SHOW_START_MENU);
		}
		
		public function pauseGame():void
		{
			if ( ! _isPaused)
			{
				_isPaused = true;
				update(GameAction.PAUSE);
			}
		}
		
		public function resumeGame():void
		{
			if (_isPaused)
			{
				_isPaused = false;
				update(GameAction.RESUME);
			}
		}
		
		protected function update(data:Object = null):void
		{
			dispatchEventWith(Event.CHANGE, false, data);
		}

		public function get isPaused():Boolean
		{
			return _isPaused;
		}
	}
}