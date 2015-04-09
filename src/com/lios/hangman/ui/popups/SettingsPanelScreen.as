package com.lios.hangman.ui.popups
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.ui.assets.Assets;
	import com.lios.hangman.ui.themes.LightHangmanTheme;
	import com.lios.hangman.util.Settings;
	import com.lios.hangman.util.Translator;
	
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.PanelScreen;
	import feathers.controls.ToggleSwitch;
	import feathers.core.IToggle;
	import feathers.core.PopUpManager;
	import feathers.layout.HorizontalLayoutData;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class SettingsPanelScreen extends PanelScreen
	{
		/**
		 * Shows a settings popup.
		 * 
		 * @return reference to settings panel popup.
		 */
		public static function show():SettingsPanelScreen
		{
			var settingsScreen:SettingsPanelScreen = new SettingsPanelScreen();
			
			PopUpManager.addPopUp(settingsScreen);
			
			return settingsScreen;
		}
		
		public function SettingsPanelScreen()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.backButtonHandler = closeHandler;
			
			// scale panel -> smaller for tablets
			this.headerStyleName = LightHangmanTheme.THEME_STYLE_NAME_SCALED_TO_DPI_HEADER;
			this.nameList.add(LightHangmanTheme.THEME_STYLE_NAME_SCALED_TO_DPI_PANEL);
			
			this.title = Translator.instance.getPhrase("settingsTitle");
			
			this.headerFactory = function():Header
			{
				var header:Header = new Header();
				
				var closeButton:Button = new Button();
				closeButton.addEventListener(Event.TRIGGERED, closeHandler);
				
				closeButton.styleNameList.add(LightHangmanTheme.THEME_STYLE_NAME_CLOSE_BUTTON);
				header.rightItems = new <DisplayObject>[ closeButton ];
				
				header.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;
				
				return header;
			}
			
			var soundLayoutGroup:LayoutGroup = new LayoutGroup();
			soundLayoutGroup.nameList.add(LightHangmanTheme.THEME_STYLE_NAME_SETTINGS_LAYOUT_GROUP);
			this.addChild(soundLayoutGroup);
			
			const labelPercentWidth:Number = 60;
			var soundLabelLayoutData:HorizontalLayoutData = new HorizontalLayoutData();
			soundLabelLayoutData.percentWidth = labelPercentWidth;
			
			var soundLabel:Label = new Label();
			soundLabel.nameList.add(LightHangmanTheme.THEME_STYLE_NAME_SCALED_TO_DPI_LABEL);
			soundLabel.text = Translator.instance.getPhrase("sound");
			soundLabel.layoutData = soundLabelLayoutData;
			soundLayoutGroup.addChild(soundLabel);
			
			var toggleLayoutData:HorizontalLayoutData = new HorizontalLayoutData();
			toggleLayoutData.percentWidth = 100 - labelPercentWidth;
			
			var toggle:ToggleSwitch = new ToggleSwitch();
			toggle.nameList.add(LightHangmanTheme.THEME_STYLE_NAME_SCALED_TO_DPI_TOGGLE_SWITCH);
			toggle.layoutData = toggleLayoutData;
			toggle.isSelected = Number(Settings.instance.getSetting("volume")) == 1 ? true : false;
			toggle.addEventListener( Event.CHANGE, sound_changeHandler );
			toggle.onText = Translator.instance.getPhrase("on");
			toggle.offText = Translator.instance.getPhrase("off");
			soundLayoutGroup.addChild(toggle);
			
			var aboutLayoutGroup:LayoutGroup = new LayoutGroup();
			aboutLayoutGroup.nameList.add(LightHangmanTheme.THEME_STYLE_NAME_SETTINGS_LAYOUT_GROUP);
			this.addChild(aboutLayoutGroup);
			
			var aboutLabel:Label = new Label();
			aboutLabel.nameList.add(LightHangmanTheme.THEME_STYLE_NAME_SCALED_TO_DPI_LABEL);
			aboutLabel.text = Translator.instance.getPhrase("aboutLabel");
			aboutLabel.addEventListener(TouchEvent.TOUCH, aboutLabel_touchHandler);
			aboutLayoutGroup.addChild(aboutLabel);
		}
		
		private function closeHandler():void
		{
			Assets.playSound(Constants.SOUND_BUTTON);
			this.removeFromParent(true);
		}
		
		private function aboutLabel_touchHandler(e:Event):void
		{
			AboutAlert.show();
			this.removeFromParent(true);
		}
		
		private function sound_changeHandler(event:Event = null):void
		{
			if ((event.target as IToggle).isSelected)
			{
				trace("show mute");
				Settings.instance.setSetting("volume", 1, true);
				SoundMixer.soundTransform = new SoundTransform(1);
			}
			else
			{
				trace("show sound");
				Settings.instance.setSetting("volume", 0, true);
				SoundMixer.soundTransform = new SoundTransform(0);
			}
			Assets.playSound(Constants.SOUND_BUTTON);
			trace("sound: " + SoundMixer.soundTransform.volume); //0
		}
	}
}