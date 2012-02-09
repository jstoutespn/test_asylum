package com.asylum.model
{
	import com.asylum.data.enum.NoteName;
	
	import flash.utils.Dictionary;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class StartupProxy extends Proxy
	{
		public static const NAME:String = "startupProxy";
		
		private var taskIndex:Dictionary;
		private var _isComplete:Boolean;
		
		public function StartupProxy()
		{
			taskIndex = new Dictionary();
			super(NAME, taskIndex);
		}
		
		override public function onRemove():void {
			taskIndex = null;
		}
		
		public function hasTask(task:Class):Boolean {
			if (taskIndex[task] != null) {
				return true;
			}
			return false;
		}
		public function registerTask(task:Class):void {
			taskIndex[task] = false;
		}
		
		public function registerTaskComplete(task:Class):void {
			taskIndex[task] = true;
			checkAllTasks();
		}
		
		private function checkAllTasks():void {
			var complete:Boolean = true;
			for (var task:Object in taskIndex) {
				if (taskIndex[task] == false) {
					complete = false;
					break;
				}
			}
			if (complete) {
				_isComplete = true;
				sendNotification(NoteName.APP_STARTED);
			}
		}

		public function get isComplete():Boolean
		{
			return _isComplete;
		}
	}
}