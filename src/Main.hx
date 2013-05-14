import cocktail.api.CocktailView;
import flash.events.KeyboardEvent;
import flash.Lib;
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
		gameData = {name:"", cocktail:"", accessories:[]};
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
		
		cv.loadURL("index.html");
		cv.window.onload = function(e) {
			setFormsListeners(cv.document);
		}
	}
	
	function setKeyListeners()
	{
		//TODO : listen for space press to open cocktail
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyDown);
	}
	
	function onKeyDown(e)
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
		var forms:Array<HtmlDom> = document.getElementsByTagName("form");
		
		for (form in forms)
		{
			form.addEventListener("submit", onFormSubmit); 
		}
	}
	
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
	
	function onNameFormSubmit(form:HtmlDom)
	{
		var textinput:FormElement = cast form.getElementsByTagName("input")[0];
		gameData.name = textinput.value;
		
		form.style.display = "none";
		form.ownerDocument.getElementById("cocktailForm").style.display = "block";
	}
	
	function onCocktailFormSubmit(form:HtmlDom)
	{
		gameData.cocktail = getCocktailRadio(form);
		
		form.style.display = "none";
		form.ownerDocument.getElementById("accessoriesForm").style.display = "block";
	}
	
	function getCocktailRadio(form:HtmlDom)
	{
		var radios:Array<HtmlDom> = form.getElementsByTagName("input");
		for (radio in radios)
		{
			var r:Radio = cast radio;
			if (r.checked)
				return r.value;
		}
		
		return null;
	}
	
	function onAccessoriesFormSubmit(form)
	{
		gameData.accessories = getAccessories(form);
		
		onWin();
	}
	
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
	
	function onWin()
	{
		//TODO : render data using a flash text field
		hideCocktail();
		
	}
}