/**
 * Created by borisenki on 06.09.16.
 */
package editor.view
{
import editor.controller.signals.StatusPanelSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class StatusPanelMediator extends Mediator
{
	[Inject]
	public var view:StatusPanel;

	[Inject]
	public var statusPanelSignal:StatusPanelSignal;

	override public function initialize():void
	{
		super.initialize();
		statusPanelSignal.add(onStatusPanel);
	}

	private function onStatusPanel(status:String):void
	{
		view.setStatus(status);
	}

	override public function destroy():void
	{
		statusPanelSignal.remove(onStatusPanel);
		super.destroy();
	}
}
}
