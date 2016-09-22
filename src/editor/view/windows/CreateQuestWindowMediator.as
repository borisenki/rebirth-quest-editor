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

public class CreateQuestWindowMediator extends Mediator
{
	[Inject]
	public var view:CreateQuestWindow;

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
		view.createQuest.add(createQuest);
		init();
	}

	private function createQuest():void
	{
		if (view.getQuestType() != null)
		{
			trace("Quest Id -", view.questId);
			trace("Quest Label -", view.getQuestLabel());
			var gameQuest:GameQuestVO = new GameQuestVO();
			gameQuest.id = view.questId;
			gameQuest.label = view.getQuestLabel();
			gameQuest.type = view.getQuestType().id;
			gameQuests.addQuest(gameQuest);
			statusPanelSignal.dispatch("Новый квест создан");
			view.clickClose();
		}
		else
		{
			statusPanelSignal.dispatch("Не выбран тип квеста");
		}
	}

	private function init():void
	{
		statusPanelSignal.dispatch("Создание нового квеста");
		var gameTypes:GameTypesVO = dataModel.getData(DataTypes.GAME_TYPES) as GameTypesVO;
		var questTypes:Object = gameTypes.quests;
		view.fillTypesList(questTypes);
		view.setQuestId(utils.generateQuestID());
	}

	override public function destroy():void
	{
		view.createQuest.remove(createQuest);
		super.destroy();
	}
}
}
