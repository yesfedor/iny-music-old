<template>
  <div class="main"></div>
</template>

<script>
import { onMounted } from '@vue/runtime-core'
import { useRouter } from 'vue-router'

export default {
  name: 'Main',
  setup () {
    const router = useRouter()
    router.push({ name: 'Welcome' })
    onMounted(() => {
      document.title = 'Main page'
    })
  }
}
</script>
