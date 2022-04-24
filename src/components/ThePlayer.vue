<template>
  <section :class="{'the-player_disabled': !isPlayerActive}" class="the-player">
    <app-banner-auth v-if="!isAuth" class="the-player__banner"></app-banner-auth>
    <div v-else class="the-player__wrapper">
      <div class="the-player__info-bar" @click="overlayMobileToggle()">
        <img class="the-player__poster ratio ration1x1" :src="playerApi.state.songQueueCurrent.img_1024">
        <div class="the-player__info-text">
          <router-link
            :to="{ name: 'Playlist', params: { playlistId: 1 }}"
            class="the-player__title text-truncate"
            @click.stop
          >
            {{ playerApi.state.songQueueCurrent.title }}
            <span v-show="playerApi.state.songQueueCurrent.subtitle" class="the-player__subtitle">
              {{ playerApi.state.songQueueCurrent.subtitle }}
            </span>
          </router-link>
          <router-link
            :to="{ name: 'Artist', params: { artistId: playerApi.state.songQueueCurrent.artist.aid }}"
            class="the-player__author text-truncate"
            @click.stop
          >
            {{ authorTitle }}
          </router-link>
        </div>
        <i class="the-player__like far fa-heart"></i>
      </div>
      <div class="the-player__manage-bar">
        <div class="the-player__manage-tools">
          <i class="the-player__manage-icon the-player__manage-icon_random fas fa-random"></i>
          <i class="the-player__manage-icon fas fa-step-backward"></i>
          <i
            class="the-player__manage-icon the-player__manage-icon_play fas fa-lg"
            :class="playerApi.playerState ? playerApi.playerIcon.play : playerApi.playerIcon.pause"
            @click="playerApi.togglePlay()"
          />
          <i class="the-player__manage-icon fas fa-step-forward"></i>
          <i class="the-player__manage-icon the-player__manage-icon_redo fas fa-redo"></i>
        </div>
        <div class="the-player__manage-time">
          <span class="the-player__manage-time-current">{{ songFormatedTime }}</span>
          <div @click="timelineClick" class="the-player__manage-timeline"></div>
          <span class="the-player__manage-time-duration">{{ songFormatedDuration }}</span>
        </div>
      </div>
      <div class="the-player__tools-bar">
        <i class="the-player__tools-bar-icon fas fa-stream"></i>
        <i class="the-player__tools-bar-icon fas fa-volume-up"></i>
        <input
          type="range"
          min="0"
          max="100"
          step="1"
          class="the-player__tools-bar-volume"
          :value="timelineVolume.slice(0, -1)"
          @change="volumeChange"
          @wheel="volumeWheel"
        />
      </div>
    </div>
    <div class="the-player-plugin">
      <the-player-overlay-mobile v-if="isOverlayMobileOpen" @click="overlayMobileToggle()"></the-player-overlay-mobile>
    </div>
  </section>
</template>

<script>
import { songPrettyTime } from '../utils/song/song'
import { useStore } from 'vuex'
import { usePosition } from '../plugins/hooks'
import ThePlayerOverlayMobile from './ThePlayerOverlayMobile.vue'
import AppBannerAuth from './AppBannerAuth.vue'
import { computed, ref, watch } from '@vue/runtime-core'
import usePlayerApi from '../plugins/Player'

