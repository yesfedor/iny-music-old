<template>
  <div class="layout">
    <progress-preloader></progress-preloader>
    <progress-line></progress-line>
    <div class="layout__transport"></div>
    <component :is="component"></component>
  </div>
</template>

<script>
import LayoutMain from './LayoutMain.vue'
import LayoutClear from './LayoutClear.vue'
import { ref } from '@vue/reactivity'
import { useRoute } from 'vue-router'
import { onMounted, watch } from '@vue/runtime-core'
import { useAuth } from '../plugins/Auth'

export default {
  name: 'LayoutApp',
  components: {
    LayoutMain,
    LayoutClear
  },
  setup () {
    const auth = useAuth()
    auth.install(1, {
      routerPush: (routeName, routeReason) => {},
      storeCommit: (what, payload) => {}
    }).mounted()

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
