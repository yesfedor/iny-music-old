<template>
  <div class="the-wrapper">
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
