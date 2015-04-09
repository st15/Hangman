package com.lios.hangman.game.views.screens
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.WordCategories;
	import com.lios.hangman.game.GameAction;
	import com.lios.hangman.game.controllers.GameController;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.game.views.ComponentView;
	import com.lios.hangman.ui.PullDownScreen;
	import com.lios.hangman.ui.assets.Assets;
	import com.lios.hangman.ui.popups.SettingsPanelScreen;
	import com.lios.hangman.ui.themes.LightHangmanTheme;
	import com.lios.hangman.util.Translator;
	
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Label;
	import feathers.data.ListCollection;
	import feathers.display.Scale3Image;
	import feathers.textures.Scale3Textures;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.filters.BlurFilter;

	public class MainMenuView extends ComponentView
	{
		private var pullDownScreen:PullDownScreen;
		
		public function MainMenuView(aModel:Object, aController:Object=null)
		{
			super(aModel, aController);
			
			pullDownScreen = new PullDownScreen(true);
			
			var titleSkin:Scale3Image = new Scale3Image(new Scale3Textures(Assets.getTexture("bannerYellowBig"), 50, 319));
			titleSkin.filter = BlurFilter.createDropShadow(3, 0.9, 0x000000, 0.4, 0.3, 0.6); 
			titleSkin.flatten();
			
			const titleWidth:Number = 600;
			
			var titleLabel:Label = new Label();
			titleLabel.width = titleWidth;
			titleLabel.height = 80;
			titleLabel.padding = 15;
			titleLabel.paddingTop = 10;
			titleLabel.text = Translator.instance.getPhrase("hangman");
			titleLabel.backgroundSkin = titleSkin;
			titleLabel.x = (pullDownScreen.baseWidth - titleWidth) * 0.5; 
			titleLabel.y = 150;
			titleLabel.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
			pullDownScreen.addChild(titleLabel);
			
			var settingsButton:Button = new Button();
			settingsButton.styleNameList.add(LightHangmanTheme.THEME_STYLE_NAME_SETTINGS_BUTTON);
			settingsButton.addEventListener(Event.TRIGGERED, settingsButton_triggeredHandler);
			settingsButton.x = 800;
			settingsButton.y = 154;
			pullDownScreen.addChild(settingsButton);
			
			var group:ButtonGroup = new ButtonGroup();
			group.direction = ButtonGroup.DIRECTION_VERTICAL;
			
			group.dataProvider = new ListCollection(
				[
					{ label: Translator.instance.getPhrase("bgTowns"), 
						defaultIcon: new Image(Assets.getTexture("bgTowns")), 
						iconOffsetX : 0,
						triggered: bgTowns_triggeredHandler },
					{ label: Translator.instance.getPhrase("capitals"), 
						defaultIcon: new Image(Assets.getTexture("capitals")), 
						triggered: capitals_triggeredHandler },
					{ label: Translator.instance.getPhrase("countries"), 
						defaultIcon: new Image(Assets.getTexture("countries")), 
						triggered: countries_triggeredHandler },
					{ label: Translator.instance.getPhrase("dictionary"), 
						defaultIcon: new Image(Assets.getTexture("dictionary")), 
						triggered: dictionary_triggeredHandler }
				]);
			
			group.width = 500;
			group.height = 400;
			group.x = (pullDownScreen.baseWidth - group.width) * 0.5;
			group.y = 280;
			pullDownScreen.addChild(group);
		}
		
		private function settingsButton_triggeredHandler(e:Event):void
		{
			Assets.playSound(Constants.SOUND_BUTTON);
			SettingsPanelScreen.show();
		}
		
		private function bgTowns_triggeredHandler(event:Event = null):void
		{
			(controller as GameController).startNewGame(WordCategories.BG_TOWNS);
		}
		
		private function capitals_triggeredHandler(event:Event = null):void
		{
			(controller as GameController).startNewGame(WordCategories.CAPITALS);
		}
		
		private function countries_triggeredHandler(event:Event = null):void
		{
			(controller as GameController).startNewGame(WordCategories.COUNTRIES);
		}
		
		private function dictionary_triggeredHandler(event:Event = null):void
		{
			(controller as GameController).startNewGame(WordCategories.WORDS);
		}
		
		override public function update(event:Event = null):void 
		{
			if (GameModel(model).isPaused)
			{
				return;
			}
			else if (event.data == GameAction.SHOW_START_MENU && pullDownScreen.parent == null) 
			{
				pullDownScreen.show(this);
			}
			else if (event.data == GameAction.BEGIN_NEW_GAME)
			{
				pullDownScreen.hide();
			}
		}
	}
}