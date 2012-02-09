package com.asylum.control
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	public class StartApplicationCommand extends MacroCommand
	{
		public function StartApplicationCommand()
		{
			super();
		}
		
		override protected function initializeMacroCommand():void
		{
			addSubCommand(SetupApplicationCommand);
			addSubCommand(LoadAncientOnesCommand);
			addSubCommand(LoadCardsCommand);
			addSubCommand(LoadCharactersCommand);
			addSubCommand(LoadMonstersCommand);
			addSubCommand(LoadGameAtStartCommand);
		}
	}
}