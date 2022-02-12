<template>
  <div class="row justify-content-center text-start signup">
    <div class="col-12 col-md-10 col-lg-8 col-xl-6 col-xxl-4">
      <div class="row">
        <router-link :to="{ name: 'Main' }" class="col-12 signup__logo">
          <i class="signup__logo-icon fab fa-spotify"></i>
          <span class="signup__logo-text">Music</span>
        </router-link>
        <div class="col-12 signup__spacer"></div>
        <div class="col-12">
          <b class="signup__reason">Зарегистрируйтесь и слушайте бесплатно</b>
        </div>
        <form @submit.prevent class="col-12 signup__form">
          <div class="row signup-form">
            <div class="col-12 signup-form__item">
              <label class="signup-form__label" for="signup-form-name">Ваше имя</label>
              <input class="signup-form__input" type="text" id="signup-form-name" v-model="name">
              <label class="signup-form__label signup-form__label_help" for="signup-form-name">Оно появится в вашем профиле.</label>
            </div>
            <div class="col-12 signup-form__item">
              <label class="signup-form__label" for="signup-form-surname">Ваша фамилия</label>
              <input class="signup-form__input" type="text" id="signup-form-surname" v-model="surname">
            </div>
            <div class="col-12 signup-form__item">
              <label class="signup-form__label" for="signup-form-email">Эл. почта</label>
              <input class="signup-form__input" type="email" id="signup-form-email" v-model="email">
            </div>
            <div class="col-12 signup-form__item">
              <label class="signup-form__label" for="signup-form-password">Придумайте пароль</label>
              <input class="signup-form__input" type="password" id="signup-form-password" v-model="password">
            </div>
            <div class="col-12 signup-form__item">
              <label class="signup-form__label" for="signup-form-password-repeat">Повторите пароль</label>
              <input class="signup-form__input" type="password" id="signup-form-password-repeat" v-model="passwordRepeat">
            </div>
            <div class="col-12 signup-form__item signup-form__item_line">
              <label class="signup-form__label signup-form__space-1" for="signup-form-gender-male">Я мужчина</label>
              <input class="signup-form__input signup-form__space-2" type="radio" name="gender" value="male" id="signup-form-gender-male" v-model="gender">
              <label class="signup-form__label signup-form__space-1" for="signup-form-gender-female">Я Женщина</label>
              <input class="signup-form__input signup-form__space-1" type="radio" name="gender" value="female" id="signup-form-gender-female" v-model="gender">
            </div>
            <div class="col-12 signup-form__item signup-form__item_actions">
              <span class="signup-form__restore">Мои данные</span>
              <button @click.prevent="register()" class="signup-form__submit">Зарегистрироваться</button>
            </div>
            <div v-show="apiError" class="col-12 signup-form__item">
              <span class="signup-form__label_error">{{ apiError }}</span>
            </div>
          </div>
        </form>
        <div class="col-12">
          <hr class="signup__hr">
        </div>
        <div class="col-12 signup__another">
          <span class="signup__another-text">Уже есть аккаунт?</span>
          <router-link v-if="$route.query.redirectUrl" :to="{ name: 'Signin', query: { redirectUrl: ($route.query.redirectUrl) }}" class="signup__another-button">Войти</router-link>
          <router-link v-else :to="{ name: 'Signin' }" class="signup__another-button">Войти</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import AuthHandler from '../plugins/Auth/handler'
import { computed, ref, watch } from '@vue/runtime-core'
import { useRoute, useRouter } from 'vue-router'
import { useStore } from 'vuex'
import { Api } from '../plugins/Auth'
export default {
  name: 'Signup',
  setup () {
    const route = useRoute()
    const router = useRouter()
    const store = useStore()
    const isAuth = computed(() => store.getters.isAuth)

    const name = ref('')
    const surname = ref('')
    const email = ref('')
    const gender = ref('')
    const password = ref('')
    const passwordRepeat = ref('')
    const apiError = ref('')

    const register = () => {
      apiError.value = ''
      const queryUrl = route.query?.redirectUrl
      if (name.value.length > 2 && surname.value.length > 2 &&
         (gender.value === 'male' || gender.value === 'female') &&
         email.value.length >= 5 && password.value.length > 6 &&
         password.value === passwordRepeat.value) {
        Api.register(name.value, surname.value, email.value, gender.value, password.value).then(response => {
          if (response.uid) {
            if (queryUrl) router.push(queryUrl)
            else router.push({ name: 'Main' })
          } else {
            apiError.value = AuthHandler(response.status)
          }
        })
      } else {
        apiError.value = 'Заполните все поля'
      }
    }
    watch(isAuth, () => {
      if (isAuth.value) router.push({ name: 'Main' })
    })

    return {
      apiError,
      name,
      surname,
      email,
      gender,
      password,
      passwordRepeat,
      register
    }
  }
}
</script>

<style scoped>
.signup {
  display: flex;
  margin-bottom: 3rem;
}
.signup__logo {
  margin: 1.25rem 0;
  display: flex;
  align-items: center;
  justify-content: center;
  text-decoration: none;
}
.signup__logo-icon {
  display: block;
  color: black;
  font-size: 3.5rem;
}
.signup__logo-text {
  display: block;
  margin-left: 0.5rem;
  color: black;
  font-size: 2.5rem;
  font-weight: 600;
  letter-spacing: -2px;
}

.signup__spacer {
  content: " ";
  display: block;
  margin-bottom: 2.5rem;
}
.signup__spacer::after {
  content: " ";
  position: absolute;
  left: 0;
  right: 0;
  border-top: 1px solid #d9dadc;
}

.signup__reason {
  display: block;
  text-align: center;
  font-weight: 800;
  font-size: 1.5rem;
  letter-spacing: 0px;
  color: black;
}

.signup__form {
  margin-top: 2.25rem;
}
.signup-form {
  display: block;
}
.signup-form__item {
  display: grid;
  grid-template-areas: "form-label" "form-input" "form-label-help";
  margin-bottom: 1.15rem;
}
.signup-form__item_line {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
}
.signup-form__item_actions {
  margin-top: 2.25rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.signup-form__label {
  font-weight: 800;
  font-size: 0.85rem;
  margin-bottom: 0.25rem;
  grid-area: form-label;
}
.signup-form__label_help {
  grid-area: form-label-help;
  font-weight: 400;
  margin-top: 0.25rem;
  margin-bottom: 0rem;
}
.signup-form__label_error {
  display: block;
  text-align: right;
  grid-area: form-label-help;
  font-weight: 400;
  margin-top: 0.25rem;
  margin-bottom: 0rem;
  color: red;
}
.signup-form__input {
  padding: 0.25rem;
  font-weight: 600;
  font-size: 1rem;
  border: 1px solid #000000;
  border-radius: 0.25rem;
  min-height: 2.25rem;
}
.signup-form__input:focus {
  outline: var(--color-primary) solid 3px;
}
.signup-form__submit {
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
.signup-form__submit:hover {
  transform: scale(1.05);
}
.signup__hr {
  height: 2px;
  margin-top: 1.5rem;
  margin-bottom: 2.25rem;
}
.signup__another-text {
  display: block;
  text-align: center;
  font-weight: 800;
  font-size: 1.1rem;
  margin-bottom: 1.75rem;
}
.signup__another-button {
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
.signup__another-button:hover {
  border-color: #000000;
}
.signup-form__restore {
  cursor: pointer;
  color: #000000;
  font-weight: 600;
  font-size: 0.85rem;
}
.signup-form__space-1 {
  margin-right: 0.5rem;
}
.signup-form__space-2 {
  margin-right: 0.75rem;
}
</style>
