package editor.view.workarea
{
import editor.controller.signals.DrawRelationsSignal;
import editor.model.GameQuests;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DialogViewMediator extends Mediator
{
	[Inject]
	public var view:DialogView;

	[Inject]
	public var gameQuests:GameQuests;

	[Inject]
	public var drawRelationsSignal:DrawRelationsSignal;

	override public function initialize():void
	{
		super.initialize();
		view.selectDialog.add(selectDialog);
		view.drawRelations.add(drawRelations);
		view.updatePositionSignal.add(updatePosition);
		gameQuests.dialogSelected.add(dialogSelected);
	}

	private function drawRelations():void
	{
		drawRelationsSignal.dispatch();
	}

	private function updatePosition():void
	{
		gameQuests.updateDialogPosition(view.questDialog.id, view.x, view.y);
	}

	private function dialogSelected():void
	{
		view.dialogSelected(gameQuests.selectedDialogId);
	}

	private function selectDialog():void
	{
		gameQuests.setSelectedDialog(view.questDialog.id);
	}

	override public function destroy():void
	{
		view.selectDialog.remove(selectDialog);
		view.drawRelations.remove(drawRelations);
		gameQuests.dialogSelected.remove(dialogSelected);
		view.updatePositionSignal.remove(updatePosition);
		super.destroy();
	}
}
}
