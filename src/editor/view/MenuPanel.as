/**
 * Created by borisenki on 06.09.16.
 */
package editor.view
{
import com.bit101.components.ComboBox;
import com.bit101.components.PushButton;
import com.bit101.utils.MinimalConfigurator;

import editor.model.GameQuests;
import editor.model.vo.GameQuestVO;
import editor.view.windows.CreateQuestWindow;
import editor.view.windows.EditorSettings;
import editor.view.windows.QuestSettings;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class MenuPanel extends Sprite
{
	[Embed(source="../../../assets/editor/panels/menu_panel.xml", mimeType="application/octet-stream")]
	private var menu_panel_Class:Class;

	private var config:MinimalConfigurator;

	private var _loadQuests:PushButton;
	private var _newQuest:PushButton;
	private var _settings:PushButton;
	private var _save:PushButton;
	private var _questsList:ComboBox;

	private var _clickLoadQuests:Signal;
	private var _questSelected:Signal;
	private var _clickSave:Signal;

	public function MenuPanel()
	{
		_clickLoadQuests = new Signal();
		_clickSave = new Signal();
		_questSelected = new Signal(int);
		init();
		super();
	}

	public function init():void
	{
		config = new MinimalConfigurator(this);
		config.parseXML(XML(new menu_panel_Class()));
		//
		_loadQuests = config.getCompById("loadQuest") as PushButton;
		_newQuest = config.getCompById("newQuest") as PushButton;
		_settings = config.getCompById("settings") as PushButton;
		_save = config.getCompById("save") as PushButton;
		_loadQuests.addEventListener(MouseEvent.CLICK, onClickLoadQuests);
		_questsList = config.getCompById("questsList") as ComboBox;
		_questsList.addEventListener(Event.SELECT, onQuestSelect);
	}

	private function onQuestSelect(e:Event):void
	{
		_questSelected.dispatch(_questsList.selectedItem.id);
	}

	private function onClickLoadQuests(e:MouseEvent):void
	{
		_clickLoadQuests.dispatch();
	}

	public function questsLoaded(quests:GameQuests):void
	{
		trace("Quests count -", quests.quests.length);
		_questsList.removeAll();
		for each (var quest:GameQuestVO in quests.quests)
		{
			_questsList.addItem(quest);
		}
		_questsList.enabled = true;
		_newQuest.enabled = true;
		_settings.enabled = true;
		_save.enabled = true;
	}

	public function showSettings(event:Event):void
	{
		var window:EditorSettings = new EditorSettings(null, 500, 50);
		addChild(window);
	}

	public function saveClick(event:Event):void
	{
		_clickSave.dispatch();
	}

	public function showQuestSettings(event:MouseEvent):void
	{
		var window:QuestSettings = new QuestSettings(null, 10, 10);
		addChild(window);
	}

	public function showNewQuest(event:MouseEvent):void
	{
		var window:CreateQuestWindow = new CreateQuestWindow(null, 100, 100);
		addChild(window)
	}

	public function get clickLoadQuests():Signal
	{
		return _clickLoadQuests;
	}

	public function get clickSave():Signal
	{
		return _clickSave;
	}

	public function get questSelected():Signal
	{
		return _questSelected;
	}
}
}
