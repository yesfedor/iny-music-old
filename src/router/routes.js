const routes = [
  {
    path: '/',
    name: 'Main',
    component: () => import(/* webpackChunkName: "main" */ '../views/Main.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'PageNotFound',
    component: () => import(/* webpackChunkName: "page-not-found" */ '../views/PageNotFound.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  }
]

export default routes
