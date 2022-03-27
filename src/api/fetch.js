import axios from 'axios'
import { API_GET_URL } from './config'
import { Api } from '../plugins/Auth'

export async function API_FETCH (
  {
    crud = 'GET',
    version = '1.0',
    method = '',
    args = {},
    post = {},
    get = {},
    isJwt = false,
    isClientId = false,
    onStart = () => {},
    onEnd = () => {}
  }
) {
  const getQuery = { ...args, ...get }
  let result = null
  let path = ''
  let jwt = ''
  let clientId = ''

  if (isJwt) {
    const key = Api.config.localStorageName.jwt
    jwt = localStorage.getItem(key)
    getQuery.jwt = jwt
  }

  if (isClientId) {
    const key = Api.config.localStorageName.clientId
    clientId = localStorage.getItem(key)
    getQuery.clientId = clientId
  }

  onStart()
  switch (crud) {
    default:
    case 'GET':
      path = API_GET_URL(version, method, getQuery)
      result = await axios.get(path)
      break
    case 'POST':
      path = API_GET_URL(version, method, getQuery)
      result = await axios.post(path, post)
      break
  }
  onEnd(result)

  return result
}
