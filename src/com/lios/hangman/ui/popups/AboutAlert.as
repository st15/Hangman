package com.lios.hangman.ui.popups
{
	import com.lios.hangman.util.Translator;
	
	import feathers.controls.Alert;
	import feathers.controls.ScrollText;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;

	public class AboutAlert
	{
		/**
		 * Shows a popup alert that asks the user if he/she would like to rate the app on Google Play
		 * 
		 * @return reference to the alert
		 */
		public static function show():Alert
		{
			var alert:Alert = new Alert();
			alert.title = Translator.instance.getPhrase("aboutTitle");
			alert.buttonsDataProvider = new ListCollection([{ label: Translator.instance.getPhrase("close") } ]);
			
			var scrollText:ScrollText = new ScrollText();
			scrollText.isHTML = true;
			scrollText.text = Translator.instance.getPhrase("aboutMsg");
			scrollText.width = 522;
			scrollText.height = 380;
			alert.addChild(scrollText);
			
			PopUpManager.addPopUp(alert);
			
			return alert;
		}
	}
}