<template>
  <section class="the-player">
    <app-banner-auth v-if="!isAuth" class="the-player__banner"></app-banner-auth>
    <div v-else class="the-player__wrapper">
      <div class="the-player__info-bar" @click="overlayMobileToggle()">
        <img class="the-player__poster ratio ration1x1" :src="song.posterUrl">
        <div class="the-player__info-text">
          <router-link
            :to="{ name: 'Playlist', params: { playlistId: song.playlistId }}"
            class="the-player__title text-truncate"
            @click.stop
          >
            {{ song.title }}
          </router-link>
          <router-link
            :to="{ name: 'Artist', params: { artistId: author.id }}"
            class="the-player__author text-truncate"
            @click.stop
          >
            {{ author.name }} {{ author.surname }}
          </router-link>
        </div>
        <i class="the-player__like far fa-heart"></i>
      </div>
      <div class="the-player__manage-bar">
        <div class="the-player__manage-tools">
          <i class="the-player__manage-icon the-player__manage-icon_random fas fa-random"></i>
          <i class="the-player__manage-icon fas fa-step-backward"></i>
          <i class="the-player__manage-icon the-player__manage-icon_play fas fa-play fa-lg"></i>
          <i class="the-player__manage-icon fas fa-step-forward"></i>
          <i class="the-player__manage-icon the-player__manage-icon_redo fas fa-redo"></i>
        </div>
        <div class="the-player__manage-time">
          <span class="the-player__manage-time-current">0:00</span>
          <div class="the-player__manage-timeline"></div>
          <span class="the-player__manage-time-duration">90:00</span>
        </div>
      </div>
      <div class="the-player__tools-bar">
        <i class="the-player__tools-bar-icon fas fa-stream"></i>
        <i class="the-player__tools-bar-icon fas fa-volume-up"></i>
        <div class="the-player__tools-bar-volume"></div>
      </div>
    </div>
    <div class="the-player-plugin">
      <the-player-overlay-mobile v-if="isOverlayMobileOpen" @click="overlayMobileToggle()"></the-player-overlay-mobile>
    </div>
  </section>
</template>

<script>
import ThePlayerOverlayMobile from './ThePlayerOverlayMobile.vue'
import AppBannerAuth from './AppBannerAuth.vue'
import { computed, ref } from '@vue/runtime-core'
import { useStore } from 'vuex'
import { usePosition } from '../plugins/hooks'
export default {
  name: 'ThePlayer',
  components: {
    AppBannerAuth,
    ThePlayerOverlayMobile
  },
  setup () {
    const $position = usePosition()
    const store = useStore()
    const isAuth = computed(() => store.getters.isAuth)
    const user = computed(() => store.getters.user)
    const isOverlayMobileOpen = ref(false)
    const overlayMobileToggle = () => {
      if ($position.breakpoint < 3) {
        isOverlayMobileOpen.value = !isOverlayMobileOpen.value
      }
    }
    const author = ref({
      id: 1,
      name: 'Selena',
      surname: 'Gomez'
    })
    const song = ref({
      id: 1,
      playlistId: 1,
      title: 'Rare',
      posterUrl: 'https://i.scdn.co/image/ab67616d000048512abcc266597eb46f897a8666'
    })

    return {
      overlayMobileToggle,
      isOverlayMobileOpen,
      author,
      song,
      isAuth,
      user
    }
  }
}
</script>

<style>
html.user-auth-true {
  --player-height: 50px;
}
html.user-auth-false {
  --player-height: 90px;
}

@media (min-width: 768px) {
  html.user-auth-true {
    --player-height: 90px !important;
  }
}
</style>

<style scoped>
.the-player {
  display: flex;
  border-top: 1px solid var(--the-player-border-color);
  background: var(--the-player-background);
  z-index: 3;
}
.the-player__wrapper {
  width: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.the-player__info-bar {
  min-width: calc(100% / 3);
  display: flex;
  align-items: center;
  padding: 1rem;
  height: 100%;
}
.the-player__poster {
  width: calc(var(--player-height) - 2px - 2rem);
}
.the-player__info-text {
  padding-left: 1rem;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
}
.the-player__title {
  color: var(--the-player-color-hightlight);
  font-weight: 600;
  font-size: 0.8rem;
  text-decoration: none;
}
.the-player__author {
  color: var(--the-player-color);
  font-weight: 600;
  font-size: 0.7rem;
  text-decoration: none;
}
.the-player__like {
  margin-left: 2rem;
  color: var(--the-player-color);
  font-size: 0.95rem;
}
.the-player__manage-bar {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 0.5rem;
  min-width: calc(100% / 3);
}
.the-player__manage-tools {
  display: flex;
  align-items: center;
  padding: 0.5rem;
}
.the-player__manage-icon {
  padding: 0 0.5rem;
  color: var(--the-player-color);
  font-size: 0.95rem;
}
.the-player__manage-icon:hover {
  color: var(--the-player-color-hightlight);
}
.the-player__manage-icon_play {
  margin: 0 0.25rem;
  padding: 0.75rem;
  font-size: 0.85rem;
  border-radius: 3rem;
  color: var(--the-player-play-color);
  background: var(--the-player-play-background);
}
.the-player__manage-icon_play:hover {
  color: var(--the-player-play-color);
  transform: scale(1.05);
}
.the-player__manage-icon_random, .the-player__manage-icon_redo {
  padding: 0 1.25rem;
}
.the-player__manage-time {
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: var(--the-player-color);
}
.the-player__manage-time-current, .the-player__manage-time-duration {
  padding: 0 0.5rem;
  font-weight: 400;
  font-size: 0.65rem;
}
.the-player__manage-timeline {
  width: calc(100% - 1rem);
  height: 5px;
  border-radius: 5px;
  background-color: var(--the-player-line);
}
.the-player__tools-bar {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding: 1rem;
  min-width: calc(100% / 3);
}
.the-player__tools-bar-icon {
  padding: 0 0.5rem;
  color: var(--the-player-color);
  font-size: 0.95rem;
}
.the-player__tools-bar-volume {
  width: calc(20% - 1rem);
  height: 5px;
  border-radius: 5px;
  background-color: var(--the-player-line);
}

@media (max-width: 767.98px) {
  .the-player__manage-bar, .the-player__manage-time, .the-player__tools-bar {
    display: none;
  }
  .the-player__info-bar {
    width: 100%;
  }
  .the-player__poster {
    width: var(--player-height);
  }
  .the-player__info-bar {
    padding: 0.25rem 1.5rem 0.25rem 0;
    display: flex;
    align-items: center;
    flex-direction: row;
  }
  .the-player__info-text {
    padding: 0.75rem 0.5rem;
    display: flex;
    flex-direction: row;
    align-items: center;
  }
  .the-player__author {
    padding-left: 0.5rem;
  }
  .the-player__like {
    margin-left: auto;
  }
  .the-player__title, .the-player__author {
    max-width: 100%;
    display: inline-block;
  }
}
</style>
