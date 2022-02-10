<template>
  <div class="the-wrapper">
    <div class="the-wrapper__colorfull"></div>
    <main class="the-wrapper__content">
      <router-view
        :class="['the-wrapper__page', 'the-wrapper__page_' + pageClassPrefix ]"
      ></router-view>
    </main>
  </div>
</template>

<script>
import { useRoute } from 'vue-router'

export default {
  name: 'TheWrapper',
  setup () {
    const route = useRoute()
    const pageClassPrefix = route.name.toLowerCase()

    return {
      pageClassPrefix
    }
  }
}
</script>

<style scoped>
.the-wrapper {
  width: 100%;
}
.the-wrapper__colorfull {
  display: block;
  height: calc(var(--header-height) * var(--layout-wrapper-colorfull-ratio));
  background: var(--layout-wrapper-colorfull);
  background: var(--layout-wrapper-colorfull-gradient);
  background-position: 0 0;
  background-size: 100% 140%;
  background-position: 0 100%;
}
.the-wrapper__content {
  margin-top: calc(-1 * var(--header-height) * var(--layout-wrapper-colorfull-ratio));
  padding-top: calc(var(--header-height) + var(--layout-wrapper-spacer-top));
  padding-left: var(--layout-wrapper-spacer-top);
  padding-right: var(--layout-wrapper-spacer-top);
  padding-bottom: var(--header-height);
}
</style>
