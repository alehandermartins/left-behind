import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "button", "result" ]

  connect(){
    if(this.buttonTarget.classList.contains("hidden")){
      setTimeout(this.displayButton, 5000, this)
    }
  }

  displayButton(self){
    self.resultTarget.classList.add("hidden")
    self.buttonTarget.classList.remove("hidden")
  }
}