package com.asylum.mediator
{
	import flash.utils.Dictionary;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class BaseMediator extends Mediator
	{
		protected var interests:Dictionary;
		
		public function BaseMediator(mediatorName:String=null, viewComponent:Object=null)
		{
			interests = new Dictionary();
			super(mediatorName, viewComponent);
		}
		
		override public function listNotificationInterests():Array
		{
			var interestList:Array = new Array();
			for (var key:String in interests) {
				interestList.push(key);
			}
			return interestList;
		}
		
		override public function handleNotification(notification:INotification):void
		{
			if ( interests[ notification.getName() ] != null ) {
				interests[ notification.getName() ](notification);
			}
		}
		
		protected function addInterest(name:String, handler:Function):void 
		{
			interests[name] = handler;
		}
		
		protected function removeInterest(name:String, handler:Function):void
		{
			delete interests[name];
		}
	}
}