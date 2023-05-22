import { Controller } from "@hotwired/stimulus"
var _clock
var _time_count = 0
var game_duration = 180

export default class extends Controller {
  static values = { start: Number, end: Number, penalties: Number }

  connect() {
    this.stopClock()

    if(this.startValue == 0){
      this.element.innerHTML = "3:00"
      _time_count = 0
      return
    }

    if(this.endValue != 0){
      this.element.innerHTML = this.parseTime(game_duration - (this.endValue - this.startValue) - this.penaltiesValue * 10)
      return
    }

    if(_time_count == 0){
      _time_count = this.elapsed_time(this)
    }

    this.updateClock(this, this.startValue)
    _clock = setInterval(this.updateClock, 100, this)
  }

  stopClock() {
    clearInterval(_clock)
  }

  elapsed_time(self){
    const now = new Date()
    const now_time = Math.round(now.getTime() / 1000)
    return now_time - self.startValue + (self.penaltiesValue) * 10
  }

  updateClock(self) {
    var elem = document.getElementById("clock")

    const elapsed_time = self.elapsed_time(self)

    if(elapsed_time > game_duration)
      window.location.reload()

    if(elapsed_time > _time_count)
      _time_count = _time_count + 1

    const seconds_left = game_duration - _time_count
    elem.innerHTML = self.parseTime(seconds_left)
  }

  parseTime(seconds_left){
    if(seconds_left < 0)
      seconds_left = 0

    var minutes = Math.floor(seconds_left / 60)
    var seconds = seconds_left % 60

    if (minutes < 10)
      minutes = "0" + minutes

    if (seconds < 10)
      seconds = "0" + seconds

    return minutes + ":" + seconds
  }
}
