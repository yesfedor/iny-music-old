<template>
  <main class="the-wrapper">
    <div class="the-wrapper__colorfull"></div>
    <section class="the-wrapper__content">
      <router-view
        :class="['the-wrapper__page', 'the-wrapper__page_' + pageClassPrefix ]"
      ></router-view>
    </section>
  </main>
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
  background-size: 100% 100%;
  background-position: 0 100%;
}
.the-wrapper__content {
  margin-top: calc(-1 * var(--header-height) * var(--layout-wrapper-colorfull-ratio));
  padding: calc(var(--header-height) + var(--layout-wrapper-spacer-top)) var(--layout-wrapper-spacer-top) var(--layout-wrapper-spacer-top) var(--layout-wrapper-spacer-top);
  min-height: 100%;
}
</style>
