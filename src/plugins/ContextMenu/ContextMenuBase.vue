<template>
  <div v-show="state" class="plugin-context-menu-base js-plugin-context-menu-base">
    hello world
  </div>
</template>

<script>
import { computed, inject } from '@vue/runtime-core'

export default {
  name: 'ContextMenuBase',
  setup () {
    const contextMenu = inject('contextMenu')
    const state = computed(() => contextMenu.state)

    return {
      state
    }
  }
}
</script>

<style>
.plugin-context-menu-base {
  position: absolute;
  top: 10%;
  left: 10%;
  width: 6rem;
  height: 4rem;
  background: white;
  z-index: 99;
}
</style>
