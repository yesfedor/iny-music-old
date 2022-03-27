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
  }
}

export function usePlayerFetch () {
  return playerFetch
}
