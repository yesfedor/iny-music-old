import { reactive } from 'vue'
import { API_FETCH } from '../../api/fetch'
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
  forward () {},

  async getSongBySid (sid) {
    return await API_FETCH({
      crud: 'GET',
      version: '1.0',
      method: 'song.getBySid',
      args: {
        sid: sid
      }
    })
  }
})

export default function usePlayerApi () {
  return playerApi
}
