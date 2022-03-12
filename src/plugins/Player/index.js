import axios from 'axios'
import { reactive } from 'vue'

const playerApi = reactive({
  config: {
    apiPathBySid: 'http://localhost:8080/store/cloud/'
  },

  state: {
    currentSong: {
      authorData: {
        id: 0,
        name: '',
        surname: ''
      },
      songData: {
        id: 0,
        playlistId: 0,
        title: '',
        posterUrl: ''
      }
    }
  },

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

  fetch () {},

  async importSongBySid (sid) {
    const currentSongData = await axios.get(this.config.apiPathBySid + `id${sid}.json`)
    this.state.currentSong.authorData = currentSongData.data.author
    this.state.currentSong.songData = currentSongData.data.song
    this.$player.setAttribute('src', this.config.apiPathBySid + `id${sid}.mp3`)
    this.$player.setAttribute('preload', 'auto')
  }
})

export default function usePlayerApi () {
  return playerApi
}
