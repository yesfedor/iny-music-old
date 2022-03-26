const playerFetch = {
  path: process.env.NODE_ENV === 'development' ? '/store/cloud/' : '/store/cloud/'
}

export function usePlayerFetch () {
  return playerFetch
}
