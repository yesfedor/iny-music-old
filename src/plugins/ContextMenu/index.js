import { reactive } from 'vue'
import ContextMenuBase from './ContextMenuBase'

const ContextMenuApp = reactive({
  $el: null,

  name: '',
  component: null,
  state: false,

  w: 0,
  h: 0,

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
    switch (type) {
      case 'show':
        // event.preventDefault()
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
