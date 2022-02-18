<template>
  <div class="the-player-overlay-mobile">
    <div class="the-player-overlay-mobile__header">
      asd
    </div>
    <div class="the-player-overlay-mobile__poster">
      asd
    </div>
    <div class="the-player-overlay-mobile__text">
      asd
    </div>
    <div class="the-player-overlay-mobile__tools">
      asd
    </div>
    <div class="the-player-overlay-mobile__actions">
      asd
    </div>
  </div>
</template>

<script>
export default {
  name: 'ThePlayerOverlayMobile',
  setup () {}
}
</script>

<style scoped>
.the-player-overlay-mobile {
  display: grid;
  grid-template-areas: "player-overlay-header" "player-overlay-poster" "player-overlay-text" "player-overlay-tools" "player-overlay-actions";
  position: absolute;
  width: 100vw;
  height: 100vh;
  left: 0;
  bottom: 0;
  background: var(--the-player-overlay-mobile-background);
  backdrop-filter: blur(4px);
  border-bottom: var(--the-player-border-color) solid 1px;
}

.the-player-overlay-mobile__header {
  padding-top: calc(var(--mobile-bar-height));
  width: 100%;
  display: flex;
  grid-area: player-overlay-header;
}

.the-player-overlay-mobile__poster {
  width: 100%;
  display: flex;
  grid-area: player-overlay-poster;
}

.the-player-overlay-mobile__text {
  width: 100%;
  display: flex;
  grid-area: player-overlay-text;
}

.the-player-overlay-mobile__tools {
  width: 100%;
  display: flex;
  grid-area: player-overlay-tools;
}

.the-player-overlay-mobile__actions {
  width: 100%;
  display: flex;
  grid-area: player-overlay-actions;
}

@media (max-width: 767.98px) {
  .the-player-overlay-mobile {
    bottom: -1px;
  }
}
</style>
