package com.asylum.control
{
	import com.asylum.data.AncientOne;
	import com.asylum.data.Config;
	import com.asylum.data.enum.NoteName;
	import com.asylum.factory.MonsterFactory;
	import com.asylum.model.SourceProxy;
	import com.asylum.util.XMLLoader;
	
	import org.puremvc.as3.interfaces.INotification;

	public class LoadAncientOnesCommand extends StartupTask
	{
		public function LoadAncientOnesCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void {
			var loader:XMLLoader = new XMLLoader(Config.i.abominationsURL, result, fault);
		}
		
		private function result(xml:XML):void {
			var sourceProxy:SourceProxy = facade.retrieveProxy(SourceProxy.NAME) as SourceProxy;
			var aboms:XMLList = xml..abomination;
			var abom:AncientOne;
			for each (var abomXML:XML in aboms) {
				abom = MonsterFactory.makeAncientOne(abomXML);
				sourceProxy.ancients.push(abom);
			}
			sendNotification(NoteName.SET_LOADING_TEXT, "ancient ones loaded...");
			complete(LoadAncientOnesCommand);
		}
		
		private function fault(info:Object):void {
			// do something here
		}
	}
}