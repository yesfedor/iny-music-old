<template>
  <div class="layout__main">
    <the-header class="layout__header"></the-header>
    <the-wrapper class="layout__wrapper"></the-wrapper>
    <the-footer class="layout__footer"></the-footer>
  </div>
</template>

<script>
import TheHeader from '../components/TheHeader.vue'
import TheWrapper from '../components/TheWrapper.vue'
import TheFooter from '../components/TheFooter.vue'

export default {
  name: 'LayoutMain',
  components: {
    TheHeader,
    TheWrapper,
    TheFooter
  }
}
</script>
