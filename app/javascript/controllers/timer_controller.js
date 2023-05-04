import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { date: Number }

  connect() {

    if(this.dateValue == 0)
      return

    this.updateClock(this.dateValue)
    setInterval(this.updateClock, 1000, this.dateValue)
  }

  updateClock(start_time) {
    const now = new Date()
    const seconds_since_start = Math.round(now.getTime() / 1000) - start_time
    var minutes = Math.floor(seconds_since_start / 60)
    var seconds = seconds_since_start % 60

    if (minutes < 10)
      minutes = "0" + minutes

    if (seconds < 10)
      seconds = "0" + seconds

    var elem = document.getElementById("clock")
    elem.innerHTML = minutes + ":" + seconds
  }
}
