/**
 * Created by borisenki on 10.09.16.
 */
package editor.controller
{
import editor.model.DataModel;
import editor.model.GameQuests;
import editor.model.vo.GameQuestVO;

public class Utils
{
	[Inject]
	public var dataModel:DataModel;

	[Inject]
	public var gameQuests:GameQuests;

	public function generateQuestID():int
	{
		var maxQuestID:int = 0;
		for each (var quest:GameQuestVO in gameQuests.quests)
		{
			if (maxQuestID < quest.id)
			{
				maxQuestID = quest.id;
			}
		}
		maxQuestID += 1;
		return maxQuestID;
	}
}
}
