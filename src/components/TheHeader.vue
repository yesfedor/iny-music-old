<template>
  <header :class="isAuth ? '':'the-header_background_system'" class="the-header">
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
    <div v-else class="the-header__action">
      <button class="the-header__button the-header__button_text the-header__text the-header__button_scale the-header__button_elipse">Сменить тариф</button>
      <div class="dropdown">
        <button class="the-header__button the-header__button_text the-header__text the-header__button_elipse dropdown-toggle" type="button" id="user-dropdown-menu" data-bs-toggle="dropdown" aria-expanded="false">
          <span class="the-header__button-inner">{{ user.name }}</span>
          <span data-expanded="false" class="the-header__button-inner fas fa-angle-down"></span>
          <span data-expanded="true" class="the-header__button-inner fas fa-angle-up"></span>
        </button>
        <ul class="dropdown-menu the-header__dropdown" aria-labelledby="user-dropdown-menu">
          <li class="the-header__dropdown-item">
            <button @click="$router.push({ name: 'Account' })" class="the-header__dropdown-button dropdown-item">Аккаунт</button>
            <button @click="$router.push({ name: 'Profile' })" class="the-header__dropdown-button dropdown-item">Профиль</button>
            <button @click="goIny()" class="the-header__dropdown-button dropdown-item">INY Media</button>
            <button @click="logout()" class="the-header__dropdown-button dropdown-item">Выйти</button>
          </li>
        </ul>
      </div>
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
    const goIny = () => {
      window.open('//iny.su', '_blank')
    }
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
      goIny,
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
.dropdown-toggle:after {
  display: none;
}
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
.the-header__button_elipse {
  margin-left: 1.5rem;
  padding: 0.5rem 1.5rem;
  border: 1px solid var(--layout-main-color-subdued);
  border-radius: 1.5rem;
  background: var(--layout-main-background);
  color: var(--header-color);
}
.the-header__button_elipse[aria-expanded=true] {
  background: var(--header-dropdown-background);
  color: var(--header-dropdown-color);
}
.the-header__button_elipse[aria-expanded=true] .the-header__button-inner[data-expanded=false] {
  display: none;
}
.the-header__button_elipse[aria-expanded=false] .the-header__button-inner[data-expanded=true] {
  display: none;
}
.the-header__dropdown {
  padding: 0.25rem;
  margin-top: 0.25rem !important;
  width: 12rem;
  background: var(--header-dropdown-background);
}
.the-header__dropdown-item {
  background: var(--header-dropdown-background);
}
.the-header__dropdown-button {
  padding: 0.5rem 0.25rem;
  cursor: pointer;
  font-weight: 600;
  font-size: 0.95rem;
  color: var(--header-dropdown-color);
}
.the-header__dropdown-button:hover, .the-header__dropdown-button:focus {
  background: var(--header-dropdown-background-hover);
  color: var(--header-dropdown-color-hover);
}
.the-header__button-inner {
  padding-left: 0.5rem;
  cursor: pointer;
  font-weight: 600;
  color: var(--header-dropdown-color);
}
</style>
