/**
 * Created by borisenki on 06.09.16.
 */
package editor.view
{
import editor.controller.signals.LoadQuestsSignal;
import editor.controller.signals.QuestsLoadedSignal;
import editor.controller.signals.SaveQuestSignal;
import editor.model.DataModel;
import editor.model.GameQuests;
import editor.model.vo.DataVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class MenuPanelMediator extends Mediator
{
	[Inject]
	public var view:MenuPanel;

	[Inject]
	public var dataModel:DataModel;

	[Inject]
	public var loadQuestsSignal:LoadQuestsSignal;

	[Inject]
	public var questsLoadedSignal:QuestsLoadedSignal;

	[Inject]
	public var saveQuestsSignal:SaveQuestSignal;

	[Inject]
	public var gameQuests:GameQuests;

	override public function initialize():void
	{
		super.initialize();
		view.clickLoadQuests.add(startLoadQuests);
		view.clickSave.add(saveQuests);
		view.questSelected.add(questSelected);
		gameQuests.dataUpdate.add(updateQuests);
	}

	private function questSelected(questId:int):void
	{
		gameQuests.setSelectedQuest(questId);
	}

	private function saveQuests():void
	{
		saveQuestsSignal.dispatch();
	}

	private function updateQuests():void
	{
		view.questsLoaded(gameQuests);
	}

	private function startLoadQuests():void
	{
		loadQuestsSignal.dispatch();
	}

	override public function destroy():void
	{
		view.clickLoadQuests.remove(startLoadQuests);
		view.clickSave.remove(saveQuests);
		view.questSelected.remove(questSelected);
		dataModel.dataUpdate.remove(updateQuests);
		super.destroy();
	}
}
}
