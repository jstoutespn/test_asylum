package com.asylum.view.terror
{
	import com.asylum.data.enum.NoteName;
	import com.asylum.events.NoteEvent;
	import com.asylum.mediator.BaseMediator;
	
	import org.puremvc.as3.interfaces.INotification;
	
	public class TerrorMediator extends BaseMediator
	{
		public static const NAME:String = "terrorMediator";
		
		public function TerrorMediator(viewComponent:TerrorTrack)
		{
			super(NAME, viewComponent);
			addInterest(NoteName.UPDATE_TERROR_LEVEL, onUpdateLevel);
			view.addEventListener(NoteEvent.NOTIFICATION, onNoteRelay, false, 0, true);
		}
		
		private function onNoteRelay(event:NoteEvent):void
		{
			sendNotification(event.name, event.message);
		}
		
		private function onUpdateLevel(note:INotification):void {
			var terror:int = note.getBody().level as int;
			view.level = terror;
		}
		
		private function get view():TerrorTrack {
			return viewComponent as TerrorTrack;
		}
	}
}