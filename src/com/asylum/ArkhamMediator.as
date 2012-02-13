package com.asylum
{
	import com.asylum.data.enum.ApplicationScreen;
	import com.asylum.data.enum.NoteName;
	import com.asylum.mediator.BaseMediator;
	import com.asylum.view.ancient.AncientMediator;
	import com.asylum.view.doom.DoomMediator;
	import com.asylum.view.map.MapMediator;
	import com.asylum.view.playlist.PlayListMediator;
	import com.asylum.view.terror.TerrorMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class ArkhamMediator extends BaseMediator
	{
		public static const NAME:String = "mainMediator";
		
		public function ArkhamMediator(viewComponent:Arkham)
		{
			super(NAME, viewComponent);
			addInterest(NoteName.SET_SCREEN, onSetScreen);
			addInterest(NoteName.SET_LOADING_TEXT, onSetLoadText);
		}
		
		public function get view():Arkham {
			return viewComponent as Arkham;
		}
		
		override public function onRegister():void
		{
			facade.registerMediator(new AncientMediator(view.ancientScreen));
			facade.registerMediator(new MapMediator(view.gameMap));
			facade.registerMediator(new TerrorMediator(view.terrorTrack));
			facade.registerMediator(new DoomMediator(view.doomTrack));
			facade.registerMediator(new PlayListMediator(view.playList));
		}
		
		private function onSetScreen(note:INotification):void {
			var screen:String = note.getBody().screen;
			switch (screen) {
				case ApplicationScreen.LOADING:
					view.currentState = ApplicationScreen.LOADING;
					if (note.getBody().hasOwnProperty("message")) {
						view.loadLabel.text = note.getBody().message as String;
					}
					break;
				case ApplicationScreen.BOSS_SELECT:
					view.currentState = ApplicationScreen.BOSS_SELECT;
					break;
				case ApplicationScreen.PLAYING:
					view.currentState = ApplicationScreen.PLAYING;
					break;
			}
		}
		
		private function onSetLoadText(note:INotification):void {
			if (view && view.currentState == "loading") {
				view.loadLabel.text = note.getBody() as String;
			}
		}
	}
}