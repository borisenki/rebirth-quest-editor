/**
 * Created by borisenki on 15.09.16.
 */
package editor.view.workarea
{
import editor.model.GameQuests;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DialogViewMediator extends Mediator
{
	[Inject]
	public var view:DialogView;

	[Inject]
	public var gameQuests:GameQuests;

	override public function initialize():void
	{
		super.initialize();
		view.selectDialog.add(selectDialog);
		gameQuests.dialogSelected.add(dialogSelected);
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
		gameQuests.dialogSelected.remove(dialogSelected);
		super.destroy();
	}
}
}
