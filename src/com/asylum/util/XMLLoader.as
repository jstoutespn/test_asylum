package com.asylum.util
{
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	public class XMLLoader implements IResponder
	{
		private var service:HTTPService;
		private var resultFunction:Function;
		private var faultFunction:Function;
		
		public function XMLLoader(url:String, onResult:Function, onFault:Function, params:Object = null)
		{
			resultFunction = onResult;
			faultFunction = onFault;
			service = new HTTPService();
			service.url = url;
			service.resultFormat = 'e4x';
			service.send(params).addResponder(this);
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
			resultFunction = null;
			faultFunction = null;
			service = null;
		}
	}
}