<?php
// DataBase settings
$config['db'] = [
  'host' => 'localhost',
  'dbname' => 'cc38255_music',
  'user' => 'cc38255_music',
  'password' => 'h9qdfFqR'
];

// Host setings
$config['hostnameApi'] = 'music.iny.su';
$config['docsHostname'] = 'music.iny.su';
$config['protocol'] = 'http://';

// App base link
$config['mainAppUrl'] = $config['protocol'] . $config['hostnameApi'];

// Docs base link
$config['docs'] = $config['protocol'] . $config['docsHostname'] . '/api/docs';

// Responce body function in handlers/Responce.php
$config['responce'] = 'ResponceWithJSON';
