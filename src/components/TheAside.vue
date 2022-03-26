<template>
  <aside class="the-aside">
    <div class="the-aside__wrapper">
      <router-link :to="{ name: 'Main' }" class="the-aside__logo logo">
        <i class="fab fa-spotify logo__icon"></i>
        <span class="logo__text">Music</span>
      </router-link>
      <nav class="the-aside__navbar navbar">
        <div class="navbar__pages">
          <router-link :to="{ name: 'Main' }" :class="$route.name === 'Main' && 'navbar__item_active'" class="navbar__item">
            <i class="navbar__icon fas fa-home"></i>
            <span class="navbar__text text-truncate">Главная</span>
          </router-link>
          <router-link :to="{ name: 'Search' }" :class="$route.name === 'Search' && 'navbar__item_active'" class="navbar__item">
            <i class="navbar__icon fas fa-search"></i>
            <span class="navbar__text text-truncate">Поиск</span>
          </router-link>
          <router-link :to="{ name: 'Collection' }" :class="$route.name === 'Collection' && 'navbar__item_active'" class="navbar__item">
            <i class="navbar__icon fas fa-dice-d20"></i>
            <span class="navbar__text text-truncate">Коллекция</span>
          </router-link>
        </div>
        <div class="navbar__actions">
          <div @click="createPlaylist()" class="navbar__item">
            <i class="navbar__icon fas fa-plus-square"></i>
            <span class="navbar__text text-truncate">Создать плейлист</span>
          </div>
          <router-link :to="{ name: 'CollectionTracks' }" :class="$route.name === 'CollectionTracks' && 'navbar__item_active'" class="navbar__item">
            <i class="navbar__icon fas fa-heart"></i>
            <span class="navbar__text text-truncate">Любимые треки</span>
          </router-link>
        </div>
      </nav>
      <div class="the-aside__playlists playlists">
        <div class="playlists__line"></div>
        <div class="playlists__content"></div>
      </div>
      <div class="the-aside__footer"></div>
      <div class="the-aside__player ratio ratio1x1"></div>
    </div>
    <div class="the-aside__sizer" draggable="true" @drag="sizerDrag" @dragend="sizerDrop"></div>
  </aside>
</template>

<script>
export default {
  name: 'TheAside',
  setup () {
    let asideWidth = localStorage.getItem('asideWidth') || '250px'
    document.documentElement.style.setProperty('--aside-width', asideWidth)

    const createPlaylist = () => {
      // router push on new playlist
    }
    const sizerDrag = (event) => {
      if (event.clientX >= 230 && event.clientX <= 450) {
        asideWidth = event.clientX
        document.documentElement.style.setProperty('--aside-width', asideWidth + 'px')
        localStorage.setItem('asideWidth', event.clientX + 'px')
      }
    }

    return {
      asideWidth,
      sizerDrag,
      createPlaylist
    }
  }
}
</script>

<style>
:root {
  --aside-width: v-bind(asideWidth);
}
</style>

<style scoped>
.the-aside {
  display: flex;
  background-color: var(--aside-background);
  color: var(--aside-color);
  height: 100vh;
}
.the-aside__wrapper {
  padding-left: 1.5rem;
  padding-right: 0.5rem;
  display: flex;
  flex-direction: column;
  width: calc(100% - 3px);
  height: 100%;
}
.the-aside__sizer {
  margin-left: auto;
  width: 4px;
  height: 100%;
  background: var(--aside-background);
  cursor: col-resize;
  user-select: none;
}
.the-aside__sizer:hover {
  background: var(--aside-color-hightlight);
}
.the-aside__logo {
  display: flex;
  align-items: flex-end;
  justify-content: flex-start;
  height: var(--header-height);
}
.logo {
  text-decoration: none;
}
.logo__icon {
  display: inline;
  font-size: 2.5rem;
  color: var(--aside-logo-color);
}
.logo__text {
  display: inline;
  padding-left: 0.25rem;
  color: var(--aside-logo-color);
  font-weight: 600;
  font-size: 1.65rem;
}
.the-aside__navbar {
  margin-top: 1.15rem;
  display: block;
}
.navbar__pages {
  display: block;
  margin-bottom: 1.2rem;
}
.navbar__actions {
  display: block;
}
.navbar__item {
  cursor: pointer;
  padding: 0.6rem 0rem;
  display: flex;
  align-items: center;
  text-decoration: none;
}
.navbar__icon {
  display: block;
  font-size: 1.35rem;
  color: var(--aside-color);
  transition: color 500ms;
}
.navbar__text {
  display: block;
  padding-left: 1.25rem;
  font-weight: 600;
  font-size: 0.90rem;
  color: var(--aside-color);
  transition: color 500ms;
}
.navbar__item:hover > .navbar__icon {
  color: var(--aside-color-hightlight);
}
.navbar__item:hover > .navbar__text {
  color: var(--aside-color-hightlight);
}
.navbar__item_active > .navbar__icon {
  color: var(--aside-color-hightlight);
}
.navbar__item_active > .navbar__text {
  color: var(--aside-color-hightlight);
}
.the-aside__playlists {
  margin-top: 3rem;
  max-height: 40vh;
  overflow-y: scroll;
  display: block;
}
.the-aside__footer {
  margin-top: auto;
  display: block;
}
.the-aside__player {
  margin-top: auto;
  display: block;
}
</style>
