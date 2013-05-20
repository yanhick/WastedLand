import GameData;
import cocktail.api.CocktailView;
import flash.display.Bitmap;
import flash.events.MouseEvent;
import haxe.Template;
import nme.installer.Assets;

import flash.events.KeyboardEvent;
import flash.Lib;
import flash.text.TextField;
import flash.ui.Keyboard;
import js.Dom;
import com.eclecticdesignstudio.motion.Actuate;



/**
 * A game demo using cocktail. The game
 * graphics are done using flash API and the
 * game UI is done using Cocktail anf the DOM API
 * 
 * @author yannick dominguez
 */
class Main
{
	static function main()
	{
		new Main();
	}
	
	/**
	 * the cocktail webview
	 * component
	 */
	var cv:CocktailView;
	
	/**
	 * store game data input
	 * by the user
	 */
	var gameData:GameData;
	
	/**
	 * class constructor
	 */
	public function new() 
	{
		gameData = {name:"", cocktail:"", accessories:[]};
		buildScene();
		setKeyListeners();
		initCocktail();
	}
	
	/////////////////////////////////
	// FLASH API CODE
	////////////////////////////////
	
	/**
	 * builds the flash game scene
	 */
	function buildScene()
	{
		var inn = new Bitmap(Assets.getBitmapData("assets/inn.png"));
		var mario = new Bitmap(Assets.getBitmapData("assets/mario.png"));
		var link = new Bitmap(Assets.getBitmapData("assets/link.png"));
		
		Lib.current.addChild(inn);
		Lib.current.addChild(mario);
		Lib.current.addChild(link);
		
		mario.x = 540;
		mario.y = 300;
		
		link.x = 250;
		link.y = 340;
		
	}
	
	/**
	 * keyboard listeners for the flash game part
	 */
	function setKeyListeners()
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	/**
	 * when space is pressed, show the cocktail view
	 */
	function onKeyUp(e)
	{
		if (e.keyCode == Keyboard.SPACE)
		{
			showCocktail();
			
			Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
	}
	
	/**
	 * show cocktail by attaching it
	 * to the flash stage
	 */
	function showCocktail()
	{
		Lib.current.addChild(cv.root);
	}
	
	/**
	 * hide cocktail by removing it
	 * from the stage
	 */
	function hideCocktail()
	{
		Lib.current.removeChild(cv.root);
	}
	
	/////////////////////////////////
	// DOM (COCKTAIL) API CODE
	////////////////////////////////
	
	/**
	 * init the cocktail webview 
	 * and loads the html file for
	 * the game UI
	 */
	function initCocktail()
	{
		cv = new CocktailView();
		
		cv.loadURL("index.html");
		
		cv.viewport = { x:200, y:200, width:Lib.current.stage.stageWidth - 400, height:Lib.current.stage.stageHeight - 400 };
		
		cv.window.onload = function(e) {
			var form = new FormsManager(cv.document, gameData, onWin);
		}
	}
	
	/**
	 * hide coctail view with transition effect
	 */
	function onWin()
	{
		Actuate.tween(cv.root, 1, { alpha:0, width:0, height:0 } ).onComplete(function() {
			hideCocktail();
			end();
			
		});
	}
	
	/**
	 * display end screen with data provided by user
	 */
	function end()
	{	
		var endScreenView = new CocktailView();
		endScreenView.loadURL("endscreen.html");
		endScreenView.window.onload = function(e) {
			
			var result = "
			<h1>Congratulations ::name:: !!!</h1>
			<h2>You've have successfully ordered a ::cocktail::</h2>
			<p> with : ::foreach accessories::::__current__:: / ::end::</p>";
			
			endScreenView.document.getElementById("result").innerHTML = new Template(result).execute(gameData);
			Lib.current.addChild(endScreenView.root);
		}
	}
}