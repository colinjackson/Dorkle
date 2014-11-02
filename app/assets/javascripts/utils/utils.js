var timeString = Dorkle.Utils.timeString = function (time) {
  if (!time) return '';

  mins = Math.floor(time / 60);
  secs = ('0' + Math.floor(time % 60)).slice(-2);
  return mins + ':' + secs;
}
