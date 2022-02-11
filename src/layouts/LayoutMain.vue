<template>
  <div class="layout__main">
    <the-header class="layout__header"></the-header>
    <the-aside class="layout__aside"></the-aside>
    <the-wrapper class="layout__wrapper"></the-wrapper>
    <the-player v-if="isPlayer" class="layout__player"></the-player>
  </div>
</template>

<script>
import TheHeader from '../components/TheHeader.vue'
import TheAside from '../components/TheAside.vue'
import TheWrapper from '../components/TheWrapper.vue'
import ThePlayer from '../components/ThePlayer.vue'
import { ref } from '@vue/reactivity'

export default {
  name: 'LayoutMain',
  components: {
    TheHeader,
    TheAside,
    ThePlayer,
    TheWrapper
  },
  setup () {
    const isPlayer = ref(true)
    return {
      isPlayer
    }
  }
}
</script>

<style scoped>
.layout__main {
  display: grid;
  grid-template-areas: "the-aside main-view"
                       "now-playing-bar now-playing-bar";
  grid-template-columns: auto 1fr;
  grid-template-rows: 1fr auto;
  min-height: 100vh;
  position: relative;
  width: 100%;
  background: var(--layout-main-background);
  color: var(--layout-main-color);
}
.layout__header {
  width: 100%;
  height: var(--header-height);
  grid-area: main-view;
  z-index: 3;
}
.layout__wrapper {
  width: 100%;
  grid-area: main-view;
  min-height: calc(100vh - var(--player-height));
}
.layout__aside {
  width: calc(var(--aside-width));
  position: sticky;
  top: 0px;
  grid-area: the-aside;
  z-index: 3;
  max-height: calc(100vh - var(--player-height));
}
.layout__player {
  position: sticky;
  bottom: 0px;
  width: 100%;
  height: calc(var(--player-height) - 1px);
  grid-area: now-playing-bar;
}
</style>
