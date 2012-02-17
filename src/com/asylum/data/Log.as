package com.asylum.data
{
	public class Log
	{
		public var id:String;
		public var time:Date;
		public var player:Player;
		public var text:String;
		public var isChat:Boolean;
		public var isRendered:Boolean;
		
		public function Log()
		{
			time = new Date();
			isChat = false;
			isRendered = false;
		}
	}
}