import { Controller } from "@hotwired/stimulus"
import autocomplete from 'js-autocomplete';


// Connects to data-controller="autocomplete"
export default class extends Controller {
  static targets = ["searchInput"]
  static values = { choices: Array }

  connect() {
    // console.log("autocomplete connected")
    // console.log(this.searchInputTarget)
    // console.log(this.choicesValue)
    const choices = this.choicesValue;
    new autocomplete({
      selector: this.searchInputTarget,
      minChars: 1,
      source: function(term, suggest){
          term = term.toLowerCase();
          const matches = [];
          for (let i = 0; i < choices.length; i++)
              if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
          suggest(matches);
      },
    });
  }
}
