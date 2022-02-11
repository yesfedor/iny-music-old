import { createStore } from 'vuex'

export default createStore({
  state: {
    user: {
      isAuth: false,
      data: {}
    }
  },
  getters: {
    isAuth: (state) => {
      return state.user.isAuth
    },
    user: (state) => {
      return state.user.data
    }
  },
  mutations: {
    'auth:true' (state, payload) {
      if (typeof payload === 'object' && payload.uid) {
        state.user.isAuth = true
        state.user.data = payload
      }
    },
    'auth:false' (state) {
      state.user.isAuth = false
      state.user.data = {}
    }
  },
  actions: {
  },
  modules: {
  }
})
