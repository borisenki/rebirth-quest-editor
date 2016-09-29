/**
 * Created by borisenki on 10.09.16.
 */
package editor.view.workarea
{
import editor.controller.signals.CreateRelationSignal;
import editor.controller.signals.DrawRelationsSignal;
import editor.model.DataModel;
import editor.model.GameQuests;
import editor.model.vo.DialogAnswerVO;
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

	[Inject]
	public var createRelationSignal:CreateRelationSignal;

	[Inject]
	public var drawRelationsSignal:DrawRelationsSignal;

	private var selectedQuest:GameQuestVO;

	override public function initialize():void
	{
		super.initialize();
		gameQuests.questSelected.add(setQuestOnPanel);
		gameQuests.dataUpdate.add(dataUpdated);
		createRelationSignal.add(createRelation);
		drawRelationsSignal.add(drawRelations);
	}

	private function drawRelations():void
	{
		view.drawRelation();
	}

	private function createRelation(answer:AnswerView):void
	{
		view.createRelation(answer);
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
		gameQuests.questSelected.remove(setQuestOnPanel);
		gameQuests.dataUpdate.remove(dataUpdated);
		createRelationSignal.remove(createRelation);
		drawRelationsSignal.remove(drawRelations);
	}
}
}
