package editor.view.panels.properties
{
import editor.model.DataModel;
import editor.model.GameQuests;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PropertiesPanelMediator extends Mediator
{
	[Inject]
	public var view:PropertiesPanel;

	[Inject]
	public var dataModel:DataModel;

	[Inject]
	public var gameQuests:GameQuests;

	override public function initialize():void
	{
		super.initialize(); 
		gameQuests.questSelected.add(onQuestSelected);
		gameQuests.dialogSelected.add(onDialogSelected);
		gameQuests.answerSelected.add(onAnswerSelected);
	}

	private function onAnswerSelected():void
	{
		if (gameQuests.selectedAnswerId != -1)
		{
			view.fillPanel(PropertiesPanel.DIALOG_INFO_PANEL | PropertiesPanel.ANSWER_PROPERTIES_PANEL);
		}
	}

	private function onDialogSelected():void
	{
		if (gameQuests.selectedDialogId != -1)
		{
			view.fillPanel(PropertiesPanel.QUEST_INFO_PANEL | PropertiesPanel.DIALOG_INFO_PANEL);
		}
		else
		{
			view.fillPanel(PropertiesPanel.QUEST_INFO_PANEL);
		}
	}

	private function onQuestSelected():void
	{
		view.setEnable(true);
		view.fillPanel(PropertiesPanel.QUEST_INFO_PANEL);
	}

	override public function destroy():void
	{
		super.destroy();
		gameQuests.questSelected.remove(onQuestSelected);
		gameQuests.dialogSelected.remove(onDialogSelected);
		gameQuests.answerSelected.remove(onAnswerSelected);
	}
}
}
