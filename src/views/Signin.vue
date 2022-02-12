<template>
  <div class="row justify-content-center text-start signin">
    <div class="col-12 col-md-10 col-lg-8 col-xl-6 col-xxl-4">
      <div class="row">
        <router-link :to="{ name: 'Main' }" class="col-12 signin__logo">
          <i class="signin__logo-icon fab fa-spotify"></i>
          <span class="signin__logo-text">Music</span>
        </router-link>
        <div class="col-12 signin__spacer"></div>
        <div class="col-12">
          <b class="signin__reason">Чтобы продолжить, войдите в Spotify.</b>
        </div>
        <form @submit.prevent class="col-12 signin__form">
          <div class="row signin-form">
            <div class="col-12 signin-form__item">
              <label class="signin-form__label" for="signin-form-email">Эл. почта</label>
              <input class="signin-form__input" type="email" id="signin-form-email" v-model="email">
            </div>
            <div class="col-12 signin-form__item">
              <label class="signin-form__label" for="signin-form-password">Пароль</label>
              <input class="signin-form__input" type="password" id="signin-form-password" v-model="password">
            </div>
            <div class="col-12 signin-form__item signin-form__item_actions">
              <span class="signin-form__restore">Не помню пароль</span>
              <button @click.prevent="login()" class="signin-form__submit">Войти</button>
            </div>
            <div v-show="apiError" class="col-12 signin-form__item">
              <span class="signin-form__label_help">{{apiError}}</span>
            </div>
          </div>
        </form>
        <div class="col-12">
          <hr class="signin__hr">
        </div>
        <div class="col-12 signin__another">
          <span class="signin__another-text">Нет аккаунта?</span>
          <router-link v-if="$route.query.redirectUrl" :to="{ name: 'Signup', query: { redirectUrl: ($route.query.redirectUrl) }}" class="signin__another-button">Регистрация в Music</router-link>
          <router-link v-else :to="{ name: 'Signup' }" class="signin__another-button">Регистрация в Music</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from '@vue/reactivity'
import { Api } from '../plugins/Auth'
import { useStore } from 'vuex'
import { computed, watch } from '@vue/runtime-core'
import { useRoute, useRouter } from 'vue-router'
import AuthHandler from '../plugins/Auth/handler'
export default {
  name: 'Signin',
  setup () {
    const route = useRoute()
    const router = useRouter()
    const store = useStore()
    const isAuth = computed(() => store.getters.isAuth)
    const email = ref('')
    const password = ref('')
    const apiError = ref('')

    const login = () => {
      apiError.value = ''
      const queryUrl = route.query?.redirectUrl
      if (!email.value || !password.value) {
        apiError.value = 'Заполните все поля'
        return false
      }
      Api.login(email.value, password.value).then(response => {
        if (response.uid) {
          if (queryUrl) router.push(queryUrl)
          else router.push({ name: 'Main' })
        } else {
          apiError.value = AuthHandler(response.status)
        }
      })
    }

    watch(isAuth, () => {
      if (isAuth.value) router.push({ name: 'Main' })
    })

    return {
      apiError,
      email,
      password,
      login
    }
  }
}
</script>

<style scoped>
.signin {
  display: flex;
  margin-bottom: 3rem;
}
.signin__logo {
  margin: 1.25rem 0;
  display: flex;
  align-items: center;
  justify-content: center;
  text-decoration: none;
}
.signin__logo-icon {
  display: block;
  color: black;
  font-size: 3.5rem;
}
.signin__logo-text {
  display: block;
  margin-left: 0.5rem;
  color: black;
  font-size: 2.5rem;
  font-weight: 600;
  letter-spacing: -2px;
}

.signin__spacer {
  content: " ";
  display: block;
  margin-bottom: 2.5rem;
}
.signin__spacer::after {
  content: " ";
  position: absolute;
  left: 0;
  right: 0;
  border-top: 1px solid #d9dadc;
}

.signin__reason {
  display: block;
  text-align: center;
  font-weight: 800;
  font-size: 0.85rem;
  letter-spacing: 0px;
  color: black;
}

.signin__form {
  margin-top: 2.25rem;
}
.signin-form {
  display: block;
}
.signin-form__item {
  display: grid;
  grid-template-areas: "form-label" "form-input" "form-label-help";
  margin-bottom: 1.15rem;
}
.signin-form__item_actions {
  margin-top: 2.25rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.signin-form__label {
  font-weight: 800;
  font-size: 0.85rem;
  margin-bottom: 0.25rem;
  grid-area: form-label;
}
.signin-form__label_help {
  display: block;
  grid-area: form-label-help;
  font-weight: 400;
  margin-top: 0.25rem;
  margin-bottom: 0rem;
  text-align: right;
  color: red;
}
.signin-form__input {
  padding: 0.25rem;
  font-weight: 600;
  font-size: 1rem;
  border: 1px solid #000000;
  border-radius: 0.25rem;
  min-height: 2.25rem;
}
.signin-form__input:focus {
  outline: var(--color-primary) solid 3px;
}
.signin-form__submit {
  outline: none;
  border: unset;
  border-radius: 1.5rem;
  padding: .75rem 1.8rem;
  color: black;
  font-size: 0.85rem;
  font-weight: 600;
  text-transform: uppercase;
  background: var(--color-primary);
}
.signin-form__submit:hover {
  transform: scale(1.05);
}
.signin__hr {
  height: 2px;
  margin-top: 1.5rem;
  margin-bottom: 2.25rem;
}
.signin__another-text {
  display: block;
  text-align: center;
  font-weight: 800;
  font-size: 1.1rem;
  margin-bottom: 1.75rem;
}
.signin__another-button {
  width: 100%;
  display: block;
  outline: none;
  background: unset;
  text-align: center;
  border: 1px solid var(--layout-main-color-subdued);
  border-radius: 4rem;
  padding: 1rem 0;
  color: var(--layout-main-color-subdued);
  font-size: 0.85rem;
  font-weight: 800;
  text-transform: uppercase;
  text-decoration: none;
}
.signin__another-button:hover {
  border-color: #000000;
}
.signin-form__restore {
  cursor: pointer;
  color: #000000;
  font-weight: 600;
  font-size: 0.85rem;
}
</style>
