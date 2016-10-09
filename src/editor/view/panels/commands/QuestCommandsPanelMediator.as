package editor.view.panels.commands
{
import editor.controller.signals.StatusPanelSignal;
import editor.model.DataModel;
import editor.model.DataTypes;
import editor.model.GameQuests;
import editor.model.vo.GameQuestVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class QuestCommandsPanelMediator extends Mediator
{
	[Inject]
	public var dataModel:DataModel;

	[Inject]
	public var gameQuests:GameQuests;

	[Inject]
	public var view:QuestCommandsPanel;

	[Inject]
	public var statusPanelSignal:StatusPanelSignal;

	override public function initialize():void
	{
		super.initialize();
		view.createQuestDialog.add(createNewDialog);
	}

	private function createNewDialog():void
	{
		var questId:int = view.questId;
		gameQuests.createDialog(questId);
		statusPanelSignal.dispatch("Новый диалог создан")
	}

	override public function destroy():void
	{
		super.destroy();
		view.createQuestDialog.remove(createNewDialog);
	}
}
}
