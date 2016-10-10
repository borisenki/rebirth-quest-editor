package editor.view.panels.commands
{
import editor.model.GameQuests;

import robotlegs.bender.bundles.mvcs.Mediator;

public class AnswerCommandsPanelMediator extends Mediator
{
	[Inject]
	public var view:AnswerCommandsPanel;

	[Inject]
	public var gameQuests:GameQuests;

	override public function initialize():void
	{
		super.initialize();
		view.deleteAnswerSignal.add(deleteAnswer);
	}

	private function deleteAnswer():void
	{
		gameQuests.deleteSelectedAnswer();
	}

	override public function destroy():void
	{
		super.destroy();
		gameQuests.dataUpdate.remove(deleteAnswer);
	}
}
}
