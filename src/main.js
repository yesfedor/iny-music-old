import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import Position from './plugins/Position'
import Progress from './plugins/Progress'
import Theme from './plugins/Theme'
import './styles/main.css'

const importRemoteStyle = (href, data = {}) => {
  const $link = document.createElement('link')
  $link.href = href
  $link.rel = 'stylesheet'
  for (const key in data) {
    $link.setAttribute(key, data[key])
  }
  document.head.append($link)
}

const importRemoteScript = (src, data = {}) => {
  const $script = document.createElement('script')
  $script.src = src
  for (const key in data) {
    $script.setAttribute(key, data[key])
  }
  document.body.append($script)
}

// bootstrap 5
importRemoteStyle('https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css')
importRemoteScript('https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js')

// fontawesome free icon
importRemoteScript('https://kit.fontawesome.com/8e0e01f36f.js', { crossorigin: 'anonymous' })

createApp(App)
  .use(store)
  .use(router)
  .use(Position)
  .use(Progress)
  .use(Theme)
  .mount('#app')
