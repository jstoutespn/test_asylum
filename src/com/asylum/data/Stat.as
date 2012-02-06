package com.asylum.data
{
	public class Stat
	{
		private var _index:int;
		private var _values:Array;
		
		public function Stat(values:Array)
		{
			_index = 0;
			_values = values;
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
	}
}