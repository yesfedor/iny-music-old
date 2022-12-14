import _ from 'lodash'
import { reactive } from 'vue'
import { useStore } from 'vuex'
import { usePlayerFetch } from './api'

/**
  @constant {Object} playerFetch
  @description dependencies
 */
const playerFetch = usePlayerFetch()

const playerApi = reactive({
  /**
   * @description config player
   */
  config: {
    modulePrefix: '[PlayerApi]: ',
    saveTimeInterval: 5000,
    isLogger: false
  },

  /**
   * @description player state
   */
  state: {
    songQueue: {},
    songQueueCurrent: {
      artist: {
        aid: 0,
        altname: '',
        name: '',
        surname: ''
      },
      featuring: [],
      title: '',
      song: '',
      img_1024: '',
      time: 0,
      duration: 0
    },
    userSongQueue: {},
    settings: {
      player_volume: 0,
      player_shuffle: false,
      player_repeat: ''
    }
  },

  $player: document.createElement('audio'),
  playerState: false,
  playerIcon: {
    play: 'fa-pause',
    pause: 'fa-play'
  },

  playerSetCurrentTime (time) {
    this.state.songQueueCurrent.time = time
    this.$player.currentTime = time
  },
  playerSetSrc (path) {
    this.$player.setAttribute('src', path)
  },
  playerCallback () {
    const onTimeUpdate = () => {
      this.state.songQueueCurrent.time = this.$player.currentTime
      this._api_setQueueCurrent()
    }
    const onEnded = () => {
      this.logger('log', 'end song')
      if (this.playerState) this.$player.currentTime = 0
    }
    this.$player.addEventListener('timeupdate', onTimeUpdate)
    this.$player.addEventListener('ended', onEnded)
  },

  /**
   * @name logger
   * @param {String} type ['log', 'warn', 'error']
   * @param {String} msg
   */
  logger (type, msg) {
    if (!this.config.isLogger) return false
    switch (type) {
      case 'log':
      case 'warn':
      case 'error':
        console[type](this.config.modulePrefix, msg)
    }
    return true
  },

  /**
   * @description first state load & run middlewares
   */
  initial () {
    const isAuth = this.middlewareManager('isAuth')
    if (!isAuth) return false

    this.api()
    this.playerCallback()

    playerFetch.getQueueCurrent().then(songQueueCurrent => {
      if (!songQueueCurrent?.id) return false
      this.state.songQueueCurrent = songQueueCurrent
      this.playerSetSrc(songQueueCurrent.song)
      this.playerSetCurrentTime(songQueueCurrent.time)
    })

    playerFetch.getPlayerSettings().then(settings => {
      if (!settings?.uid) return false
      this.state.settings = settings
      this.volumeChange(settings.player_volume)
    })
  },

  /**
   * apis
  */
  api () {
    this._api_setQueueCurrent = _.throttle(() => {
      if (!this.playerState) return false
      if (!(this.state.songQueueCurrent.sid && this.state.songQueueCurrent.time)) return false
      playerFetch.setQueueCurrent(this.state.songQueueCurrent.sid, this.state.songQueueCurrent.time.toFixed(0))
    }, this.config.saveTimeInterval)
  },

  /**
   * @description midddleware manager
   * @returns {Boolean}
   */
  middlewareManager (middlewareName) {
    try {
      middlewareName = '_middleware_' + middlewareName
      return this[middlewareName]()
    } catch {
      return this.logger('warn', 'unknown middleware')
    }
  },

  _middleware_isAuth () {
    const store = useStore()
    return store.getters.isAuth
  },

  /**
   * @todo all toggles
   */
  toggleFavorite () {},
  toggleRandom () {},
  togglePlay () {
    this.playerState ? this.pause() : this.play()
  },
  toggleRedo () {},

  /**
   * @description player state manager
   */
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

  /**
   * @description set player volume
   * @param { Number } volume
   */
  volumeChange (volume) {
    if (!(volume <= 100 && volume >= 0)) return false
    this.$player.volume = volume / 100
    this.state.settings.player_volume = volume
    playerFetch.setPlayerSettings(volume, this.state.settings.player_shuffle, this.state.settings.player_repeat)
  }
})

export default function usePlayerApi () {
  return playerApi
}
