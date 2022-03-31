<template>
  <div class="layout">
    <progress-preloader></progress-preloader>
    <progress-line></progress-line>
    <div class="layout__transport"></div>
    <context-menu-base></context-menu-base>
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
import { useStore } from 'vuex'

export default {
  name: 'LayoutApp',
  components: {
    LayoutMain,
    LayoutClear
  },
  setup () {
    const store = useStore()
    const auth = useAuth()
    auth.install(1, {
      routerPush: (routeName, routeReason) => {},
      storeCommit: (what, payload) => {
        if ((what === 'login' || what === 'register') && typeof payload === 'object' && payload.uid) {
          document.documentElement.classList.remove('user-auth-false')
          document.documentElement.classList.add('user-auth-true')
          store.commit('auth:true', payload)
        }
        if (what === 'logout') {
          document.documentElement.classList.remove('user-auth-true')
          document.documentElement.classList.add('user-auth-false')
          store.commit('auth:false')
        }
      }
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
