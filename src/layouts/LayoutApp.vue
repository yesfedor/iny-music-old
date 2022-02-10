<template>
  <div class="layout">
    <progress-preloader></progress-preloader>
    <progress-line></progress-line>
    <div class="layout__transport"></div>
    <component :is="component"></component>
  </div>
</template>

<script>
import { ref } from '@vue/reactivity'
import { useRoute } from 'vue-router'
import { onMounted, watch } from '@vue/runtime-core'
import LayoutMain from './LayoutMain.vue'
import ProgressLine from '../plugins/Progress/ProgressLine.vue'
import ProgressPreloader from '../plugins/Progress/ProgressPreloader.vue'

export default {
  name: 'LayoutApp',
  components: {
    LayoutMain,
    ProgressLine,
    ProgressPreloader
  },
  setup () {
    const route = useRoute()
    const component = ref(null)
    const onComponentChange = () => {
      component.value = route.meta.layout
    }

    onMounted(() => {
      onComponentChange()
    })

    watch(route, () => {
      onComponentChange()
    })

    return {
      component
    }
  }
}
</script>
