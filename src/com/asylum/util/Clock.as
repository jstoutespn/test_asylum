package com.asylum.util
{
	public class Clock
	{
		public static function getTime():Number {
			var date:Date = new Date();
			return date.getTime();
		}
	}
}