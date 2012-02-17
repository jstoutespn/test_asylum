package com.asylum.control
{
	import com.asylum.data.enum.NoteName;
	import com.asylum.model.GameProxy;
	import com.asylum.model.SourceProxy;
	import com.asylum.model.StartupProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class SetupApplicationCommand extends SimpleCommand
	{
		public function SetupApplicationCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			// register models
			facade.registerProxy(new GameProxy());
			facade.registerProxy(new SourceProxy());
			var startupProxy:StartupProxy = new StartupProxy();
			facade.registerProxy(startupProxy);
			
			// register commands
			facade.registerCommand(NoteName.APP_STARTED, FinishApplicationStartupCommand);
			facade.registerCommand(NoteName.SETUP_GAME, SetupGameCommand);
			facade.registerCommand(NoteName.UPDATE_GAME_VIEW, UpdateGameViewCommand);
			facade.registerCommand(NoteName.UPDATE_LOGS, UpdateLogsCommand);
			facade.registerCommand(NoteName.SEND_CHAT, SendChatCommand);
			
			// register startup tasks
			startupProxy.registerTask(LoadAncientOnesCommand);
			startupProxy.registerTask(LoadCardsCommand);
			startupProxy.registerTask(LoadCharactersCommand);
			startupProxy.registerTask(LoadMonstersCommand);
			startupProxy.registerTask(LoadGameAtStartCommand);
		}
	}
}