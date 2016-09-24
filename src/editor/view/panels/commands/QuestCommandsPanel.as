/**
 * Created by borisenki on 17.09.16.
 */
package editor.view.panels.commands
{
import com.bit101.components.PushButton;
import com.bit101.utils.MinimalConfigurator;

import flash.display.Sprite;
import flash.events.Event;

import org.osflash.signals.Signal;

public class QuestCommandsPanel extends Sprite
{
	[Embed(source="../../../../../assets/editor/panels/command/quest_commands_view.xml", mimeType="application/octet-stream")]
	private var quest_info_Class:Class;

	private var config:MinimalConfigurator;
	private var createDialog:PushButton;
	private var _createQuestDialog:Signal; 
	private var _questId:int;

	public function QuestCommandsPanel()
	{
		_createQuestDialog = new Signal();
		initComponents();
	}

	private function initComponents():void
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new quest_info_Class()));
		createDialog = config.getCompById("createDialog") as PushButton;
	}

	public function createNewDialog(e:Event):void
	{
		_createQuestDialog.dispatch();
	}

	public function get createQuestDialog():Signal
	{
		return _createQuestDialog;
	}

	public function set questId(value:int):void
	{
		_questId = value;
	}

	public function get questId():int
	{
		return _questId;
	}
}
}
