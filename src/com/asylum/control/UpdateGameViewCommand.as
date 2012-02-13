package com.asylum.control
{
	import com.asylum.data.Config;
	import com.asylum.data.GateInstance;
	import com.asylum.data.LocationState;
	import com.asylum.data.MonsterInstance;
	import com.asylum.data.Player;
	import com.asylum.data.enum.GamePhase;
	import com.asylum.data.enum.NoteName;
	import com.asylum.model.GameProxy;
	import com.asylum.view.map.MapMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class UpdateGameViewCommand extends SimpleCommand
	{
		public function UpdateGameViewCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var gameProxy:GameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			var mapMediator:MapMediator = facade.retrieveMediator(MapMediator.NAME) as MapMediator;
			if (notification.getBody().isFirstTime && notification.getBody().isFirstTime == true) {
				for each (var player:Player in gameProxy.players) {
					if (player.locationId != "") {
						mapMediator.addPlayer(player);
					}
				}
				for each (var mon:MonsterInstance in gameProxy.monsters) {
					if (mon.locationId != "" && !mon.isTrophy) {
						mapMediator.addMonster(mon);
					}
				}
				for each (var gate:GateInstance in gameProxy.gates) {
					if (gate.locationId != "" && !gate.isTrophy) {
						mapMediator.addGate(gate);
					}
				}
				sendNotification(NoteName.UPDATE_DOOM_LEVEL, {doom:gameProxy.doomTrack, max:gameProxy.boss.doom});
			} else {
				sendNotification(NoteName.UPDATE_DOOM_LEVEL, {doom:gameProxy.doomTrack});
			}
			
			if (gameProxy.phase == GamePhase.WAITING_FOR_PLAYERS) {
				sendNotification(NoteName.UPDATE_GAME_STATUS, "Waiting for Players");
			}
			sendNotification(NoteName.UPDATE_PLAY_LIST, {players:gameProxy.players});
			sendNotification(NoteName.UPDATE_TERROR_LEVEL, {level:gameProxy.terrorTrack});
			
			for each (var locState:LocationState in gameProxy.locationStates) {
				mapMediator.applyLocationState(locState);
			}
		}
	}
}