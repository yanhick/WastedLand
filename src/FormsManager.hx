
import js.Dom;
import js.Lib;
import GameData;

/**
 * This class takes care of the HTML forms
 * logic
 * 
 * @author yannick dominguez
 */
class FormsManager
{
	/**
	 * allows to build this class individually in JS 
	 * to test the form logic part of the game in a browser
	 */
	static function main()
	{
		Lib.window.onload = function(e) {
			new FormsManager(Lib.document, {name:"", cocktail:"", accessories:[]});
		}
	}
	
	/**
	 * callback called when all forms were filled
	 */
	var winCb:Void->Void;
	
	/**
	 * game data filled by forms data
	 */
	var gameData:GameData;
	
	/**
	 * the current document
	 */
	var document:Document;
	
	public function new(doc:Document, gd:GameData, winCallback:Void->Void = null) 
	{
		document = doc;
		winCb = winCallback;
		gameData = gd;
		setFormsListeners(document);
	}
	
	/**
	 * get all forms in the html doc for UI,
	 * and listens for each form submission events
	 */
	function setFormsListeners(document:Document)
	{
		var forms:HtmlCollection<HtmlDom> = document.getElementsByTagName("form");
		
		for (i in 0...forms.length)
		{
			forms[i].addEventListener("submit", onFormSubmit, false); 
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
		document.getElementById("cocktailForm").style.display = "block";
	}
	
	/**
	 * store cocktail choice input by player
	 */
	function onCocktailFormSubmit(form:HtmlDom)
	{
		gameData.cocktail = getCocktailRadio(form);
		
		form.style.display = "none";
		document.getElementById("accessoriesForm").style.display = "block";
	}
	
	/**
	 * get the value of the form's radio control
	 */
	function getCocktailRadio(form:HtmlDom)
	{
		var inputs:HtmlCollection<HtmlDom> = form.getElementsByTagName("input");
		for (i in 0...inputs.length)
		{
			var input:FormElement = cast inputs[i];
			if (input.type == "radio")
			{
				var r:Radio = cast input;
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
		
		if (winCb != null)
		{
			winCb();
		}
	}
	
	/**
	 * get all checked check boxes value
	 */
	function getAccessories(form)
	{
		var checkBoxes:HtmlCollection<HtmlDom> = form.getElementsByTagName("input");
		
		var accessories = []; 
		
		for (i in 0...checkBoxes.length)
		{
			var checkbox:Checkbox = cast checkBoxes[i];
			if (checkbox.checked)
				accessories.push(checkbox.value);
		}
		
		return accessories;
	}
}