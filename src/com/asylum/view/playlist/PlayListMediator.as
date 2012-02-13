package com.asylum.view.playlist
{
	import com.asylum.data.Player;
	import com.asylum.data.enum.NoteName;
	import com.asylum.mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class PlayListMediator extends BaseMediator
	{
		public static const NAME:String = "playListMediator";
		
		public function PlayListMediator(viewComponent:PlayList)
		{
			super(NAME, viewComponent);
			addInterest(NoteName.UPDATE_PLAY_LIST, onUpdate);
			addInterest(NoteName.UPDATE_GAME_STATUS, onUpdateGameStatus);
		}
		
		private function onUpdate(note:INotification):void {
			var players:Vector.<Player> = note.getBody().players;
			view.dataProvider.removeAll();
			for each (var player:Player in players) {
				view.dataProvider.addItem(player);
			}
			view.dataProvider.refresh();
		}
		
		private function onUpdateGameStatus(note:INotification):void {
			var status:String = note.getBody() as String;
			view.currentPhase = status;
		}
		
		private function get view():PlayList {
			return viewComponent as PlayList;
		}
	}
}