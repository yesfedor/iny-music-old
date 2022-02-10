import { reactive } from 'vue'
import ThemeToggler from './ThemeToggler.vue'
import './theme.css'

const Theme = reactive({
  isCreate: false,
  $el: null,
  name: '',
  themes: {},
  allow: [],
  default: '',
  specialPurposeOld: null,
  specialPurposeKey: 'init-20222',
  specialPurposeName: 'light',
  create () {
    if (this.isCreate) {
      console.log('[Vue $theme]: A theme instance has already been created')
      return false
    }
    this.isCreate = true

    const storageThemeChanged = (event) => {
      if (event.key !== 'Theme') return false
      if (event.newValue === this.name) return false
      this.change(event.newValue)
    }
    window.addEventListener('storage', storageThemeChanged)

    this.$el = document.documentElement
    this.themes = {
      light: {
        icon: 'far fa-sun'
      },
      dark: {
        icon: 'far fa-moon'
      }
    }
    this.allow = Object.keys(this.themes)
    this.default = this.allow[0]
    this.name = localStorage.getItem('Theme') || this.default
    this.specialPurposeOld = localStorage.getItem('Theme-SpecialPurpose') || null
    this.checkSpecialPurpose()
    this.init()
  },
  init () {
    this.change(this.name)
  },
  change (name) {
    if (!this.allow.includes(name)) {
      console.log('[Vue $theme]: There is no such theme')
      return ''
    }

    this.name = name
    localStorage.setItem('Theme', name)
    this.$el.setAttribute('scheme', name)
  },
  checkSpecialPurpose () {
    if (this.specialPurposeOld !== this.specialPurposeKey) {
      this.name = this.specialPurposeName
      localStorage.setItem('Theme-SpecialPurpose', this.specialPurposeKey)
    }
  },
  toggle () {
    if (this.allow.length <= 1) return console.log('[Vue $theme]: Specify at least two theme to switch to')

    const N = this.allow.indexOf(this.name)
    const Nmax = this.allow.length - 1
    if (N === Nmax) this.change(this.allow[0])
    else this.change(this.allow[N + 1])
  },
  getIcon () {
    if (this.allow.length <= 1) return console.log('[Vue $theme]: Specify at least two theme to switch to')

    const N = this.allow.indexOf(this.name)
    const Nmax = this.allow.length - 1
    if (N === Nmax) return this.themes[this.allow[0]].icon
    else return this.themes[this.allow[N + 1]].icon
  }
})

export default {
  install: (app) => {
    app.config.globalProperties.$theme = Theme
    app.provide('theme', Theme)
    app.component('theme-toggler', ThemeToggler)
    Theme.create()
  }
}
