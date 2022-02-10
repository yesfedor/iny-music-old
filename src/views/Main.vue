<template>
  <div class="main"></div>
</template>

<script>
import { onMounted } from '@vue/runtime-core'

export default {
  name: 'Main',
  setup () {
    onMounted(() => {
      document.title = 'Main page'
    })
  }
}
</script>
