package com.lios.hangman.game.views
{
	import starling.display.Sprite;
	import flash.errors.IllegalOperationError;
	import starling.events.Event;
	
	// ABSTRACT Class (should be subclassed and not instantiated)
	public class ComponentView extends Sprite
	{
		protected var model:Object;
		protected var controller:Object;
		
		public function ComponentView(aModel:Object, aController:Object = null)
		{
			this.model = aModel;
			this.controller = aController;
		}
		
		public function add(c:ComponentView):void
		{
			throw new IllegalOperationError("add operation not supported");
		}
		
		public function remove(c:ComponentView):void
		{
			throw new IllegalOperationError("remove operation not supported");
		}
		
		public function getChild(n:int):ComponentView
		{
			throw new IllegalOperationError("getChild operation not supported");return null;
		}
		
		// ABSTRACT Method (must be overridden in a subclass)
		public function update(event:Event = null):void 
		{
			throw new IllegalOperationError("ABSTRACT Method (must be overridden in a subclass)");
		}
	}
}