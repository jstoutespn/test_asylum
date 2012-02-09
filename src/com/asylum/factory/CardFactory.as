package com.asylum.factory
{
	import com.asylum.data.Gate;
	import com.asylum.data.Item;
	import com.asylum.data.Skill;
	import com.asylum.data.Spell;

	public class CardFactory
	{
		public static function makeGate(xml:XML):Gate {
			var gate:Gate = new Gate();
			gate.id = parseFloat(xml.@id) as int;
			gate.world = xml.@world;
			gate.symbol = xml.@symbol;
			gate.modifier = parseFloat(xml.@modifier) as int;
			gate.num = parseFloat(xml.@num) as int;
			return gate;
		}
		
		public static function makeItem(xml:XML):Item {
			var item:Item = new Item();
			item.id = parseFloat(xml.@id);
			item.type = xml.@type;
			item.num = parseFloat(xml.@num) as int;
			item.name = xml..name;
			if (xml.child("subtype").length() > 0) {
				item.subType = xml..subtype;
			}
			if (xml.child("hands").length() > 0) {
				item.hands = parseFloat(xml..hands) as int;
			}
			if (xml.child("price").length() > 0) {
				item.price = parseFloat(xml..price) as int;
			}
			item.text = xml..text;
			return item;
		}
		
		public static function makeSpell(xml:XML):Spell {
			var spell:Spell = new Spell();
			spell.id = parseFloat(xml.@id);
			spell.type = xml.@type;
			spell.num = parseFloat(xml.@num) as int;
			spell.name = xml..name;
			if (xml.child("subtype").length() > 0) {
				spell.subType = xml..subtype;
			}
			if (xml.child("hands").length() > 0) {
				spell.hands = parseFloat(xml..hands) as int;
			}
			if (xml.child("price").length() > 0) {
				spell.price = parseFloat(xml..price) as int;
			}
			spell.text = xml..text;
			spell.castmod = parseFloat(xml.@modifier) as int;
			spell.sancost = parseFloat(xml.@cost) as int;
			return spell;
		}
		
		public static function makeSkill(xml:XML):Skill {
			var skill:Skill = new Skill();
			skill.id = parseFloat(xml.@id) as int;
			skill.num = parseFloat(xml.@num) as int;
			skill.name = xml..name;
			skill.text = xml..text;
			return skill;
		}
	}
}