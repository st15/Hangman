package com.lios.hangman.game.views.board
{
	import com.lios.hangman.Constants;
	import com.lios.hangman.game.GameAction;
	import com.lios.hangman.game.controllers.GameController;
	import com.lios.hangman.game.models.GameModel;
	import com.lios.hangman.game.views.ComponentView;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class TimerView extends ComponentView
	{
		private var timer:Timer;
		private var textField:TextField;
		
		public function TimerView(aModel:Object, aController:Object=null)
		{
			super(aModel, aController);
			
			timer = new Timer(1000, Constants.TIME);
			timer.addEventListener(TimerEvent.TIMER, timer_handler, false, 0, true);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_completeHandler, false, 0, true);
			
			textField = new TextField(90, 90, String(Constants.TIME), 
				Constants.FONT_HANDWRITTEN,
				Constants.TIMER_FONT_SIZE, 
				Constants.COLOR_TIMER_FONT 
			);
			
			textField.hAlign = HAlign.LEFT;
			textField.x = 880;
			textField.y = 36;
			textField.visible = false;
			
			this.addChild(textField);
		}
		
		protected function timer_completeHandler(e:TimerEvent):void
		{
			timer.reset();
			// delegate to the controller (strategy) to handle it
			(this.controller as GameController).onTimeOver();
		}
		
		protected function timer_handler(e:TimerEvent):void
		{
			var time:String = String(Constants.TIME - timer.currentCount);
			if (time.length < 2 && time != "0")
				time = "0" + time;
			
			textField.text = time;
			(this.controller as GameController).setLastGameTime(timer.currentCount);
		}
		
		override public function update(event:Event = null):void
		{
			if (GameModel(model).isGameOver()) // game over
			{
				timer.stop();
				timer.reset();
				textField.visible = false;
			}
			else if (event.data == GameAction.BEGIN_NEW_GAME)
			{
				// show and start the timer
				timer.start();
				textField.text = String(Constants.TIME);
				textField.visible = true;
			}
			else if (event.data == GameAction.PAUSE)
			{
				if (timer.running)
					timer.stop();
			}
			else if (event.data == GameAction.RESUME)
			{
				if (timer.currentCount > 0)
					timer.start();
			}
		}	
	}
}