export default {
  name: 'ThePlayer',
  components: {
    AppBannerAuth,
    ThePlayerOverlayMobile
  },
  setup () {
    const isPlayerActive = ref(0)
    const $position = usePosition()
    const store = useStore()
    const isAuth = computed(() => store.getters.isAuth)
    const user = computed(() => store.getters.user)

    const isOverlayMobileOpen = ref(false)

    const computedWidthLine = (time, duration) => {
      return (time / duration * 100).toFixed(2) + '%'
    }

    const overlayMobileToggle = () => {
      if ($position.breakpoint < 3) {
        isOverlayMobileOpen.value = !isOverlayMobileOpen.value
      }
    }

    const playerApi = usePlayerApi()
    playerApi.initial()

    const playerState = computed(() => playerApi.state)
    const songFormatedTime = computed(() => songPrettyTime(playerApi.state.songQueueCurrent.time))
    const songFormatedDuration = computed(() => songPrettyTime(playerApi.state.songQueueCurrent.duration))
    const authorTitle = computed(() => {
      return playerApi.state.songQueueCurrent.artist.altname
        ? playerApi.state.songQueueCurrent.artist.altname
        : playerApi.state.songQueueCurrent.artist.name + ' ' + playerApi.state.songQueueCurrent.artist.surname
    })
    const timelineDuration = computed(() => computedWidthLine(playerApi.state.songQueueCurrent.time, playerApi.state.songQueueCurrent.duration))
    const timelineVolume = computed(() => computedWidthLine(playerApi.state.settings.player_volume, 100))

    const timelineClick = (event) => {
      const lineWidth = event.srcElement.offsetWidth
      const clickWidth = event.offsetX
      const clickPersent = clickWidth / lineWidth
      const timeline = playerApi.state.songQueueCurrent.duration * clickPersent
      playerApi.playerSetCurrentTime(timeline)
    }

    const volumeChange = (event) => playerApi.volumeChange(event.target.value)

    const volumeWheel = (event) => {
      const setVolume = (volumeOffset) => {
        if (volumeOffset > 100) return 100
        if (volumeOffset < 0) return 0
        return volumeOffset
      }
      const step = 5

      let volume = playerApi.state.settings.player_volume
      if (event.deltaY > 0) {
        volume = setVolume(volume - step)
      } else {
        volume = setVolume(volume + step)
      }

      playerApi.volumeChange(volume)
    }

    watch(playerApi.state, (state) => {
      if (state.songQueueCurrent.id) {
        isPlayerActive.value = 1
      } else {
        isPlayerActive.value = 0
      }
    })

    return {
      volumeChange,
      volumeWheel,
      timelineClick,
      timelineDuration,
      timelineVolume,
      songFormatedTime,
      songFormatedDuration,
      authorTitle,
      playerState,
      playerApi,
      isPlayerActive,
      overlayMobileToggle,
      isOverlayMobileOpen,
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
  --the-player-time-width: v-bind(timelineDuration);
  --the-player-volume-width: v-bind(timelineVolume);
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
.the-player__subtitle {
  color: var(--the-player-color);
}
.the-player__author {
  color: var(--the-player-color);
  font-weight: 600;
  font-size: 0.7rem;
  text-decoration: none;
}
.the-player__author:hover {
  text-decoration: underline;
  color: var(--the-player-color-hightlight);
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
  min-width: 40px;
  padding: 0 0.5rem;
  font-weight: 400;
  font-size: 0.65rem;
}
.the-player__manage-timeline {
  width: calc(100% - 1rem);
  height: 5px;
  border-radius: 5px;
  background-color: var(--the-player-line);
  user-select: none;
}

.the-player__manage-timeline {
  width: calc(100% - 1rem);
  position: relative;
  height: 5px;
  border-radius: 5px;
  background-color: var(--the-player-line);
}
.the-player__manage-timeline::before {
  width: var(--the-player-time-width);
  content: " ";
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  border-radius: 5px;
  background-color: var(--the-player-color);
}
.the-player__manage-timeline:hover::before {
  background-color: var(--the-player-primary);
}
.the-player__manage-timeline::after {
  opacity: 0;
  margin-left: calc(var(--the-player-time-width) - 6px);
  content: " ";
  position: absolute;
  left: 0;
  top: -4px;
  bottom: 0;
  height: 12px;
  width: 12px;
  border-radius: 200%;
  background-color: var(--the-player-color-hightlight);
  -webkit-user-drag: element;
}
.the-player__manage-timeline:hover::after {
  opacity: 1;
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
  -webkit-appearance: none;
  position: relative;
  width: calc(20% - 1rem);
  min-width: 80px;
  height: 4px;
  border-radius: 6px;
  background-color: var(--the-player-line);
}
.the-player__tools-bar-volume::-webkit-slider-thumb {
  -webkit-appearance: none;
  position: relative;
  left: 0;
  bottom: 0;
  height: 12px;
  width: 12px;
  border-radius: 200%;
  background-color: var(--the-player-color-hightlight);
  opacity: 1;
  z-index: 1;
}
.the-player__tools-bar-volume::before {
  width: var(--the-player-volume-width);
  content: " ";
  position: absolute;
  left: 0;
  top: 0;
  bottom: 0;
  border-radius: 5px;
  background-color: var(--the-player-color);
}
.the-player__tools-bar-volume:hover::before {
  background-color: var(--the-player-primary);
}

.the-player_disabled .the-player__title,
.the-player_disabled .the-player__author,
.the-player_disabled .the-player__like,
.the-player_disabled .the-player__manage-time-current,
.the-player_disabled .the-player__manage-time-duration {
  opacity: 0;
}

@media (max-width: 767.98px) {
  .the-player__manage-bar, .the-player__manage-time, .the-player__tools-bar {
    display: none;
  }
  .the-player__info-bar {
    width: 100%;
  }
  .the-player__poster {
    width: calc(var(--player-height) - 2.5px);
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
