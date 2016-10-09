/**
 * Created by borisenki on 07.09.16.
 */
package editor.view.panels.commands
{
import editor.model.GameQuests;

import robotlegs.bender.bundles.mvcs.Mediator;

public class CommandPanelMediator extends Mediator
{
	[Inject]
	public var view:CommandPanel;

	[Inject]
	public var gameQuests:GameQuests;

	override public function initialize():void
	{
		super.initialize();
		gameQuests.questSelected.add(questSelected);
		gameQuests.dialogSelected.add(dialogSelected);
	}

	private function dialogSelected():void
	{
		if (gameQuests.selectedDialogId != -1)
		{
			view.dialogId = gameQuests.selectedDialogId;
			view.fillPanel(CommandPanel.QUEST_COMMANDS | CommandPanel.CREATE_DIALOG);
		}
		else
		{
			questSelected();
		}
	}

	private function questSelected():void
	{
		view.setEnable(true);
		view.questId = gameQuests.selectedQuestId;
		view.fillPanel(CommandPanel.QUEST_COMMANDS);
	}

	override public function destroy():void
	{
		super.destroy();
		gameQuests.questSelected.remove(questSelected);
		gameQuests.dialogSelected.remove(dialogSelected);
	}
}
}
