package editor.view.panels.commands
{
import editor.controller.signals.StatusPanelSignal;
import editor.model.GameQuests;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DialogCommandsPanelMediator extends Mediator
{
	[Inject]
	public var view:DialogCommandsPanel;

	[Inject]
	public var statusPanelSignal:StatusPanelSignal;

	[Inject]
	public var gameQuests:GameQuests;

	override public function initialize():void
	{
		super.initialize();
		view.createDialogAnswerSignal.add(createDialogAnswer);
		view.deleteDialogSignal.add(deleteDialog);
	}

	private function deleteDialog():void
	{
		gameQuests.deleteSelectedDialog();
		statusPanelSignal.dispatch("Диалог удалён");
	}

	private function createDialogAnswer():void
	{
		gameQuests.createAnswer(gameQuests.selectedQuestId, gameQuests.selectedDialogId);
		statusPanelSignal.dispatch("Создан вариант ответа");
	}

	override public function destroy():void
	{
		super.destroy();
		view.createDialogAnswerSignal.remove(createDialogAnswer);
		view.deleteDialogSignal.remove(deleteDialog);
	}
}
}
