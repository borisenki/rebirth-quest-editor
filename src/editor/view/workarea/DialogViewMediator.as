/**
 * Created by borisenki on 15.09.16.
 */
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
		gameQuests.dialogSelected.add(dialogSelected);
	}

	private function drawRelations():void
	{
		drawRelationsSignal.dispatch();
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
		super.destroy();
	}
}
}
