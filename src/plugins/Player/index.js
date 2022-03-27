import { reactive } from 'vue'

const playerApi = reactive({
  config: {},

  state: {},

  $player: document.createElement('audio'),
  playerState: false,

  initial () {},

  toggleFavorite () {},
  toggleRandom () {},
  togglePlay () {
    this.playerState ? this.pause() : this.play()
  },
  toggleRedo () {},

  backward () {},
  pause () {
    this.playerState = false
    this.$player.pause()
  },
  play () {
    this.playerState = true
    this.$player.play()
  },
  forward () {}
})

export default function usePlayerApi () {
  return playerApi
}
