/**
 * Created by borisenki on 17.09.16.
 */
package editor.view.panels.properties
{
import editor.model.GameQuests;
import editor.model.vo.QuestDialogVO;

import robotlegs.bender.bundles.mvcs.Mediator;

public class DialogInfoPanelMediator extends Mediator
{
	[Inject]
	public var view:DialogInfoPanel;

	[Inject]
	public var gameQuest:GameQuests;

	private var _selectedDialog:QuestDialogVO;

	override public function initialize():void
	{
		super.initialize();
		view.saveDialogSignal.add(saveDialog);
		gameQuest.dataUpdate.add(dataUpdate);
		init();
	}

	private function dataUpdate():void
	{
		if (gameQuest.selectedDialogId != -1)
		{
			_selectedDialog = gameQuest.getSelectedDialog();
			view.setInfo(_selectedDialog);
		}
	}

	private function saveDialog():void
	{
		_selectedDialog.text = view.getText();
		gameQuest.updateDialogData(_selectedDialog);
	}

	private function init():void
	{
		_selectedDialog = gameQuest.getSelectedDialog();
		view.setInfo(_selectedDialog); 
	}

	override public function destroy():void
	{
		super.destroy();
		view.saveDialogSignal.remove(saveDialog);
		gameQuest.dataUpdate.remove(dataUpdate);
	}
}
}
