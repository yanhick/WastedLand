import cocktail.api.CocktailView;

import flash.events.KeyboardEvent;
import flash.Lib;
import flash.text.TextField;
import flash.ui.Keyboard;
import js.Dom;

/**
 * Store data provided by the player
 */
typedef GameData = {
	var name:String;
	var cocktail:String;
	var accessories:Array<String>;
}

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
	
	/**
	 * builds the flash game scene
	 */
	function buildScene()
	{
		//TODO : build flash scene
	}
	
	/**
	 * init the cocktail webview 
	 * and loads the html file for
	 * the game UI
	 */
	function initCocktail()
	{
		cv = new CocktailView();
		
		cv.loadURL("index.html");
		cv.window.onload = function(e) {
			setFormsListeners(cv.document);
		}
	}
	
	/**
	 * keyboard listeners for the flash game part
	 */
	function setKeyListeners()
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyDown);
	}
	
	/**
	 * when space is pressed, show the cocktail view
	 */
	function onKeyDown(e)
	{
		if (e.keyCode == Keyboard.SPACE)
		{
			showCocktail();
			Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyDown);
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
	
	/**
	 * get all forms in the html doc for UI,
	 * and listens for each form submission events
	 */
	function setFormsListeners(document:Document)
	{
		var forms:Array<HtmlDom> = document.getElementsByTagName("form");
		
		for (form in forms)
		{
			form.addEventListener("submit", onFormSubmit); 
		}
	}
	
	/**
	 * when a form is submitted, store its
	 * info then go to the next form or end
	 * the game if last form
	 */
	function onFormSubmit(e:Event)
	{
		e.preventDefault();
		
		var form:HtmlDom = cast e.target;
		switch (form.id)
		{
			case "nameForm":
				onNameFormSubmit(form);
				
			case "cocktailForm":
				onCocktailFormSubmit(form);
				
			case "accessoriesForm":	
				onAccessoriesFormSubmit(form);
		}
	}
	
	/**
	 * store name input by player
	 */
	function onNameFormSubmit(form:HtmlDom)
	{
		var textinput:FormElement = cast form.getElementsByTagName("input")[0];
		gameData.name = textinput.value;
		
		form.style.display = "none";
		form.ownerDocument.getElementById("cocktailForm").style.display = "block";
	}
	
	/**
	 * store cocktail choice input by player
	 */
	function onCocktailFormSubmit(form:HtmlDom)
	{
		gameData.cocktail = getCocktailRadio(form);
		
		form.style.display = "none";
		form.ownerDocument.getElementById("accessoriesForm").style.display = "block";
	}
	
	/**
	 * get the value of the form's radio control
	 */
	function getCocktailRadio(form:HtmlDom)
	{
		var inputs:Array<HtmlDom> = form.getElementsByTagName("input");
		for (input in inputs)
		{
			var i:FormElement = cast input;
			if (i.type == "radio")
			{
				var r:Radio = cast i;
				if (r.checked)
					return r.value;
			}
			
		}
		
		return null;
	}
		
	/**
	 * store cocktail accessories input by player
	 */
	function onAccessoriesFormSubmit(form)
	{
		gameData.accessories = getAccessories(form);
		onWin();
	}
	
	/**
	 * get all checked check boxes value
	 */
	function getAccessories(form)
	{
		var checkBoxes:Array<HtmlDom> = form.getElementsByTagName("input");
		
		var accessories = []; 
		
		for (checkBox in checkBoxes)
		{
			var cb:Checkbox = cast checkBox;
			if (cb.checked)
				accessories.push(cb.value);
		}
		
		return accessories;
	}
	
	/**
	 * when all forms were filled, display 
	 * the result
	 */
	function onWin()
	{
		hideCocktail();
		
		var tf = new TextField();
		tf.width = 300;
		tf.text = gameData.name + "," + gameData.cocktail + ","+ gameData.accessories.join(",");
		Lib.current.addChild(tf);
		
	}
}