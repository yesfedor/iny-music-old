import { inject } from '@vue/runtime-core'

export function usePosition () {
  const use = inject('position')
  return use
}

export function useProgress () {
  const use = inject('progress')
  return use
}

export function useTheme () {
  const use = inject('theme')
  return use
}
