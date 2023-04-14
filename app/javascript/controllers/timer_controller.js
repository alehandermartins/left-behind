import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { date: Number }

  connect() {
    const now = new Date()
    const seconds_since_start = Math.round(now.getTime() / 1000) - this.dateValue
    var minutes = Math.floor(seconds_since_start / 60)
    var seconds = seconds_since_start % 60

    if(minutes < 10)
      minutes = "0" + minutes

    if(seconds < 10)
      seconds = "0" + seconds

    this.element.textContent = minutes + ":" + seconds
  }
}
