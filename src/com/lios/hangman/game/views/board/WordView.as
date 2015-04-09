package com.lios.hangman.game.views.board
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.game.views.ComponentView;
	
	import starling.events.Event;
	import starling.text.TextField;

	public class WordView extends ComponentView
	{
		private var textField:TextField;
		
		public function WordView(aModel:Object, aController:Object=null)
		{
			super(aModel, aController);			
			
			// word text field
			textField = new TextField(600, 190, "", 
				Constants.CHALK_FONT_NAME, 
				Constants.FONT_SIZE, Constants.COLOR_YELLOW_FONT);
			textField.autoScale = true;

			this.addChild(textField);
		}
		
		override public function update(event:Event = null):void
		{
			// get data from model and update view
			
			textField.text = GameModel(model).wordShown;
		}
	}
}