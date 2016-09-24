package editor.view.panels.properties
{
import editor.controller.signals.StatusPanelSignal;
import editor.model.GameQuests;
import editor.model.vo.DialogAnswerVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class AnswerPropertiesPanelMediator extends Mediator
{
	[Inject]
	public var view:AnswerPropertiesPanel;

	[Inject]
	public var statusPanelSignal:StatusPanelSignal;

	[Inject]
	public var gameQuests:GameQuests;

	private var _selectedAnswer:DialogAnswerVO;

	override public function initialize():void
	{
		super.initialize();
		view.saveAnswerSignal.add(saveAnswer);
		init();
	}

	private function init():void
	{
		_selectedAnswer = gameQuests.getSelectedAnswer();
		view.setInfo(_selectedAnswer);
	}

	private function saveAnswer():void
	{
		_selectedAnswer.text = view.getAnswerText();
		gameQuests.updateAnswerData(_selectedAnswer);
	}

	override public function destroy():void
	{
		super.destroy();
		view.saveAnswerSignal.remove(saveAnswer);
	}
}
}
