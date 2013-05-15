package nme.installer;


import nme.display.BitmapData;
import nme.media.Sound;
import nme.net.URLRequest;
import nme.text.Font;
import nme.utils.ByteArray;
import ApplicationMain;


/**
 * ...
 * @author Joshua Granick
 */

class Assets {

	
	public static var cachedBitmapData:Hash<BitmapData> = new Hash<BitmapData>();
	
	private static var initialized:Bool = false;
	private static var resourceClasses:Hash <Dynamic> = new Hash <Dynamic> ();
	private static var resourceTypes:Hash <String> = new Hash <String> ();
	
	
	private static function initialize ():Void {
		
		if (!initialized) {
			
			resourceClasses.set ("style.css", NME_style_css);
			resourceTypes.set ("style.css", "binary");
			resourceClasses.set ("sober/assets/button.png", NME_sober_assets_button_png);
			resourceTypes.set ("sober/assets/button.png", "image");
			resourceClasses.set ("sober/assets/checkbox.png", NME_sober_assets_checkbox_png);
			resourceTypes.set ("sober/assets/checkbox.png", "image");
			resourceClasses.set ("sober/assets/radio.png", NME_sober_assets_radio_png);
			resourceTypes.set ("sober/assets/radio.png", "image");
			resourceClasses.set ("sober/style.css", NME_sober_style_css);
			resourceTypes.set ("sober/style.css", "binary");
			resourceClasses.set ("index.html", NME_index_html);
			resourceTypes.set ("index.html", "binary");
			resourceClasses.set ("assets/ff2-mysidia-inn-1f.gif", NME_assets_ff2_mysidia_inn_1f_gif);
			resourceTypes.set ("assets/ff2-mysidia-inn-1f.gif", "image");
			resourceClasses.set ("assets/inn.png", NME_assets_inn_png);
			resourceTypes.set ("assets/inn.png", "image");
			resourceClasses.set ("assets/inn.psd", NME_assets_inn_psd);
			resourceTypes.set ("assets/inn.psd", "binary");
			resourceClasses.set ("assets/ixt8hk.png", NME_assets_ixt8hk_png);
			resourceTypes.set ("assets/ixt8hk.png", "image");
			resourceClasses.set ("assets/link.jpg", NME_assets_link_jpg);
			resourceTypes.set ("assets/link.jpg", "image");
			resourceClasses.set ("assets/link_end.gif", NME_assets_link_end_gif);
			resourceTypes.set ("assets/link_end.gif", "image");
			resourceClasses.set ("assets/mario_head.gif", NME_assets_mario_head_gif);
			resourceTypes.set ("assets/mario_head.gif", "image");
			resourceClasses.set ("assets/sprites-link.gif", NME_assets_sprites_link_gif);
			resourceTypes.set ("assets/sprites-link.gif", "image");
			
			initialized = true;
			
		}
		
	}
	
	
	public static function getBitmapData (id:String, useCache:Bool = true):BitmapData {
		
		initialize ();
		
		if (resourceTypes.exists (id) && resourceTypes.get (id) == "image") {
			
			if (useCache && cachedBitmapData.exists (id)) {
				
				return cachedBitmapData.get (id);
				
			} else {
				
				var data = cast (Type.createInstance (resourceClasses.get (id), []), BitmapData);
				
				if (useCache) {
					
					cachedBitmapData.set (id, data);
					
				}
				
				return data;
				
			}
			
		} else {
			
			trace ("[nme.Assets] There is no BitmapData asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getBytes (id:String):ByteArray {
		
		initialize ();
		
		if (resourceClasses.exists (id)) {
			
			return Type.createInstance (resourceClasses.get (id), []);
			
		} else {
			
			trace ("[nme.Assets] There is no ByteArray asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getFont (id:String):Font {
		
		initialize ();
		
		if (resourceTypes.exists (id) && resourceTypes.get (id) == "font") {
			
			return cast (Type.createInstance (resourceClasses.get (id), []), Font);
			
		} else {
			
			trace ("[nme.Assets] There is no Font asset with an ID of \"" + id + "\"");
			
			return null;
			
		}
		
	}
	
	
	public static function getSound (id:String):Sound {
		
		initialize ();
		
		if (resourceTypes.exists (id)) {
			
			if (resourceTypes.get (id) == "sound" || resourceTypes.get (id) == "music") {
				
				return cast (Type.createInstance (resourceClasses.get (id), []), Sound);
				
			}
			
		}
		
		trace ("[nme.Assets] There is no Sound asset with an ID of \"" + id + "\"");
		
		return null;
		
	}
	
	
	public static function getText (id:String):String {
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
	}
	
	
}