/**
 * Created by borisenki on 10.09.16.
 */
package editor.view.windows
{
import editor.controller.Utils;
import editor.controller.signals.StatusPanelSignal;
import editor.model.DataModel;
import editor.model.DataTypes;
import editor.model.GameQuests;
import editor.model.vo.GameQuestVO;
import editor.model.vo.GameTypesVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class QuestSettingsMediator extends Mediator
{
	[Inject]
	public var view:QuestSettings;

	[Inject]
	public var dataModel:DataModel;

	[Inject]
	public var gameQuests:GameQuests;

	[Inject]
	public var utils:Utils;

	[Inject]
	public var statusPanelSignal:StatusPanelSignal;

	override public function initialize():void
	{
		super.initialize();
		view.editQuest.add(editQuest);
		init();
	}

	private function editQuest():void
	{
		//
	}

	private function init():void
	{
		var gameTypes:GameTypesVO = dataModel.getData(DataTypes.GAME_TYPES) as GameTypesVO;
		var questTypes:Object = gameTypes.quests;
		view.fillTypesList(questTypes);
		view.setQuestId(utils.generateQuestID());
	}

	override public function destroy():void
	{
		view.editQuest.remove(editQuest);
		super.destroy();
	}
}
}
