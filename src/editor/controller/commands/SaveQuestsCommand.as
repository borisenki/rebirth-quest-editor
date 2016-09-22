/**
 * Created by borisenki on 13.09.16.
 */
package editor.controller.commands
{
import editor.controller.signals.StatusPanelSignal;
import editor.model.DataModel;
import editor.model.DataTypes;
import editor.model.GameQuests;

import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import robotlegs.bender.bundles.mvcs.Command;

public class SaveQuestsCommand extends Command
{
	[Inject]
	public var gameQuests:GameQuests;

	[Inject]
	public var statusPanelSignal:StatusPanelSignal;

	private var file:File;

	override public function execute():void
	{
		file = File.applicationDirectory;
		file.addEventListener(Event.SELECT, dirSelected);
		file.browseForOpen("Select quests.xml");
	}

	private function dirSelected(e:Event):void {
		var stream:FileStream = new FileStream();
		stream.open(file, FileMode.WRITE);
		stream.writeUTFBytes(gameQuests.gexXML().toXMLString());
		stream.close();
		statusPanelSignal.dispatch("quests.xml сохранён");
	}
}
}
