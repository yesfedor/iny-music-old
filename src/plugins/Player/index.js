import { reactive } from 'vue'
import { usePlayerFetch } from './api'

const playerFetch = usePlayerFetch()

const playerApi = reactive({
  config: {
    ...playerFetch
  },

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
