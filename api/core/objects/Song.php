<?php

function SongGetArtistsOnFeaturing(int $fid, int $aid) {
  $query = "SELECT aid, position FROM Feat WHERE fid = :fid AND aid != :aid";
  $var = [
    ':fid' => $fid,
    ':aid' => $aid
  ];

  $artists = dbGetAll($query, $var);
  for ($index = 0; $index < count($artists); $index++) {
    $artists[$index]['artist'] = SongGetArtistForSong($artists[$index]['aid']);
    unset($artists[$index]['aid']);
  }

  return $artists;
}

function SongGetArtistForSong(int $aid) {
  $query = "SELECT aid, name, suranme, altname FROM Artists WHERE aid = :aid";
  $var = [
    ':aid' => $aid
  ];
  $artist = dbGetOne($query, $var);
  return $artist;
}

function SongGetBySid(int $sid) {
  $query = "SELECT aid, fid, title, subtitle, explicit, duration, uri, img_1024 FROM Song WHERE sid = :sid";
  $var = [
    ':sid' => $sid
  ];
  $song = dbGetOne($query, $var);

  $data = [
    'artist' => SongGetArtistForSong(intval($song['aid'])),
    'featuring' => SongGetArtistsOnFeaturing(intval($song['fid']), intval($song['aid'])),
    'title' => $song['title'],
    'subtitle' => $song['subtitle'],
    'explicit' => $song['explicit'],
    'duration' => $song['duration'],
    'song' => $song['uri'],
    'img_1024' => $song['img_1024']
  ];

  return $data;
}

function SongGetQueueCurrent (string $jwt) {
  if (!UserJwtIsValid($jwt)) return [];
  $user = UserJwtDecode($jwt)['data'];
  
  if (!$user['uid']) return [];

  $query = "SELECT id, sid, time FROM SongQueueCurrent WHERE uid = :uid";
  $var = [
    ':uid' => $user['uid']
  ];
  $queueCurrent = dbGetOne($query, $var);

  if (!$queueCurrent['id']) return [];

  $songData = SongGetBySid($queueCurrent['sid']);
  
  $queueCurrent = array_merge($queueCurrent, $songData);

  if (!count($queueCurrent)) return [];

  return $queueCurrent;
}

function SongGetPlayerSettings (string $jwt) {
  if (!UserJwtIsValid($jwt)) return [];
  $user = UserJwtDecode($jwt)['data'];
  
  if (!$user['uid']) return [];

  $query = "SELECT uid, player_volume, player_shuffle, player_repeat FROM UserPlayerSettings WHERE uid = :uid";
  $var = [
    ':uid' => $user['uid']
  ];
  $settings = dbGetOne($query, $var);

  if (!$settings) return [];

  return $settings;
}

function SongSetPlayerSettings (string $jwt, int $player_volume, bool $player_shuffle, string $player_repeat) {
  if (!UserJwtIsValid($jwt)) return [];
  $user = UserJwtDecode($jwt)['data'];
  
  if (!$user['uid']) return [];

  $repeat_set = ['no-repeat', 'repeat-queue', 'repeat-song'];
  if (!in_array($player_repeat, $repeat_set, true)) return [];

  $settings = SongGetPlayerSettings($jwt);

  $var = [
    ':player_volume' => $player_volume,
    ':player_shuffle' => $player_shuffle,
    ':player_repeat' => $player_repeat,
    ':uid' => $user['uid']
  ];
  if (!$settings['uid']) {
    $query = "INSERT INTO UserPlayerSettings (uid, player_volume, player_shuffle, player_repeat)".
             "VALUES (:uid, :player_volume, :player_shuffle, :player_repeat)";
  } else {
    $query = "UPDATE UserPlayerSettings SET player_volume = :player_volume, player_shuffle = :player_shuffle, player_repeat = :player_repeat WHERE uid = :uid";
  }

  dbAddOne($query, $var);

  return ['status' => true];
}
