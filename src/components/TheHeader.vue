<template>
  <header class="the-header"></header>
</template>

<script>
export default {
  name: 'TheHeader'
}
</script>

<style scoped>
.the-header {
  display: flex;
  position: sticky;
  top: 0px;
  background: var(--header-background);
  color: var(--header-color);
  z-index: 3;
}
</style>
