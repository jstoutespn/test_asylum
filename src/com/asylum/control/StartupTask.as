package com.asylum.control
{
	import com.asylum.model.StartupProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartupTask extends SimpleCommand
	{
		protected var startupProxy:StartupProxy;
		
		public function StartupTask()
		{
			super();
			startupProxy = facade.retrieveProxy(StartupProxy.NAME) as StartupProxy;
		}
		
		protected function complete(task:Class):void {
			startupProxy.registerTaskComplete(task);
		}
	}
}