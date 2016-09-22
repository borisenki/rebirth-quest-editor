package
{

import com.bit101.components.Component;
import com.bit101.components.Style;

import editor.config.EditorConfig;

import flash.display.Sprite;

import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;

import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.impl.Context;

import editor.view.MainView;

[SWF(width=1280, height=720, backgroundColor=0x808080, frameRate=60)]

public class Main extends Sprite
{

	private var _contex:IContext;

	[Embed(source="../assets/font/basis33.swf", symbol="myComic")]
	private var font:Class;

	public function Main()
	{

		Component.initStage(stage);
		Style.setStyle(Style.DARK);
		Style.embedFonts = true;
		Style.fontSize = 16;
		Style.fontName = "myComic";

		//var createQuestPanel:MainPanel = new MainPanel();
		//addChild(createQuestPanel);

		var mainView:MainView = new MainView();
		addChild(mainView);

		_contex = new Context()
				.install(MVCSBundle, SignalCommandMapExtension)
				.configure(EditorConfig, new ContextView(mainView));

	}
}
}
