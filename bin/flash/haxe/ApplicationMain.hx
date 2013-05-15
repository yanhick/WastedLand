import Main;
import nme.Assets;
import nme.events.Event;


class ApplicationMain {
	
	static var mPreloader:NMEPreloader;

	public static function main () {
		
		var call_real = true;
		
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		
		nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		
		if (loaded < total || true) /* Always wait for event */ {
			
			call_real = false;
			mPreloader = new NMEPreloader();
			nme.Lib.current.addChild(mPreloader);
			mPreloader.onInit();
			mPreloader.onUpdate(loaded,total);
			nme.Lib.current.addEventListener (nme.events.Event.ENTER_FRAME, onEnter);
			
		}
		
		
		
		haxe.Log.trace = flashTrace; // null
		

		if (call_real)
			begin ();
	}

	
	private static function flashTrace( v : Dynamic, ?pos : haxe.PosInfos ) {
		var className = pos.className.substr(pos.className.lastIndexOf('.') + 1);
		var message = className+"::"+pos.methodName+":"+pos.lineNumber+": " + v;

        if (flash.external.ExternalInterface.available)
			flash.external.ExternalInterface.call("console.log", message);
		else untyped flash.Boot.__trace(v, pos);
    }
	
	
	private static function begin () {
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields(Main))
		{
			if (methodName == "main")
			{
				hasMain = true;
				break;
			}
		}
		
		if (hasMain)
		{
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
		}
		else
		{
			nme.Lib.current.addChild(cast (Type.createInstance(Main, []), nme.display.DisplayObject));	
		}
		
	}

	static function onEnter (_) {
		
		var loaded:Int = nme.Lib.current.loaderInfo.bytesLoaded;
		var total:Int = nme.Lib.current.loaderInfo.bytesTotal;
		mPreloader.onUpdate(loaded,total);
		
		if (loaded >= total) {
			
			nme.Lib.current.removeEventListener(nme.events.Event.ENTER_FRAME, onEnter);
			mPreloader.addEventListener (Event.COMPLETE, preloader_onComplete);
			mPreloader.onLoaded();
			
		}
		
	}

	public static function getAsset (inName:String):Dynamic {
		
		
		if (inName=="style.css")
			 
            return Assets.getBytes ("style.css");
         
		
		if (inName=="sober/assets/button.png")
			 
            return Assets.getBitmapData ("sober/assets/button.png");
         
		
		if (inName=="sober/assets/checkbox.png")
			 
            return Assets.getBitmapData ("sober/assets/checkbox.png");
         
		
		if (inName=="sober/assets/radio.png")
			 
            return Assets.getBitmapData ("sober/assets/radio.png");
         
		
		if (inName=="sober/style.css")
			 
            return Assets.getBytes ("sober/style.css");
         
		
		if (inName=="index.html")
			 
            return Assets.getBytes ("index.html");
         
		
		if (inName=="assets/ff2-mysidia-inn-1f.gif")
			 
            return Assets.getBitmapData ("assets/ff2-mysidia-inn-1f.gif");
         
		
		if (inName=="assets/inn.png")
			 
            return Assets.getBitmapData ("assets/inn.png");
         
		
		if (inName=="assets/inn.psd")
			 
            return Assets.getBytes ("assets/inn.psd");
         
		
		if (inName=="assets/ixt8hk.png")
			 
            return Assets.getBitmapData ("assets/ixt8hk.png");
         
		
		if (inName=="assets/link.jpg")
			 
            return Assets.getBitmapData ("assets/link.jpg");
         
		
		if (inName=="assets/link_end.gif")
			 
            return Assets.getBitmapData ("assets/link_end.gif");
         
		
		if (inName=="assets/mario_head.gif")
			 
            return Assets.getBitmapData ("assets/mario_head.gif");
         
		
		if (inName=="assets/sprites-link.gif")
			 
            return Assets.getBitmapData ("assets/sprites-link.gif");
         
		
		
		return null;
		
	}
	
	
	private static function preloader_onComplete (event:Event):Void {
		
		mPreloader.removeEventListener (Event.COMPLETE, preloader_onComplete);
		
		nme.Lib.current.removeChild(mPreloader);
		mPreloader = null;
		
		begin ();
		
	}
	
}


class NME_style_css extends nme.utils.ByteArray { }
class NME_sober_assets_button_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_sober_assets_checkbox_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_sober_assets_radio_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_sober_style_css extends nme.utils.ByteArray { }
class NME_index_html extends nme.utils.ByteArray { }
class NME_assets_ff2_mysidia_inn_1f_gif extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_inn_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_inn_psd extends nme.utils.ByteArray { }
class NME_assets_ixt8hk_png extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_link_jpg extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_link_end_gif extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_mario_head_gif extends nme.display.BitmapData { public function new () { super (0, 0); } }
class NME_assets_sprites_link_gif extends nme.display.BitmapData { public function new () { super (0, 0); } }

