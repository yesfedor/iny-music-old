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
    path: '/artist/:artistId',
    name: 'Artist',
    component: () => import(/* webpackChunkName: "artist" */ '../views/Artist.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/collection/albums',
    name: 'CollectionAlbums',
    component: () => import(/* webpackChunkName: "collection" */ '../views/CollectionAlbums.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/collection/artists',
    name: 'CollectionArtists',
    component: () => import(/* webpackChunkName: "collection" */ '../views/CollectionArtists.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/collection/playlists',
    name: 'CollectionPlaylists',
    component: () => import(/* webpackChunkName: "collection" */ '../views/CollectionPlaylists.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/collection/tracks',
    name: 'CollectionTracks',
    component: () => import(/* webpackChunkName: "collection" */ '../views/CollectionTracks.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/genre/:genreId',
    name: 'Genre',
    component: () => import(/* webpackChunkName: "genre" */ '../views/Genre.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/playlist/:playlistId',
    name: 'Playlist',
    component: () => import(/* webpackChunkName: "playlist" */ '../views/Playlist.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/profile',
    name: 'Profile',
    component: () => import(/* webpackChunkName: "profile" */ '../views/Profile.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/search',
    name: 'Search',
    component: () => import(/* webpackChunkName: "search" */ '../views/Search.vue'),
    meta: {
      layout: 'LayoutMain'
    }
  },
  {
    path: '/signin',
    name: 'Signin',
    component: () => import(/* webpackChunkName: "auth" */ '../views/Signin.vue'),
    meta: {
      layout: 'LayoutClear'
    }
  },
  {
    path: '/signup',
    name: 'Signup',
    component: () => import(/* webpackChunkName: "auth" */ '../views/Signup.vue'),
    meta: {
      layout: 'LayoutClear'
    }
  },
  {
    path: '/user/:userId',
    name: 'User',
    component: () => import(/* webpackChunkName: "user" */ '../views/User.vue'),
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
