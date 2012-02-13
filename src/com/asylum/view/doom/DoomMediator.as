package com.asylum.view.doom
{
	import com.asylum.data.enum.NoteName;
	import com.asylum.events.NoteEvent;
	import com.asylum.mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class DoomMediator extends BaseMediator
	{
		public static const NAME:String = "doomMediator";
		
		public function DoomMediator(viewComponent:DoomTrack)
		{
			super(NAME, viewComponent);
			addInterest(NoteName.UPDATE_DOOM_LEVEL, onUpdate);
			view.addEventListener(NoteEvent.NOTIFICATION, onNoteRelay, false, 0, true);
		}
		
		private function onNoteRelay(event:NoteEvent):void
		{
			sendNotification(event.name, event.message);
		}
		
		private function onUpdate(note:INotification):void {
			var msg:Object = note.getBody();
			var level:int = msg.doom as int;
			view.value = level;
			if ( msg.hasOwnProperty('max') ) {
				var max:int = msg.max as int;
				view.max = max;
			}
		}
		
		private function get view():DoomTrack {
			return viewComponent as DoomTrack;
		}
	}
}