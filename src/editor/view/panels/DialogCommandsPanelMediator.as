/**
 * Created by borisenki on 22.09.16.
 */
package editor.view.panels
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
		view.createDialogAnswer.add(createDialogAnswer);
	}

	private function createDialogAnswer():void
	{
		gameQuests.createAnswer(gameQuests.selectedQuestId, gameQuests.selectedDialogId);
		statusPanelSignal.dispatch("Создан вариант ответа");
	}

	override public function destroy():void
	{
		super.destroy();
		view.createDialogAnswer.remove(createDialogAnswer);
	}
}
}
