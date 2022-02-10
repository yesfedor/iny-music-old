import { reactive } from 'vue'
import ProgressLine from './ProgressLine.vue'
import ProgressPreloader from './ProgressPreloader.vue'

const Progress = reactive({
  options: {
    preloaderEffectOnLine: true,
    isPreloader: false,
    counterActive: 0
  },
  showPreloader () {
    this.options.isPreloader = true
  },
  hidePreloader () {
    this.options.isPreloader = false
  },
  addLine () {
    this.options.counterActive++
  },
  removeLine () {
    if (this.options.counterActive > 0) this.options.counterActive--
    else this.options.counterActive = 0
  }
})

export default {
  install: (app) => {
    app.config.globalProperties.$progress = Progress
    app.provide('progress', Progress)
    app.component('progress-line', ProgressLine)
    app.component('progress-preloader', ProgressPreloader)
  }
}
