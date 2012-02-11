package com.asylum.factory
{
	import com.asylum.data.Config;
	import com.asylum.data.Gate;
	import com.asylum.data.GateInstance;
	import com.asylum.data.Item;
	import com.asylum.data.ItemInstance;
	import com.asylum.data.Skill;
	import com.asylum.data.SkillInstance;
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
		
		public static function getGateTokenId(gateId:int, gateNum:int):String {
			return new String("gate_" + Config.i.gameId + "_" + gateId + "_" + gateNum);
		}
		
		public static function getItemCardId(itemId:int, itemNum:int):String {
			return new String("item_" + Config.i.gameId + "_" + itemId + "_" + itemNum);
		}
		
		public static function getSkillCardId(skillId:int, skillNum:int):String {
			return new String("skill_" + Config.i.gameId + "_" + skillId + "_" + skillNum);
		}
		
		public static function getGateTokenXML(gate:GateInstance):XML {
			var xml:XML = new XML("<gate></gate>");
			xml.@id = gate.id;
			xml.@source = gate.source.id;
			if (gate.isTrophy) {
				xml.@trophy = "true";
				xml.@owner = gate.claimant.id;
			} else {
				xml.@trophy = "false";
				if (gate.location) {
					xml.@location = gate.location.mapId;
				} else {
					xml.@location = "cup";
				}
			}
			return xml;
		}
		
		public static function getItemCardXML(item:ItemInstance):XML {
			var xml:XML = new XML("<item></item>");
			xml.@id = item.id;
			xml.@source = item.source.id;
			if (item.isInPlay) {
				xml.@inplay = "true";
				xml.@owner = item.owner.id;
			} else {
				xml.@inplay = "false";
			}
			return xml;
		}
		
		public static function getSkillCardXML(skill:SkillInstance):XML {
			var xml:XML = new XML("<skill></skill>");
			xml.@id = skill.id;
			xml.@source = skill.source.id;
			if (skill.isInPlay) {
				xml.@inplay = "true";
				xml.@owner = skill.owner.id;
			} else {
				xml.@inplay = "false";
			}
			return xml;
		}
	}
}