package com.asylum.control
{
	import com.asylum.data.Config;
	import com.asylum.data.Log;
	import com.asylum.model.GameProxy;
	import com.asylum.util.XMLService;
	import com.asylum.view.log.LogMediator;
	
	import mx.utils.StringUtil;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SendChatCommand extends SimpleCommand
	{
		private var tempId:String;
		private var logMediator:LogMediator;
		
		public function SendChatCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var msg:String = notification.getBody().chat as String;
			logMediator = notification.getBody().logMediator as LogMediator;
			var gameProxy:GameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			tempId = "";
			// set up chat
			var chat:Log = new Log();
			chat.player = gameProxy.getUser();
			chat.text = StringUtil.trim(msg);
			chat.isChat = true;
			chat.id = tempId = "chat_" + chat.player.id + "_" + chat.time.getTime();
			// add to view
			logMediator.addLog(chat, true, true);
			// send to server
			if (!Config.i.isLocalMode) {
				var service:XMLService = new XMLService(Config.i.gameURL, onReturn, onFault);
				service.load(notification.getName(), {'chat':chat.text});
			}
		}
		
		private function onReturn(xml:XML):void {
			if ( xml.child("chat").length() > 0 && xml.chat[0].hasOwnProperty("@id") ) {
				var serverId:String = xml.chat[0].@id;
				logMediator.updateLogId(tempId, serverId);
			}
			logMediator = null;
			tempId = null;
		}
		
		private function onFault(info:Object):void {
			
		}
	}
}