export const API_PROTOCOL = '//'
export const API_HOST = 'music.iny.su'
export const API_PATH = '/api/method/'

export function API_GET_URL (version, method, args = {}) {
  const argsCompile = []
  const argsKeys = Object.keys(args)
  const fnArgsValueByType = (argValue) => {
    switch (typeof argValue) {
      case 'bigint':
      case 'number':
      case 'string':
      case 'symbol':
        return argValue
      case 'boolean':
        if (argValue) return '1'
        else return '0'
      case 'function':
        return fnArgsValueByType(argValue())
      case 'object':
        return JSON.stringify(argValue)
    }
  }

  argsKeys.forEach((argKey) => {
    const argValue = args[argKey]
    let argPush = argKey + '='
    argPush += fnArgsValueByType(argValue)
    argsCompile.push(argPush)
  })

  version = '?v=' + version

  return API_PROTOCOL + API_HOST + API_PATH + method + version + (argsCompile.length > 0 ? '&' + argsCompile.join('&') : '')
}
