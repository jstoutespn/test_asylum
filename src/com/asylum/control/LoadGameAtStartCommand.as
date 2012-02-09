package com.asylum.control
{
	import com.asylum.data.Config;
	import com.asylum.data.Player;
	import com.asylum.data.enum.GamePhase;
	import com.asylum.data.enum.NoteName;
	import com.asylum.factory.PlayerFactory;
	import com.asylum.model.GameProxy;
	import com.asylum.util.XMLLoader;
	
	import org.puremvc.as3.interfaces.INotification;

	public class LoadGameAtStartCommand extends StartupTask
	{
		public function LoadGameAtStartCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var args:Object = {game:Config.i.gameId, uid:Config.i.userId, lastUpdate:0};
			var loader:XMLLoader = new XMLLoader(Config.i.gameURL, onResult, onFault, args, true);
		}
		
		private function onResult(xml:XML):void {
			if ( !xml.hasOwnProperty("@id") ) {
				// throw some sort of error here and deny access
				return;
			}
			var gameProxy:GameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			gameProxy.gamePhase = xml.@phase;
			// get players regardless of phase
			var playerList:XMLList = xml..players.player;
			var player:Player;
			for each (var playerXML:XML in playerList) {
				player = PlayerFactory.makePlayer(playerXML);
				gameProxy.players.push(player);
			}
			// do stuff based on game's phase
			if (gameProxy.gamePhase == GamePhase.GAME_SETUP) {
				
			} else if (gameProxy.gamePhase == GamePhase.WAITING_FOR_PLAYERS) {
				
			} else if (gameProxy.gamePhase == GamePhase.PLAYING) {
				
			}
			sendNotification(NoteName.SET_LOADING_TEXT, "game loaded...");
			complete(LoadGameAtStartCommand);
		}
		
		private function onFault(info:Object):void {
			
		}
	}
}