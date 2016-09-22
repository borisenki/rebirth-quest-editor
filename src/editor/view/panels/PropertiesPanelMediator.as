/**
 * Created by borisenki on 07.09.16.
 */
package editor.view.panels
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
	}

	private function onDialogSelected():void
	{
		view.fillPanel(PropertiesPanel.QUEST_INFO_PANEL | PropertiesPanel.DIALOG_INFO_PANEL);
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
	}
}
}
