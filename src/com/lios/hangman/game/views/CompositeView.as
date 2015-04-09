package com.lios.hangman.game.views
{
	import starling.events.Event;
	
	// ABSTRACT Class (should be subclassed and not instantiated)
	public class CompositeView extends ComponentView
	{
		private var aChildren:Array;
		
		public function CompositeView(aModel:Object, aController:Object = null)
		{
			super(aModel, aController);
			this.aChildren = new Array( );
		}
		
		override public function add(c:ComponentView):void
		{
			aChildren.push(c);
			
			this.addChild(c);
		}
		
		override public function update(event:Event = null):void
		{
			for each (var c:ComponentView in aChildren)
			{
				c.update(event);
			}
		}
	}
}