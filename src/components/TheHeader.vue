<template>
  <header class="the-header the-header_background_system">
    <div class="the-header__action">
      <button
        @click="$router.back()"
        :class="(routerStateBack ? '':'the-header__button_disabled')"
        class="the-header__button the-header__button_circle"
        :disabled="(routerStateBack ? false : true)"
      >
        <i class="fas fa-angle-left fa-lg the-header__text"></i>
      </button>
      <button
        @click="$router.forward()"
        :class="(routerStateForward ? '':'the-header__button_disabled')"
        class="the-header__button the-header__button_circle"
        :disabled="(routerStateForward ? false : true)"
      >
        <i class="fas fa-angle-right fa-lg the-header__text"></i>
      </button>
    </div>
    <div v-if="!isAuth" class="the-header__action">
      <button @click="$router.push({ name: 'Signup' })" class="the-header__button the-header__button_text the-header__text the-header__button_scale">Зарегистрироваться</button>
      <button @click="$router.push({ name: 'Signin' })" class="the-header__button the-header__button_fill the-header__button_scale">Войти</button>
    </div>
    <div v-else class="the-header__action the-header__action_user">
      <button @click="logout()" class="the-header__button the-header__button_text the-header__text the-header__button_scale">Выйти</button>
    </div>
  </header>
</template>

<script>
import { computed, onMounted, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { Api } from '../plugins/Auth'

export default {
  name: 'TheHeader',
  setup () {
    // router.options.history.state.back
    const store = useStore()
    const route = useRoute()
    const router = useRouter()
    const routerStateBack = ref(false)
    const routerStateForward = ref(false)
    const isAuth = computed(() => store.getters.isAuth)
    const user = computed(() => store.getters.user)
    const logout = () => {
      Api.logout()
    }

    watch(route, () => {
      routerStateBack.value = router.options.history.state.back
      routerStateForward.value = router.options.history.state.forward
    })

    onMounted(() => {
      routerStateBack.value = router.options.history.state.back
      routerStateForward.value = router.options.history.state.forward
    })

    return {
      logout,
      isAuth,
      user,
      routerStateBack,
      routerStateForward
    }
  }
}
</script>

<style>
:root {
  --header-height: 64px;
}
</style>

<style scoped>
.fa-angle-left {
  padding-left: 0rem;
}
.fa-angle-right {
  padding-left: 0.2rem;
}
.the-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: sticky;
  top: 0px;
  color: var(--header-color);
  z-index: 3;
}
.the-header_background_system {
  background: var(--header-background);
}
.the-header__text {
  color: var(--header-color);
}
.the-header__action {
  margin: 0 1.75rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.the-header__button {
  text-transform: uppercase;
  font-weight: 600;
  font-size: 12px;
  display: block;
  background: transparent;
  border: unset;
}
.the-header__button:first-child {
  margin-right: .75rem;
}
.the-header__button_circle {
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 35px;
  height: 35px;
  border-radius: 100%;
  background: rgba(0, 0, 0, .5);
}
.the-header__button_text {
  padding: 1rem .5rem;
  color: var(--header-color);
}
.the-header__button_fill {
  padding: .7rem 2.5rem;
  border-radius: 1.25rem;
  background: var(--header-color);
  color: var(--header-color-hightlight);
}
.the-header__button_disabled {
  cursor: not-allowed;
}
.the-header__button.the-header__button_disabled > .the-header__text {
  color: var(--layout-main-color-subdued);
}
.the-header__button_scale:hover {
  transform: scale(1.05);
}
</style>
