<template>
  <div class="welcome">
    <div class="container my-5">
      <div class="row justify-content-center">
        <div class="col-12 col-lg-6 mb-3 text-center">
          <h1 class="fs-1 mb-1">App Template v1</h1>
          <p class="fs-6">
            Шаблон для ваших веб-приложений.
          </p>
        </div>
        <div class="clearfix"></div>
        <div class="col-6 mb-3">
          <hr class="w-100 my-0">
        </div>
        <div class="clearfix"></div>
        <div class="col-12 col-lg-6 mb-3 text-center">
          <h3 class="fs-4 mb-3">Технологии , используемые в шаблоне</h3>
          <ul class="list-group">
            <li class="list-group-item">Vue 3 with Vue Router and Vuex</li>
            <li class="list-group-item">Bootstrap 5 (cdn)</li>
            <li class="list-group-item">Font Awesome (cdn)</li>
            <li class="list-group-item">Own plugins: Progress with ProgressLine and ProgressPreloader</li>
            <li class="list-group-item">Own plugins: Theme with ThemeToggler</li>
          </ul>
        </div>
        <div class="clearfix"></div>
        <div class="col-6 mb-3">
          <hr class="w-100 my-0">
        </div>
        <div class="clearfix"></div>
        <div class="col-12 col-lg-6 mb-3 text-center">
          <h3 class="fs-4 mb-3">Own plugins: Progress</h3>
          <p class="d-block fs-6 text-start">
            Индикатор выполнения с двумя основыми компонентами.
            <br>
            <b class="ps-1">ProgressPreloader.vue</b> - начальный загрузочный экран, позволяет вывести некую информацию, во время загрузки приложения.
            <br>
            with Composition API:<br>
            const progress = useProgress()<br>
            progress.showPreloader()<br>
            progress.hidePreloader()<br>
            <a @click="previewPreloader()" href="#">showPreloader on 2500ms</a><br><br>
            <b class="ps-1">ProgressLine.vue</b> - это линия прогресса, которая дает понять пользователю, что идет загрузка чего-либо.<br>
            with Composition API:<br>
            const progress = useProgress()<br>
            progress.addLine()<br>
            progress.removeLine()
          </p>
          <span class="d-block text-start mb-3">$progress.options.counterActive: {{$progress.options.counterActive}}</span>
          <div class="col-12 text-start">
            <button @click="$progress.addLine()" class="btn btn-primary me-3">loading +</button>
            <button @click="$progress.removeLine()" class="btn btn-primary">loading -</button>
          </div>
        </div>
        <div class="clearfix"></div>
        <div class="col-6 mb-3">
          <hr class="w-100 my-0">
        </div>
        <div class="clearfix"></div>
        <div class="col-12 col-lg-6 mb-3 text-center">
          <h3 class="fs-4 mb-3">Own plugins: Theme</h3>
          <p class="fs-6 text-start">
            const theme = useTheme()<br>
            Плагин для смены темы посредствам css variables.<br>
            Имеет всего один компонент: ThemeToggler<br>
            ThemeToggler: <theme-toggler></theme-toggler>
          </p>
        </div>
        <div class="clearfix"></div>
        <div class="col-6 mb-3">
          <hr class="w-100 my-0">
        </div>
        <div class="clearfix"></div>
        <div class="col-12 col-lg-6 mb-3 text-center">
          <h3 class="fs-4 mb-3">Own plugins: Position</h3>
          <p class="fs-6 text-start">
            Плагин для упралвения позиционированием.<br>
            Доступные параметры:<br>
            const position = usePosition()<br>
            1. orientation - 'horizontal', 'portrait'<br>
            2. breakpoint - breakpoint из сетки bootstarp 5:<br>
            3. clientX & clientY
          </p>
          <span class="d-block fs-5 text-start">orientation: <b>{{ $position.orientation }}</b></span>
          <span class="d-block fs-5 text-start">breakpoint: <b>{{ $position.breakpoint }}</b></span>
          <span class="d-block fs-5 text-start">Для демонстрации измените размер окна</span>
          <br>
          <ul class="list-group">
            <li class="list-group-item">xs: 1</li>
            <li class="list-group-item">sm: 576px, 2</li>
            <li class="list-group-item">md: 768px, 3</li>
            <li class="list-group-item">lg: 992px, 4</li>
            <li class="list-group-item">xl: 1200px, 5</li>
            <li class="list-group-item">xxl: 1400px 6</li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { onMounted } from '@vue/runtime-core'
import { useProgress } from '../plugins/hooks'
export default {
  name: 'Welcome',
  setup () {
    const progress = useProgress()
    const previewPreloader = () => {
      progress.showPreloader()
      setTimeout(() => {
        progress.hidePreloader()
      }, 2500)
    }

    progress.showPreloader()
    onMounted(() => {
      document.title = 'Welcome'
      setTimeout(() => {
        progress.hidePreloader()
      }, 2000)
    })

    return {
      previewPreloader
    }
  }
}
</script>

<style scoped>
.welcome {
  display: flex;
  align-items: center;
  flex-direction: column;
  min-height: 100vh;
  color: var(--theme-color);
  background: var(--theme-background);
}
.list-group-item {
  color: var(--html-color);
  background: var(--theme-panel);
  border-color: var(--theme-border-color);
}
</style>
