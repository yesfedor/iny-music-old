export function songPrettyTime (time = 0) {
  /**
   * @todo add hours
   */
  if (!time) return '0:00'
  if (Math.ceil(time % 60) < 10) return Math.floor(time / 60) + ':0' + Math.ceil(time % 60)
  return Math.floor(time / 60) + ':' + Math.ceil(time % 60)
}
