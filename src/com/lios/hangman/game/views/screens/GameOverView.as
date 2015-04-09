package com.lios.hangman.game.views.screens
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.game.controllers.GameController;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.game.views.ComponentView;
	import com.lios.hangman.ui.PullDownScreen;
	import com.lios.hangman.ui.assets.Assets;
	import com.lios.hangman.ui.popups.RatingsAlert;
	import com.lios.hangman.ui.themes.LightHangmanTheme;
	import com.lios.hangman.util.Settings;
	import com.lios.hangman.util.Translator;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	
	public class GameOverView extends ComponentView
	{
		private var pullDownScreen:PullDownScreen;
		
		private var stars:Array;
		private var gameResultLabel:Label;
		private var winLabel:Label;
		private var loseLabel:Label;
		private var failText:Label;
		
		private var totalGames:int;
		private var wins:int;
		private var bestTime:int;
		private var totalScore:int;
		private var luckyStreak:int;
		private var isRateDialogShown:Boolean;
		
		public function GameOverView(aModel:Object, aController:Object=null)
		{
			super(aModel, aController);
			
			isRateDialogShown = Boolean(Settings.instance.getSetting("isRateDialogShown"));
			
			// init game result
			pullDownScreen = new PullDownScreen(true);
			
			const titleWidth:Number = 1030; //1012;
			const titleHeight:Number = 90;
			const titleX:Number = (pullDownScreen.baseWidth - titleWidth) * 0.5;
			const titleY:Number = 150;
			
			// win
			var winSkin:Scale3Image = new Scale3Image(new Scale3Textures(Assets.getTexture("bannerGreenBig"), 100, 308)); 
			winSkin.filter = BlurFilter.createDropShadow(3, 1, 0x000000, 0.4, 0.3, 0.6); 
			winLabel = new Label();
			winLabel.width = titleWidth;
			winLabel.paddingTop = 10;
			winLabel.text = Translator.instance.getPhrase("youWon");
			winLabel.backgroundSkin = winSkin;
			winLabel.x = titleX; 
			winLabel.y = titleY;
			winLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			pullDownScreen.addChild(winLabel);
			
			// lose
			var loseSkin:Scale3Image = new Scale3Image(new Scale3Textures(Assets.getTexture("bannerRedBig"), 100, 308)); 
			loseSkin.filter = BlurFilter.createDropShadow(3, 1, 0x000000, 0.4, 0.3, 0.6);
			loseLabel = new Label();
			loseLabel.width = titleWidth;
			loseLabel.paddingTop = 10;
			loseLabel.text = Translator.instance.getPhrase("youLost");
			loseLabel.backgroundSkin = loseSkin;
			loseLabel.x = titleX; 
			loseLabel.y = titleY;
			loseLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			pullDownScreen.addChild(loseLabel);
			
			// results 
			gameResultLabel = new Label();
			gameResultLabel.textRendererFactory = resultsLabelFactory;
			gameResultLabel.minWidth = 800;
			gameResultLabel.maxWidth = 800;
			gameResultLabel.height = 180;
			gameResultLabel.x = (pullDownScreen.baseWidth - gameResultLabel.minWidth) * 0.5;
			gameResultLabel.y = 380;
			
			pullDownScreen.addChild(gameResultLabel);
			
			// fail text
			failText = new Label();
			failText.textRendererFactory = failLabelFactory;
			failText.minWidth = 800;
			failText.maxWidth = 800;
			failText.height = 140;
			failText.wordWrap = true;
			failText.x = (pullDownScreen.baseWidth - failText.minWidth) * 0.5;
			failText.y = 310;
			
			pullDownScreen.addChild(failText);
			
			// star
			stars = [new Image(starling.textures.Texture.empty(94,90)),
				new Image(starling.textures.Texture.empty(94,90)),
				new Image(starling.textures.Texture.empty(94,90))];
			
			var starsCont:Sprite = new Sprite();
			for (var i:int = 0; i < stars.length; i++)
			{
				stars[i].scaleX = stars[i].scaleY = 0.7;
				
				stars[i].x = i * 70;
				stars[i].y = 285;
				starsCont.addChild(stars[i]);
			}
			stars[1].y -= 40;
			starsCont.x = (pullDownScreen.baseWidth - starsCont.width) * 0.5;
			pullDownScreen.addChild(starsCont);
			
			var newGameButton:Button = new Button();
			newGameButton.defaultSkin = new Scale3Image(new Scale3Textures(Assets.getTexture("normal"), 10, 40));
			newGameButton.downSkin = new Scale3Image(new Scale3Textures(Assets.getTexture("pressed"), 10, 40));
			newGameButton.labelFactory = function():ITextRenderer
			{
				var renderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				renderer.textFormat = new TextFormat(
					Constants.FONT_HANDWRITTEN,
					Constants.BUTTON_FONT_SIZE, 
					0xffffff, true, null, null, null,null,TextFormatAlign.LEFT);
				renderer.snapToPixels = true;
				renderer.antiAliasType = AntiAliasType.ADVANCED;
				renderer.nativeFilters = [Constants.DROP_SHADOW_FILTER];
				
				renderer.embedFonts = true;
				return renderer;
			}
			
			newGameButton.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			newGameButton.label = Translator.instance.getPhrase("newGame");
			newGameButton.addEventListener(Event.TRIGGERED, newGameButton_triggered);
			
			newGameButton.defaultIcon = new Image(Assets.getTexture("arrow")); //, TextureSmoothing.TRILINEAR);
			newGameButton.iconPosition = Button.ICON_POSITION_RIGHT;
			newGameButton.iconOffsetX = 10;
			
			newGameButton.width = 300;
			newGameButton.height = 70;
			newGameButton.x = (pullDownScreen.baseWidth - newGameButton.width) * 0.5;
			newGameButton.y = 550;
			pullDownScreen.addChild(newGameButton);
			
			var facebookButton:Button = new Button();
			facebookButton.styleNameList.add(LightHangmanTheme.THEME_STYLE_NAME_FACEBOOK_BUTTON);
			facebookButton.addEventListener( Event.TRIGGERED, facebook_triggeredHandler );
			facebookButton.x = newGameButton.x + 40; 
			facebookButton.y = 655;
			pullDownScreen.addChild(facebookButton);
		}
		
		private function failLabelFactory():ITextRenderer
		{
			var renderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			renderer.textFormat = new TextFormat(Constants.FONT_HANDWRITTEN,  Constants.FONT_SIZE_LARGE, 
				Constants.COLOR_DARK_GREEN, true, null, null, null,null,TextFormatAlign.CENTER,
				null,null,null,-12);
			
			renderer.isHTML = true;
			renderer.embedFonts = true;
			renderer.snapToPixels = true;
			renderer.antiAliasType = AntiAliasType.ADVANCED;
			renderer.wordWrap = true;
			return renderer;
		}
		
		private function resultsLabelFactory():ITextRenderer
		{
			var renderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			renderer.textFormat = new TextFormat(Constants.FONT_HANDWRITTEN, Constants.MEDIUM_FONT_SIZE, 
				Constants.COLOR_DARK_GREEN, true, null, null, null,null,TextFormatAlign.CENTER,
				null,null,null,-1);
			
			renderer.isHTML = true;
			renderer.embedFonts = true;
			renderer.snapToPixels = true;
			renderer.antiAliasType = AntiAliasType.ADVANCED;
			return renderer;
		}
		
		private function facebook_triggeredHandler(e:Event):void
		{
			var request:URLRequest = new URLRequest("http://m.facebook.com/BesenicaBG");
			navigateToURL(request);
		}
		
		private function newGameButton_triggered(e:Event):void
		{
			trace("newGameButton_triggered");
			
			// show ratings dialog
			if (! isRateDialogShown 
//				&& NetStatusMonitor.instance.hasConnection // has internet conn
				&& luckyStreak >= 2
				&& totalGames > 30) 
			{
				RatingsAlert.show();
				// няма да се показва, ако вече е показан от момента на стартиране на приложението
				isRateDialogShown = true;
			}
			
			pullDownScreen.hide();
			(controller as GameController).showStartMenu();
		}
		
		override public function update(event:Event = null):void 
		{
			if (pullDownScreen.parent)
				return;
			
			trace("game over event data: " + event.data);
			trace("game over view is game over : " + GameModel(model).isGameOver());
			if (GameModel(model).isGameOver())
			// if (event.data == GameAction.END_GAME)
			{
				luckyStreak = int(Settings.instance.getSetting("luckyStreak"));
				totalGames = int(Settings.instance.getSetting("totalGames"));
				wins = int(Settings.instance.getSetting("wins"));
				bestTime = int(Settings.instance.getSetting("bestTime"));
				totalScore = int(Settings.instance.getSetting("totalScore"));
				
				var i:int;
				var score:int = GameModel(model).score; //model.timeUsed 
				
				var bestTimeText:String;
				var currentTimeText:String;
				
				if (score == 0)
				{
					winLabel.visible = false;
					loseLabel.visible = true;
					currentTimeText = "";
					if (bestTime < 60)
						bestTimeText = Translator.instance.getPhrase("bestTimeSec", [bestTime]);
					else
						bestTimeText = "";
					
					for (i = 0; i < stars.length; i++)
					{
						stars[i].visible = false;
					}
					failText.visible = true;
					// get data from model
					var word:String = GameModel(model).word;
					
					failText.text = "<b>" + Translator.instance.getPhrase("lastWord") 
						+ ": "
						+ "<font color=\"#FF0000\">"
						+ word.substr(0, 1).toUpperCase() 
						+ word.substr(1, word.length-1)
						+"</font></b>";
					
					Settings.instance.setSetting("luckyStreak", 0);
				}
				else
				{
					var time:int = GameModel(model).timeUsed;
					trace(">>> time >>>> " + time);
					loseLabel.visible = false;
					winLabel.visible = true;
					failText.visible = false;
					if (time < bestTime)
					{
						bestTimeText = Translator.instance.getPhrase("bestTimeEver");
						Settings.instance.setSetting("bestTime", time);
					}
					else
					{
						bestTimeText = Translator.instance.getPhrase("bestTimeSec", [bestTime]);
					}
					currentTimeText = "<font color=\"#FF0000\">" 
						+ Translator.instance.getPhrase("timeSec", [time])
						+ "</font>";
					
					for (i = 0; i < score; i++)
					{
						trace("full star : " + i);
						stars[i].texture = Assets.getTexture("star");
						stars[i].visible = true;
					}
					
					for (i = score; i < stars.length; i++)
					{
						trace("empty star : " + i);
						stars[i].texture = Assets.getTexture("starEmpty");
						stars[i].visible = true;
					}
					
					wins++;
					totalScore += score;
					
					Settings.instance.setSetting("luckyStreak", ++luckyStreak);
				}
				
				totalGames++;
				Settings.instance.setSetting("totalGames", totalGames);
				Settings.instance.setSetting("wins", wins);
				Settings.instance.setSetting("totalScore", totalScore);
				Settings.instance.saveSettings();
				
				gameResultLabel.text = currentTimeText
					+ "<br />"
					+ bestTimeText
					+ "<br />"
					+ Translator.instance.getPhrase("guessedWords", [wins, totalGames]);
				
				Starling.juggler.delayCall(pullDownScreen.show, 0.8, this);
			}
		}
	}
}

