<template>
  <div @click="$router.push({ name: 'Signup' })" class="app-banner-auth">
    <div class="app-banner-auth__paragraph">
      <span class="app-banner-auth__text app-banner-auth__text_title">Предварительный просмотр Music</span>
      <span class="app-banner-auth__text">
        Зарегистрируйся, чтобы слушать музыку без ограничений.<br> Иногда мы будем показывать рекламу, но ты сможешь пользоваться сервисом бесплатно!
      </span>
    </div>
    <button class="app-banner-auth__action">Зарегистрироваться</button>
  </div>
</template>

<script>
export default {
  name: 'AppBannerAuth'
}
</script>

<style scoped>
.app-banner-auth {
  cursor: pointer;
  padding: .65rem 1.5rem;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg,#af2896,#509bf5);
}
.app-banner-auth__paragraph {
  display: block;
}
.app-banner-auth__text {
  display: block;
  font-weight: 400;
  font-size: 0.85rem;
  color: #ffffff;
}
.app-banner-auth__text_title {
  font-size: .85rem;
  text-transform: uppercase;
}
.app-banner-auth__action {
  padding: 0.5rem 2.45rem;
  font-weight: 800;
  font-size: 0.9rem;
  text-transform: uppercase;
  display: block;
  outline: none;
  border: unset;
  border-radius: 3rem;
  color: #509bf5;
  background: #ffffff;
}
</style>
