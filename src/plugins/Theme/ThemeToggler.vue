<template>
  <i @click.stop="toggle()" class="theme-toggler" :class="$theme.getIcon()"></i>
</template>

<script>
import { inject } from '@vue/runtime-core'

export default {
  name: 'ThemeToggler',
  setup () {
    const theme = inject('theme')
    const toggle = () => {
      theme.toggle()
    }

    return {
      toggle
    }
  }
}
</script>

<style scoped>
.theme-toggler {
  user-select: none;
  cursor: pointer;
}
</style>
