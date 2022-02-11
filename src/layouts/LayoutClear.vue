<template>
  <div class="layout__clear">
    <div class="container">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
export default {
  name: 'LayoutClear'
}
</script>

<style scoped>
.layout__clear {
  display: block;
  min-height: 100vh;
}
</style>
