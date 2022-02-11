<template>
  <section class="the-player">
    <app-banner-auth v-if="!isAuth" class="the-player__banner"></app-banner-auth>
    <div v-else class="the-player__wrapper"></div>
  </section>
</template>

<script>
import { computed } from '@vue/runtime-core'
import { useStore } from 'vuex'
import AppBannerAuth from './AppBannerAuth.vue'

export default {
  name: 'ThePlayer',
  components: {
    AppBannerAuth
  },
  setup () {
    const store = useStore()
    const isAuth = computed(() => store.getters.isAuth)
    const user = computed(() => store.getters.user)
    return {
      isAuth,
      user
    }
  }
}
</script>

<style>
html.user-auth-true {
  --player-height: 64px;
}
html.user-auth-false {
  --player-height: 80px;
}
</style>

<style scoped>
.the-player {
  display: flex;
  border-top: 1px solid var(--the-player-border-color);
  background: var(--the-player-background);
  z-index: 3;
}
</style>
