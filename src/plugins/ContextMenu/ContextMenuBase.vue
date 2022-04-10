<template>
  <div v-show="state" @click.stop class="plugin-context-menu-base js-plugin-context-menu-base">
    hello world
  </div>
</template>

<script>
import { computed, inject } from '@vue/runtime-core'

export default {
  name: 'ContextMenuBase',
  setup () {
    const contextMenu = inject('contextMenu')
    const position = inject('position')

    const state = computed(() => contextMenu.state)

    const width = computed(() => contextMenu.w + 'px')
    const height = computed(() => contextMenu.h + 'px')

    const pageX = computed(() => {
      let pageX = contextMenu.x
      if (pageX + contextMenu.w > position.clientX) pageX = pageX - contextMenu.w
      return pageX + 'px'
    })
    const pageY = computed(() => {
      let pageY = contextMenu.y
      if (pageY + contextMenu.h > position.clientY) pageY = pageY - contextMenu.h
      return pageY + 'px'
    })
    return {
      width,
      height,
      pageX,
      pageY,
      state
    }
  }
}
</script>

<style scoped>
.plugin-context-menu-base {
  padding: 1rem 1.25rem;
  width: v-bind(width);
  height: v-bind(height);
  position: absolute;
  top: v-bind(pageY);
  left: v-bind(pageX);
  color: var(--layout-main-color-subdued);
  border-radius: 0.5rem;
  border: 1px solid var(--layout-main-background);
  background: var(--layout-wrapper-colorfull);
  backdrop-filter: blur(8px) saturate(180%);
  box-shadow: 0 0 1rem 0 var(--layout-wrapper-colorfull);
  z-index: 99;
}
</style>
