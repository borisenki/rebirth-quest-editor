/**
 * Created by borisenki on 03.09.16.
 */
package editor.config
{
import editor.controller.Utils;
import editor.controller.commands.LoadQuestsCommand;
import editor.controller.commands.MacroSequenceCommand;
import editor.controller.commands.SaveQuestsCommand;
import editor.controller.signals.LoadQuestsSignal;
import editor.controller.signals.MacroSequenceSignal;
import editor.controller.signals.QuestsLoadedSignal;
import editor.controller.signals.SaveQuestSignal;
import editor.controller.signals.StatusPanelSignal;
import editor.model.DataModel;
import editor.model.GameQuests;
import editor.view.MainView;
import editor.view.MainViewMediator;
import editor.view.MenuPanel;
import editor.view.MenuPanelMediator;
import editor.view.StatusPanel;
import editor.view.StatusPanelMediator;
import editor.view.panels.CommandPanel;
import editor.view.panels.CommandPanelMediator;
import editor.view.panels.DialogCommandsPanel;
import editor.view.panels.DialogCommandsPanelMediator;
import editor.view.panels.DialogInfoPanel;
import editor.view.panels.DialogInfoPanelMediator;
import editor.view.panels.PropertiesPanel;
import editor.view.panels.PropertiesPanelMediator;
import editor.view.panels.QuestCommandsPanel;
import editor.view.panels.QuestCommandsPanelMediator;
import editor.view.panels.QuestInfoPanel;
import editor.view.panels.QuestInfoPanelMediator;
import editor.view.windows.CreateQuestWindow;
import editor.view.windows.CreateQuestWindowMediator;
import editor.view.windows.EditorSettings;
import editor.view.windows.EditorSettingsMediator;
import editor.view.windows.QuestSettings;
import editor.view.windows.QuestSettingsMediator;
import editor.view.workarea.DialogView;
import editor.view.workarea.DialogViewMediator;
import editor.view.workarea.WorkPlane;
import editor.view.workarea.WorkPlaneMediator;

import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

public class EditorConfig implements IConfig
{
	[Inject]
	public var injector:IInjector;

	[Inject]
	public var mediatorMap:IMediatorMap;

	[Inject]
	public var commandMap:ISignalCommandMap;

	[Inject]
	public var contextView:ContextView;

	public function configure():void
	{
		injector.map(StatusPanelSignal).asSingleton();
		injector.map(QuestsLoadedSignal).asSingleton();
		//commandMap.map(StatusPanelSignal);

		injector.map(DataModel).asSingleton();
		injector.map(GameQuests).asSingleton();
		injector.map(Utils).asSingleton();

		commandMap.map(MacroSequenceSignal).toCommand(MacroSequenceCommand);
		commandMap.map(LoadQuestsSignal).toCommand(LoadQuestsCommand);
		commandMap.map(SaveQuestSignal).toCommand(SaveQuestsCommand);

		//windows
		mediatorMap.map(CreateQuestWindow).toMediator(CreateQuestWindowMediator);
		mediatorMap.map(QuestSettings).toMediator(QuestSettingsMediator);
		mediatorMap.map(EditorSettings).toMediator(EditorSettingsMediator);
		//panels
		mediatorMap.map(StatusPanel).toMediator(StatusPanelMediator);
		mediatorMap.map(MenuPanel).toMediator(MenuPanelMediator);

		mediatorMap.map(PropertiesPanel).toMediator(PropertiesPanelMediator);
		mediatorMap.map(QuestInfoPanel).toMediator(QuestInfoPanelMediator);
		mediatorMap.map(DialogInfoPanel).toMediator(DialogInfoPanelMediator);

		mediatorMap.map(CommandPanel).toMediator(CommandPanelMediator);
		mediatorMap.map(QuestCommandsPanel).toMediator(QuestCommandsPanelMediator);
		mediatorMap.map(DialogCommandsPanel).toMediator(DialogCommandsPanelMediator);
		//workarea
		mediatorMap.map(WorkPlane).toMediator(WorkPlaneMediator);
		mediatorMap.map(DialogView).toMediator(DialogViewMediator);
		//
		mediatorMap.map(MainView).toMediator(MainViewMediator);
	}
}
}
