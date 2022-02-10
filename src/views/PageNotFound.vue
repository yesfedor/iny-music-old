<template>
  <div class="page-not-found"></div>
</template>

<script>
import { onMounted } from '@vue/runtime-core'

export default {
  name: 'PageNotFound',
  setup () {
    onMounted(() => {
      document.title = 'PageNotFound page'
    })
  }
}
</script>
