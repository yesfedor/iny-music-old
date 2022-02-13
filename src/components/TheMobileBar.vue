<template>
  <section class="the-mobile-bar">
    <router-link :to="{ name: 'Main' }" :class="$route.name === 'Main' ? 'the-mobile-bar__item_active' : ''" class="the-mobile-bar__item">
      <i class="the-mobile-bar__icon fas fa-home"></i>
      <span class="the-mobile-bar__text">Главная</span>
    </router-link>
    <router-link :to="{ name: 'Search' }" :class="$route.name === 'Search' ? 'the-mobile-bar__item_active' : ''" class="the-mobile-bar__item">
      <i class="the-mobile-bar__icon fas fa-search"></i>
      <span class="the-mobile-bar__text">Поиск</span>
    </router-link>
    <router-link :to="{ name: 'Collection' }" :class="$route.name === 'Collection' ? 'the-mobile-bar__item_active' : ''" class="the-mobile-bar__item">
      <i class="the-mobile-bar__icon fas fa-dice-d20"></i>
      <span class="the-mobile-bar__text">Коллекция</span>
    </router-link>
    <a href="//iny.su" target="_blank" class="the-mobile-bar__item">
      <i class="the-mobile-bar__icon fas fa-video"></i>
      <span class="the-mobile-bar__text">INY Media</span>
    </a>
  </section>
</template>

<script>
export default {
  name: 'TheMobileBar'
}
</script>

<style>
html {
  --mobile-bar-height: 50px;
}
</style>

<style scoped>
.the-mobile-bar {
  padding: 0.65rem;
  border-top: 1px solid var(--mobile-menu-border-color);
  width: 100%;
  height: var(--mobile-bar-height);
  display: flex;
  flex-direction: row;
  justify-content: space-around;
  background-color: var(--mobile-menu-background);
}
.the-mobile-bar__item {
  text-decoration: none;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.the-mobile-bar__icon {
  font-weight: 600;
  font-size: 1rem;
  color: var(--mobile-menu-color);
}
.the-mobile-bar__text {
  margin-top: 0.2rem;
  font-weight: 400;
  font-size: 0.65rem;
  color: var(--mobile-menu-color);
}
.the-mobile-bar__item_active .the-mobile-bar__icon, .the-mobile-bar__item_active .the-mobile-bar__text {
  color: var(--mobile-menu-color-hightlight);
}
</style>
