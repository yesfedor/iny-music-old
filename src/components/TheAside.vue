<template>
  <aside class="the-aside">
    <div class="the-aside__wrapper"></div>
  </aside>
</template>

<script>
export default {
  name: 'TheAside'
}
</script>

<style scoped>
.the-aside {
  display: block;
  background-color: var(--aside-background);
  color: var(--aside-color);
}
.the-aside__wrapper {
  display: flex;
  height: 100%;
}
</style>
