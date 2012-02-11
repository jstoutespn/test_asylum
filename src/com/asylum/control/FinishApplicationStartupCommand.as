package com.asylum.control
{
	import com.asylum.data.enum.ApplicationScreen;
	import com.asylum.data.enum.GamePhase;
	import com.asylum.data.enum.NoteName;
	import com.asylum.model.GameProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class FinishApplicationStartupCommand extends SimpleCommand
	{
		public function FinishApplicationStartupCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void {
			var gameProxy:GameProxy = facade.retrieveProxy(GameProxy.NAME) as GameProxy;
			if (gameProxy.phase == GamePhase.GAME_SETUP) {
				sendNotification(NoteName.SET_SCREEN, {screen:ApplicationScreen.BOSS_SELECT});
			} else if (gameProxy.phase == GamePhase.WAITING_FOR_PLAYERS || gameProxy.phase == GamePhase.PLAYING) {
				sendNotification(NoteName.SET_SCREEN, {screen:ApplicationScreen.PLAYING});
			}
		}
	}
}