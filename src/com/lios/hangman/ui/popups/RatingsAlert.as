package com.lios.hangman.ui.popups
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.ui.assets.Assets;
	import com.lios.hangman.util.Settings;
	import com.lios.hangman.util.Translator;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import starling.display.Image;
	import starling.events.Event;

	public class RatingsAlert
	{
		/**
		 * Shows a popup alert that asks the user if he/she would like to rate the app on Google Play
		 * 
		 * @return reference to the alert
		 */
		public static function show():Alert
		{
			var onButtonOk:Function = function buttonOK_triggeredHandler(e:Event):void {
				navigateToURL(new URLRequest(Constants.GOOGLE_PLAY_URL));
				Settings.instance.setSetting("isRateDialogShown", true);
			};
			var onButtonNo:Function = function (e:Event):void { 
				Settings.instance.setSetting("isRateDialogShown", true); 
			};
			
			return Alert.show( 
				Translator.instance.getPhrase("rateMsg"), 
				Translator.instance.getPhrase("rateTitle"), 
				new ListCollection(
					[
						{ label: Translator.instance.getPhrase("ok"), 
							triggered: onButtonOk },
						{ label: Translator.instance.getPhrase("no"), 
							triggered: onButtonNo },
						{ label: Translator.instance.getPhrase("later"), 
							triggered: null }
					]),
				new Image(Assets.getTexture("owl")));
		}
	}
}