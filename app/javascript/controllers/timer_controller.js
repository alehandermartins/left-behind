import { Controller } from "@hotwired/stimulus"
var _clock

export default class extends Controller {
  static values = { start: Number, end: Number }

  connect() {
    this.stopClock()

    if(this.startValue == 0){
      this.element.innerHTML = "10:00"
      return
    }

    if(this.endValue != 0){
      const max_time = this.startValue + 600
      const seconds_left = max_time - this.endValue
      this.element.innerHTML = this.parseTime(seconds_left)
      return
    }

    this.updateClock(this, this.startValue)
    _clock = setInterval(this.updateClock, 1000, this, this.startValue)
  }

  stopClock() {
    clearInterval(_clock)
  }

  updateClock(self, start_time) {
    var elem = document.getElementById("clock")

    const max_time = start_time + 600
    const now = new Date()
    const now_time = Math.round(now.getTime() / 1000)

    if(now_time > max_time)
      window.location.reload()

    const seconds_left = max_time - now_time
    elem.innerHTML = self.parseTime(seconds_left)
  }

  parseTime(seconds_left){
    var minutes = Math.floor(seconds_left / 60)
    var seconds = seconds_left % 60

    if (minutes < 10)
      minutes = "0" + minutes

    if (seconds < 10)
      seconds = "0" + seconds

    return minutes + ":" + seconds
  }
}
