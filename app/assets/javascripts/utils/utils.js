var time_string = Dorkle.Utils.time_string = function (time) {
  mins = Math.floor(time / 60);
  secs = ('0' + Math.floor(time % 60)).slice(-2);
  return mins + ':' + secs;
}
