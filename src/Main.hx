package src;

import cocktail.api.CocktailView;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.ui.Keyboard;

/**
 * Store data provided by the player
 */
typedef GameData = {
	var name:String;
	var cocktail:String;
	var accessories:Array<String>;
}

/**
 * ...
 * @author 
 */
class Main
{
	static function main()
	{
		new Main();
	}
	
	var cv:CocktailView;
	
	var gameData:GameData;
	
	public function new() 
	{
		gameData = { };
		buildScene();
		setKeyListeners();
		initCocktail();
	}
	
	function buildScene()
	{
		//TODO : build flash scene
	}
	
	function initCocktail()
	{
		cv = new CocktailView();
		cv.window.onload = function(e) {
			setFormsListeners(cv.document);
		}
	}
	
	function setKeyListeners()
	{
		//TODO : listen for space press to open cocktail
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyDown);
	}
	
	function onKeyDown()
	{
		if (e.keyCode == Keyboard.SPACE)
		{
			showCocktail();
			Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyDown);
		}
	}
	
	function showCocktail()
	{
		Lib.current.addChild(cv.root);
	}
	
	function hideCocktail()
	{
		Lib.current.removeChild(cv.root);
	}
	
	function setFormsListeners(document)
	{
		//TODO : listen to document form submission for each form
		var forms = document.getElementsByTagName("form");
		
		for (form in forms)
		{
			form.addEventListener("submit", onFormSubmit); 
		}
	}
	
	function onFormSubmit(e)
	{
		var form = e.target;
		switch form.id
		{
			case "form1":
				onNameFormSubmit(form);
				
			case "form2":
				//TODO : store data, switch to form3
				
			case "form3":	
				//TODO : store data, display end screen
		}
	}
	
	function onNameFormSubmit(form)
	{
		gameData.name = form.getElementByTagNames("input")[0].value;
		
		form.style.display = "none";
		form.ownerDocument.getElementById("form2").style.display = "block";
	}
	
	function onCocktailFormSubmit(form)
	{
		
		
		form.style.display = "none";
		form.ownerDocument.getElementById("form3").style.display = "block";
	}
	
	function onAccessoriesFormSubmit(form)
	{
		
		onWin();
	}
	
	function onWin()
	{
		//TODO : render data using a flash text field
		hideCocktail();
		
	}
}