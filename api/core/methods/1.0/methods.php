<?php
// single methods
$methods = [
  'app.create' => [
    'in_active' => true,
    'beforeMethods' => [],
    'objects' => ['Applications', 'User'],
    'title' => 'Create app',
    'detail' => 'Create public app for iny.su',
    'link' => '/app.create',
    'props' => [
      'title' => [
        'required' => true,
        'type' => 'String'
      ],
      'owner_uid' => [
        'required' => true,
        'type' => 'Int'
      ],
      'redirect_uri' => [
        'required' => true,
        'type' => 'String'
      ]
    ]
  ],
  'app.widgetAuth' => [
    'in_active' => true,
    'beforeMethods' => [],
    'objects' => ['Applications'],
    'title' => 'Auth user by app',
    'detail' => 'Auth user by app',
    'link' => '/app.widgetAuth',
    'props' => [
      'app_id' => [
        'required' => true,
        'type' => 'Int'
      ]
    ]
  ],
  'device.getClientId' => [
    'in_active' => true,
    'beforeMethods' => [],
    'objects' => ['Applications', 'Device'],
    'title' => 'Client Id',
    'detail' => 'Register New Device',
    'link' => '/device.getClientId',
    'props' => [
      'app_id' => [
        'required' => true,
        'type' => 'Int'
      ],
      'platform' => [
        'required' => true,
        'type' => 'String'
      ]
    ]
  ],
  'user.register' => [
    'in_active' => true,
    'beforeMethods' => [],
    'objects' => ['User', 'Device'],
    'title' => 'New user',
    'detail' => 'Register new profile',
    'link' => '/user.register',
    'props' => [
      'client_id' => [
        'required' => true,
        'type' => 'String'
      ],
      'name' => [
        'required' => true,
        'type' => 'String'
      ],
      'surname' => [
        'required' => true,
        'type' => 'String'
      ],
      'gender' => [
        'required' => true,
        'type' => 'String'
      ],
      'birthday' => [
        'required' => false,
        'type' => 'String',
        'default' => '2000-06-15'
      ],
      'email' => [
        'required' => true,
        'type' => 'String'
      ],
      'password' => [
        'required' => true,
        'type' => 'String'
      ]
    ]
  ],
  'user.login' => [
    'in_active' => true,
    'beforeMethods' => [],
    'objects' => ['User', 'Device'],
    'title' => 'User login',
    'detail' => 'User login',
    'link' => '/user.login',
    'props' => [
      'email' => [
        'required' => true,
        'type' => 'String'
      ],
      'password' => [
        'required' => true,
        'type' => 'String'
      ],
      'client_id' => [
        'required' => true,
        'type' => 'String'
      ],
      'eval' => [
        'required' => false,
        'type' => 'Bool'
      ]
    ]
  ],
  'user.getPublicInfo' => [
    'in_active' => true,
    'beforeMethods' => [],
    'objects' => ['User', 'Device'],
    'title' => 'User default info',
    'detail' => 'User default info',
    'link' => '/user.getPublicInfo',
    'props' => [
      'uid' => [
        'required' => false,
        'type' => 'Int'
      ],
      'domain' => [
        'required' => false,
        'type' => 'String'
      ]
    ]
  ],
  'user.getPrivateInfo' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['User', 'Device'],
    'title' => 'User default info',
    'detail' => 'User default info',
    'link' => '/user.getPrivateInfo',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String'
      ],
      'uid' => [
        'required' => false,
        'type' => 'Int'
      ],
      'domain' => [
        'required' => false,
        'type' => 'String'
      ]
    ]
  ],
  'user.refreshJwt' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['Device', 'User'],
    'title' => 'User loggined refresh info',
    'detail' => 'User loggined refresh info',
    'link' => '/user.refreshJwt',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String'
      ],
      'client_id' => [
        'required' => true,
        'type' => 'String'
      ]
    ]
  ],
  'user.changeStatus' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['User', 'Device'],
    'title' => 'User change status',
    'detail' => 'User change status',
    'link' => '/user.changeStatus',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String'
      ],
      'status' => [
        'required' => false,
        'type' => 'String'
      ]
    ]
  ],
  'user.editSave' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['User', 'Device'],
    'title' => 'User edit save data',
    'detail' => 'User edit',
    'link' => '/user.editSave',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String'
      ],
      'name' => [
        'required' => false,
        'type' => 'String'
      ],
      'surname' => [
        'required' => false,
        'type' => 'String'
      ],
      'birthday' => [
        'required' => false,
        'type' => 'String'
      ],
      'gender' => [
        'required' => false,
        'type' => 'String'
      ]
    ]
  ],
  'user.sessionsShow' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['User', 'Device'],
    'title' => 'Show activity history',
    'detail' => 'Show activity history',
    'link' => '/user.sessionsShow',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String'
      ],
      'client_id' => [
        'required' => true,
        'type' => 'String'
      ]
    ]
  ],
  'user.sessionsLogout' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['User', 'Device'],
    'title' => 'Log out from other devices',
    'detail' => 'Log out from other devices',
    'link' => '/user.sessionsLogout',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String'
      ],
      'client_id' => [
        'required' => true,
        'type' => 'String'
      ],
      'specified_client_id' => [
        'required' => false,
        'type' => 'String'
      ]
    ]
  ],
  'utils.time' => [
    'in_active' => true,
    'beforeMethods' => [],
    'objects' => ['Utils'],
    'title' => 'Time()',
    'detail' => 'Get server time',
    'link' => '/time',
    'props' => [
      'now' => [
        'required' => false,
        'type' => 'Int',
        'default' => 0,
      ]
    ]
  ],
  'shell.setGenre' => [
    'in_active' => true,
    'beforeMethods' => [],
    'objects' => ['Shell'],
    'title' => 'Time()',
    'detail' => 'Get server time',
    'link' => '/time',
    'props' => []
  ],
  'song.getBySid' => [
    'in_active' => true,
    'beforeMethods' => [],
    'objects' => ['Song'],
    'title' => 'Song',
    'detail' => 'Get song informnation',
    'link' => '/getSong',
    'props' => [
      'sid' => [
        'required' => true,
        'type' => 'Int',
        'default' => 1,
      ]
    ]
  ],
  'song.getQueueCurrent' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['Song', 'User', 'Device'],
    'title' => 'Song',
    'detail' => 'Get song informnation',
    'link' => '/getSong',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String',
        'default' => '',
      ],
      'client_id' => [
        'required' => true,
        'type' => 'String',
        'default' => ''
      ]
    ]
  ],
  'song.setQueueCurrent' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['Song', 'User', 'Device'],
    'title' => 'Song',
    'detail' => 'Get song informnation',
    'link' => '/getSong',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String',
        'default' => '',
      ],
      'client_id' => [
        'required' => true,
        'type' => 'String',
        'default' => ''
      ],
      'sid' => [
        'required' => true,
        'type' => 'Int',
        'default' => 1
      ],
      'time' => [
        'required' => false,
        'type' => 'Int',
        'default' => 0
      ],
    ]
  ],
  'song.getPlayerSettings' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['Song', 'User', 'Device'],
    'title' => 'Song',
    'detail' => 'Get player settings',
    'link' => '/getSettings',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String',
        'default' => ''
      ],
      'client_id' => [
        'required' => true,
        'type' => 'String',
        'default' => ''
      ]
    ]
  ],
  'song.setPlayerSettings' => [
    'in_active' => true,
    'beforeMethods' => ['User.online'],
    'objects' => ['Song', 'User', 'Device'],
    'title' => 'Song',
    'detail' => 'Get player settings',
    'link' => '/getSettings',
    'props' => [
      'jwt' => [
        'required' => true,
        'type' => 'String',
        'default' => ''
      ],
      'client_id' => [
        'required' => true,
        'type' => 'String',
        'default' => ''
      ],
      'player_volume' => [
        'required' => false,
        'type' => 'Int',
        'default' => 0
      ],
      'player_shuffle' => [
        'required' => true,
        'type' => 'Bool',
        'default' => false
      ],
      'player_repeat' => [
        'required' => true,
        'type' => 'String',
        'default' => ''
      ]
    ]
  ]
];

return $methods;