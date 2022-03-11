import axios from 'axios'

const playerApi = {
  config: {
    apiPathBySid: 'http://localhost:8080/store/cloud/'
  },

  state: {
    currentSong: {
      authorData: {},
      songData: {}
    }
  },

  initial () {},

  toggleFavorite () {},
  toggleRandom () {},
  togglePlay () {},
  toggleRedo () {},

  backward () {},
  pause () {},
  play () {},
  forward () {},

  fetch () {},

  async importSongBySid (sid) {
    const currentSongData = await axios.get(this.config.apiPathBySid + `id${sid}.json`)
    this.state.currentSong.authorData = currentSongData.data.author
    this.state.currentSong.songData = currentSongData.data.song
  }
}

export default function usePlayerApi () {
  return playerApi
}
