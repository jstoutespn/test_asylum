package com.asylum.util
{
	import com.asylum.data.Config;
	
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	public class XMLService implements IResponder
	{
		private var service:HTTPService;
		private var resultFunction:Function;
		private var faultFunction:Function;
		
		public function XMLService(url:String, onResult:Function, onFault:Function)
		{
			resultFunction = onResult;
			faultFunction = onFault;
			service = new HTTPService();
			service.url = url;
			service.resultFormat = 'e4x';
			service.method = 'POST';
		}
		
		public function load(action:String, parameters:Object = null, preventCache:Boolean = true):void {
			if (parameters) {
				parameters['action'] = action;
				parameters['game'] = Config.i.gameId;
				parameters['user'] = Config.i.userId;
				parameters['time'] = Clock.getTime();
			} else {
				parameters = {'action':action, 'game':Config.i.gameId, 'user':Config.i.userId, 'time':Clock.getTime()};
			}
			if (preventCache) {
				var rand:Number = Math.ceil(Math.random() * Clock.getTime());
				parameters['rand'] = rand;
			}
			service.send(parameters).addResponder(this);
		}
		
		public function result(data:Object):void
		{
			var xml:XML = data['result'] as XML;
			resultFunction(xml);
			clear();
		}
		
		public function fault(info:Object):void
		{
			faultFunction(info);
			clear();
		}
		
		private function clear():void {
			service = null;
			resultFunction = null;
			faultFunction = null;
		}
	}
}