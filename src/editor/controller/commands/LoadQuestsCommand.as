/**
 * Created by borisenki on 09.09.16.
 */
package editor.controller.commands
{
import editor.controller.signals.QuestsLoadedSignal;
import editor.controller.signals.StatusPanelSignal;
import editor.model.GameQuests;

import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import robotlegs.bender.bundles.mvcs.Command;

public class LoadQuestsCommand extends Command
{
	[Inject]
	public var gameQuests:GameQuests;

	[Inject]
	public var statusPanelSignal:StatusPanelSignal;

	[Inject]
	public var questsLoadedSignal:QuestsLoadedSignal;

	private var file:File;

	override public function execute():void
	{
		trace("Start--LoadTypesCommand");
		statusPanelSignal.dispatch("Загрузка quest.xml");

		file = File.applicationDirectory;
		file.addEventListener(Event.SELECT, dirSelected);
		file.browseForOpen("Select quests.xml");
	}

	private function dirSelected(e:Event):void
	{
		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.READ);
		var quests:XML = XML(stream.readUTFBytes(stream.bytesAvailable));
		stream.close();
		gameQuests.setupXML(quests);
		statusPanelSignal.dispatch("quests.xml загружен");
	}
}
}
