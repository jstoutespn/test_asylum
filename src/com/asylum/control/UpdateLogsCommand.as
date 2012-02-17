package com.asylum.control
{
	import com.asylum.data.Log;
	import com.asylum.data.Player;
	import com.asylum.model.GameProxy;
	import com.asylum.view.log.LogMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class UpdateLogsCommand extends SimpleCommand
	{
		public function UpdateLogsCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var logMediator:LogMediator = facade.retrieveMediator(LogMediator.NAME) as LogMediator;
			var gameProxy:GameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			var xml:XML = notification.getBody().xml;
			var renderAll:Boolean = false;
			if (notification.getBody().hasOwnProperty('renderAll')) {
				renderAll = notification.getBody().renderAll as Boolean;
			}
			
			var logList:XMLList = xml..log.(@time >= logMediator.lastTimestamp.getTime());
			var chatList:XMLList = xml..chat.(@time >= logMediator.lastTimestamp.getTime());
			var hazLogs:Boolean = false;
			var log:Log;
			var timestamp:uint;
			if (logList.length() > 0) {
				hazLogs = true;
				var logstr:String;
				var tokens:Object;
				var temp:String;
				var token:String;
				for each (var logXML:XML in logList) {
					log = new Log();
					log.id = logXML.@id;
					log.player = gameProxy.getPlayer(logXML.@player);
					timestamp = parseFloat(logXML.@time) as uint;
					log.time.setTime(timestamp);
					logstr = logXML.toString();
					tokens = parseLogTokens(logstr);
					if (tokens != null) {
						if (tokens.hasOwnProperty('player')) {
							temp = tokens['player'];
							var playerRef:Player = gameProxy.getPlayer(temp);
							if (playerRef != null) {
								token = tokens['playerraw'];
								logstr = logstr.replace(token, playerRef.name);
							}
						}
					}
					log.text = logstr;
					logMediator.addLog(log);
				}
			}
			if (chatList.length() > 0) {
				hazLogs = true;
				for each (var chatXML:XML in chatList) {
					log = new Log();
					log.id = chatXML.@id;
					log.player = gameProxy.getPlayer(chatXML.@player);
					timestamp = parseFloat(chatXML.@time) as uint;
					log.time.setTime(timestamp);
					log.text = chatXML.toString();
					log.isChat = true;
					logMediator.addLog(log);
				}
			}
			if (hazLogs && renderAll) {
				logMediator.refresh();
			} else {
				logMediator.update();
			}
		}
		
		private function parseLogTokens(log:String):Object {
			if (log.indexOf("{{") > -1) {
				var parse:Object = new Object();
				var split:Array;
				var tokenstr:String;
				var startpt:int;
				var endpt:int;
				var key:String;
				var rawkey:String;
				var val:String;
				while(log.indexOf("{{") > -1) {
					startpt = log.indexOf("{{") + 2;
					endpt = log.indexOf("}}");
					tokenstr = log.slice(startpt, endpt);
					split = tokenstr.split(":");
					key = String(split[0]);
					val = String(split[1]);
					parse[key] = val;
					rawkey = key + "raw";
					parse[rawkey] = "{{" + tokenstr + "}}";
					log = log.replace("{{", "");
				}
				return parse;
			}
			return null;
		}
	}
}