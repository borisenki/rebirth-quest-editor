/**
 * Created by borisenki on 10.09.16.
 */
package editor.view.workarea
{
import editor.model.DataModel;
import editor.model.GameQuests;
import editor.model.vo.GameQuestVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class WorkPlaneMediator extends Mediator
{
	[Inject]
	public var view:WorkPlane;

	[Inject]
	public var dataModel:DataModel;

	[Inject]
	public var gameQuests:GameQuests;

	private var selectedQuest:GameQuestVO;

	override public function initialize():void
	{
		super.initialize();
		gameQuests.questSelected.add(setQuestOnPanel);
		gameQuests.dataUpdate.add(dataUpdated);
	}

	private function dataUpdated():void
	{
		if (selectedQuest != null)
		{
			selectedQuest = gameQuests.getQuestById(selectedQuest.id);
			view.questSelected(selectedQuest);
		}
	}

	private function setQuestOnPanel():void
	{
		selectedQuest = gameQuests.getSelectedQuest();
		view.questSelected(selectedQuest);
	}

	override public function destroy():void
	{
		view.destroy();
		super.destroy();
	}
}
}
