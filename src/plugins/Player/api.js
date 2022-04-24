import { API_FETCH } from '../../api/fetch'

const playerFetch = {
  async getQueueCurrent () {
    return await API_FETCH({
      crud: 'GET',
      version: '1.0',
      method: 'song.getQueueCurrent',
      isJwt: true,
      isClientId: true
    })
  },
  async getSongBySid (sid) {
    return await API_FETCH({
      crud: 'GET',
      version: '1.0',
      method: 'song.getBySid',
      args: {
        sid: sid
      }
    })
  },
  async getPlayerSettings () {
    return await API_FETCH({
      crud: 'GET',
      version: '1.0',
      method: 'song.getPlayerSettings',
      isJwt: true,
      isClientId: true
    })
  },
  async setPlayerSettings (playerVolume, playerShuffle, playerRepeat) {
    return await API_FETCH({
      crud: 'POST',
      version: '1.0',
      method: 'song.setPlayerSettings',
      isJwt: true,
      isClientId: true,
      post: {
        player_volume: playerVolume,
        player_shuffle: playerShuffle,
        player_repeat: playerRepeat
      }
    })
  },
  async setQueueCurrent (sid, time) {
    return await API_FETCH({
      crud: 'POST',
      version: '1.0',
      method: 'song.setQueueCurrent',
      isJwt: true,
      isClientId: true,
      post: {
        sid,
        time
      }
    })
  }
}

export function usePlayerFetch () {
  return playerFetch
}
