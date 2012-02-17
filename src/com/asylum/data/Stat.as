package com.asylum.data
{
	public class Stat
	{
		private var _label:String;
		private var _index:int;
		private var _values:Array;
		
		public function Stat(label:String, values:Array)
		{
			_label = label;	
			_index = 0;
			_values = values;
		}

		public function get label():String
		{
			return _label;
		}
		
		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}
		
		public function get value():int
		{
			return _values[_index] as int;
		}
		
		public function get values():Array
		{
			return _values;
		}
	}
}