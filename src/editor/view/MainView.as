/**
 * Created by borisenki on 03.09.16.
 */
package editor.view
{
import com.bit101.utils.MinimalConfigurator;

import editor.Settings;
import editor.view.panels.commands.CommandPanel;
import editor.view.panels.properties.PropertiesPanel;
import editor.view.windows.QuestSettings;
import editor.view.workarea.WorkPlane;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class MainView extends Sprite
{
	private var _menuPanel:MenuPanel;
	private var _statusPanel:StatusPanel;
	private var _properiesPanel:PropertiesPanel;
	private var _commandPanel:CommandPanel;
	private var _workPlane:WorkPlane;

	public function MainView()
	{
		super();
		initWorkPlane();
		initPropertiesPanel();
		initCommandPanel();
		initMenuPanel();
		initStatusPanel();
	}

	private function initWorkPlane():void
	{
		_workPlane = new WorkPlane();
		_workPlane.x = (Settings.SCREEN_WIDTH - _workPlane.width) * 0.5;
		_workPlane.y = (Settings.SCREEN_HEIGHT - _workPlane.height) * 0.5;
		addChild(_workPlane);
	}

	private function initCommandPanel():void
	{
		_commandPanel = new CommandPanel();
		_commandPanel.x = Settings.SCREEN_WIDTH - Settings.COMMAND_PANEL_WIDTH;
		_commandPanel.y = 30;
		addChild(_commandPanel);
	}

	private function initPropertiesPanel():void
	{
		_properiesPanel = new PropertiesPanel();
		_properiesPanel.y = 30;
		addChild(_properiesPanel);
	}

	private function initMenuPanel():void
	{
		_menuPanel = new MenuPanel();
		_menuPanel.x = 0;
		_menuPanel.y = 0;
		addChild(_menuPanel);
	}

	private function initStatusPanel():void
	{
		_statusPanel = new StatusPanel();
		_statusPanel.x = 0;
		_statusPanel.y = Settings.SCREEN_HEIGHT - 30;
		addChild(_statusPanel);
	}
}
}
