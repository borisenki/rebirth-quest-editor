/**
 * Created by borisenki on 24.09.16.
 */
package editor.view.workarea
{
import editor.controller.signals.CreateRelationSignal;
import editor.model.GameQuests;

import robotlegs.bender.bundles.mvcs.Mediator;

public class AnswerViewMediator extends Mediator
{
	[Inject]
	public var view:AnswerView;

	[Inject]
	public var gameQuests:GameQuests

	[Inject]
	public var createRelationSignal:CreateRelationSignal;

	override public function initialize():void
	{
		super.initialize();
		view.answerSelectedSignal.add(answerSelected);
		view.createRelationSignal.add(createRelation);
	}

	private function createRelation():void
	{
		createRelationSignal.dispatch(view);
	}

	private function answerSelected():void
	{
		gameQuests.setSelectedDialog(view.dialogId, false);
		gameQuests.setSelectedAnswer(view.answerData.id);
	}

	override public function destroy():void
	{
		super.destroy();
		view.answerSelectedSignal.remove(answerSelected);
		view.createRelationSignal.remove(createRelation);
	}
}
}
