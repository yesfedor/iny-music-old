<template>
  <div v-if="$progress.options.isPreloader" class="progress-preloader">
    <span class="progress-preloader__title">Title Loader</span>
    <span class="progress-preloader__subtitle">in ./src/Progress/ProgressPreloader.vue</span>
  </div>
</template>

<script>
export default {
  name: 'ProgressPreloader'
}
</script>

<style scoped>
.progress-preloader {
  width: 100vw;
  height: 100vh;
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: var(--progress-preloader-background);
  z-index: 10000;
}
.progress-preloader__title {
  margin: 0;
  padding: 0em 0.5em;
  display: block;
  color: var(--progress-preloader-title-color);
  font-size: xx-large;
  font-weight: bolder;
}
.progress-preloader__subtitle {
  margin: 0;
  padding: 0.25em 0.5em;
  display: block;
  color: var(--progress-preloader-subtitle-color);
  font-size: large;
  font-weight: bolder;
}
</style>
