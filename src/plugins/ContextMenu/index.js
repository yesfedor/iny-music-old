import { reactive } from 'vue'
import ContextMenuBase from './ContextMenuBase'

const ContextMenuApp = reactive({
  isLifeCycle: false,

  $el: null,

  name: '',
  component: null,
  state: false,

  w: 200,
  h: 300,

  x: 0,
  y: 0,

  show () {
    this.state = true
  },
  hide () {
    this.state = false
  },
  toggle () {
    this.state = !this.state
  },

  drawer () {},

  listener (event, type = 'show') {
    if (!this.isLifeCycle) return false
    switch (type) {
      case 'show':
        event.preventDefault()
        this.x = event.pageX
        this.y = event.pageY
        this.show()
        break
      case 'hide':
        this.hide()
        break
    }
  },

  create () {
    const _listenerShow = (event) => {
      this.listener(event, 'show')
    }
    const _listenerHide = (event) => {
      this.listener(event, 'hide')
    }

    window.addEventListener('contextmenu', _listenerShow)
    window.addEventListener('click', _listenerHide)
  },

  mounted () {
    this.isLifeCycle = true
  },

  unmounted () {
    this.isLifeCycle = false
  }
})

const ContextMenu = {
  install: (app) => {
    app.config.globalProperties.$contextMenu = ContextMenuApp
    app.provide('contextMenu', ContextMenuApp)
    app.component('ContextMenuBase', ContextMenuBase)
    ContextMenuApp.create()
  }
}

export default ContextMenu
