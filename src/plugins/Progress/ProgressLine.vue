<template>
  <div class="progress-line">
    <div :class="classFill"></div>
  </div>
</template>

<script>
import { inject, ref, watch } from '@vue/runtime-core'
export default {
  name: 'ProgressLine',
  setup () {
    const classFill = ref('progress-line__fill')
    const progress = inject('progress')

    watch(() => ({ ...progress.options }), (optionsA, optionsB) => {
      if (optionsA.counterActive === optionsB.counterActive &&
          (!progress.options.preloaderEffectOnLine ||
          progress.options.isPreloader)) {
        return false
      }
      if (progress.options.counterActive > 0) {
        classFill.value = 'progress-line__fill progress-line__fill_active'
      }
      if (progress.options.counterActive === 0) {
        classFill.value = 'progress-line__fill progress-line__fill_done'
        setTimeout(() => {
          classFill.value = 'progress-line__fill progress-line__reset'
        }, 1000)
        setTimeout(() => {
          classFill.value = 'progress-line__fill'
        }, 1100)
      }
    })

    return {
      classFill
    }
  }
}
</script>

<style scoped>
@keyframes ProgressLineFill {
  0% {
    width: 0vw;
  }
  25% {
    width: 50vw;
  }
  50% {
    width: 75vw;
  }
  75% {
    width: 85vw;
  }
  90% {
    width: 90vw;
  }
  92.5% {
    width: 93vw;

  }
  95% {
    width: 95vw;

  }
  100% {
    width: 97vw;

  }
}
.progress-line {
  width: 100vw;
  height: 3px;
  display: block;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 10000;
}
.progress-line__fill {
  width: 0vw;
  height: 100%;
  transition: all;
  transition-duration: 500ms;
  transition-delay: 0ms;
  background-color: var(--progress-line-fill-skeleton);
  background: var(--progress-line-fill);
}
.progress-line__fill_active {
  animation: ProgressLineFill 60s ease-out 100ms infinite;
}
.progress-line__fill_done {
  width: 100vw;
}
.progress-line__reset {
  transition-duration: 0ms;
}
</style>
