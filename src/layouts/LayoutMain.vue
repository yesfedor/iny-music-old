<template>
  <div class="layout__main">
    <context-menu-base></context-menu-base>
    <the-header class="layout__header"></the-header>
    <the-aside class="layout__aside"></the-aside>
    <the-wrapper class="layout__wrapper"></the-wrapper>
    <the-player v-if="isPlayer" class="layout__player"></the-player>
    <the-mobile-bar class="layout__mobile-bar"></the-mobile-bar>
  </div>
</template>

<script>
import TheHeader from '../components/TheHeader.vue'
import TheAside from '../components/TheAside.vue'
import TheWrapper from '../components/TheWrapper.vue'
import ThePlayer from '../components/ThePlayer.vue'
import { ref } from '@vue/reactivity'
import TheMobileBar from '../components/TheMobileBar.vue'
import { useProgress } from '../plugins/hooks'

export default {
  name: 'LayoutMain',
  components: {
    TheHeader,
    TheAside,
    ThePlayer,
    TheWrapper,
    TheMobileBar
  },
  setup () {
    const progress = useProgress()
    progress.showPreloader()
    setTimeout(() => {
      progress.hidePreloader()
    }, 1000)
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
}
.layout__aside {
  width: var(--aside-width);
  position: sticky;
  top: 0px;
  grid-area: the-aside;
  z-index: 3;
  max-height: calc(100vh - var(--player-height, 0px));
}
.layout__player {
  position: sticky;
  width: 100%;
  height: calc(var(--player-height) - 1px);
  grid-area: now-playing-bar;
}

.layout__mobile-bar {
  position: sticky;
  bottom: 0px;
  width: 100%;
  height: calc(var(--mobile-bar-height) - 1px);
  grid-area: mobile-bar;

}

@media (max-width: 767.98px) {
  .layout__wrapper {
    min-height: calc(100vh - var(--player-height) - var(--mobile-bar-height));
  }
  .layout__player {
    bottom: var(--mobile-bar-height, 0px);
  }
  .layout__mobile-bar {
    display: flex;
  }
  .layout__main {
    grid-template-areas: "main-view main-view" "now-playing-bar now-playing-bar" "mobile-bar mobile-bar";
  }
  .layout__aside {
    display: none;
  }
}

@media (min-width: 768px) {
  .layout__wrapper {
    min-height: calc(100vh - var(--player-height));
  }
  .layout__player {
    bottom: 0px;
  }
  .layout__mobile-bar {
    display: none;
  }
  .layout__main {
    grid-template-areas: "the-aside main-view" "now-playing-bar now-playing-bar";
  }
  .layout__aside {
    display: flex;
  }
}
</style>
