package com.asylum.events
{
	import flash.events.Event;
	
	public class NoteEvent extends Event
	{
		public static const NOTIFICATION:String = "notification";
		
		private var _name:String;
		private var _message:Object;
		
		public function NoteEvent(name:String, message:Object = null)
		{
			_name = name;
			_message = message;
			super(NOTIFICATION, false, false);
		}

		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}

		public function get message():Object
		{
			return _message;
		}

		public function set message(value:Object):void
		{
			_message = value;
		}
	}
}