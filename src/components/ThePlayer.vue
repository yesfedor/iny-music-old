<template>
  <section class="the-player"></section>
</template>

<script>
export default {
  name: 'ThePlayer'
}
</script>

<style scoped>
.the-player {
  display: grid;
  border-top: 1px solid var(--the-player-border-color);
  background: var(--the-player-background);
  z-index: 3;
}
</style>
