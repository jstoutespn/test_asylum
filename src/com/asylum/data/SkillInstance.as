package com.asylum.data
{
	public class SkillInstance
	{
		public var id:String;
		public var source:Skill;
		public var isInPlay:Boolean;
		public var owner:Player;
		
		public function SkillInstance(skill:Skill = null)
		{
			source = skill;
			isInPlay = false;
		}
	}
}