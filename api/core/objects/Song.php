<?php

function SongGetArtistsOnFeaturing(int $fid, int $aid)
{
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

function SongGetArtistForSong(int $aid)
{
  $query = "SELECT aid, name, surname, altname FROM Artists WHERE aid = :aid";
  $var = [
    ':aid' => $aid
  ];
  $artist = dbGetOne($query, $var);
  return $artist;
}

function SongGetBySid(int $sid)
{
  $query = "SELECT sid, aid, fid, title, subtitle, explicit, duration, uri, img_1024 FROM Song WHERE sid = :sid";
  $var = [
    ':sid' => $sid
  ];
  $song = dbGetOne($query, $var);

  $data = [
    'sid' => $song['sid'],
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

function SongGetQueueCurrent(string $jwt)
{
  if (!UserJwtIsValid($jwt)) return [];
  $user = UserJwtDecode($jwt)['data'];

  if (!$user['uid']) return [];

  $query = "SELECT id, uid, sid, time FROM SongQueueCurrent WHERE uid = :uid";
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

function SongSetQueueCurrent(string $jwt, int $sid = 1, int $time = 0)
{
  if (!UserJwtIsValid($jwt)) return [];
  $user = UserJwtDecode($jwt)['data'];

  if (!$user['uid']) return [];

  $queueCurrent = SongGetQueueCurrent($jwt);

  if ($queueCurrent['id'] && $user['uid'] !== $queueCurrent['uid']) return [];

  $var = [
    ':uid' => $user['uid'],
    ':sid' => $sid,
    ':time' => $time,
    ':updated_at' => time()
  ];

  if (!$queueCurrent['id']) {
    $query = "INSERT INTO SongQueueCurrent (id, uid, sid, time, updated_at, created_at)" .
      "VALUES (NULL, :uid, :sid, :time, :updated_at, :created_at)";
    $var[':created_at'] = time();
  } else {
    $query = "UPDATE SongQueueCurrent SET sid = :sid, time = :time, updated_at = :updated_at WHERE uid = :uid";
  }

  dbAddOne($query, $var);

  return ['status' => true];
}

function SongGetPlayerSettings(string $jwt, $isSetDefault = true)
{
  if (!UserJwtIsValid($jwt)) return [];
  $user = UserJwtDecode($jwt)['data'];

  if (!$user['uid']) return [];

  $query = "SELECT uid, player_volume, player_shuffle, player_repeat FROM UserPlayerSettings WHERE uid = :uid";
  $var = [
    ':uid' => $user['uid']
  ];
  $settings = dbGetOne($query, $var);

  if (!$settings['uid']) {
    if ($isSetDefault) {
      SongSetPlayerSettings($jwt, 50, false, 'repeat-queue');
      return SongGetPlayerSettings($jwt);
    } else return [];
  }

  return $settings;
}

function SongSetPlayerSettings(string $jwt, int $player_volume, bool $player_shuffle, string $player_repeat)
{
  if (!UserJwtIsValid($jwt)) return [];
  $user = UserJwtDecode($jwt)['data'];

  if (!$user['uid']) return [];

  $repeat_set = ['no-repeat', 'repeat-queue', 'repeat-song'];
  if (!in_array($player_repeat, $repeat_set, true)) return ['status' => false];

  $settings = SongGetPlayerSettings($jwt, false);

  $var = [
    ':player_volume' => $player_volume,
    ':player_shuffle' => $player_shuffle,
    ':player_repeat' => $player_repeat,
    ':uid' => $user['uid']
  ];
  if (!$settings['uid']) {
    $query = "INSERT INTO UserPlayerSettings (uid, player_volume, player_shuffle, player_repeat)" .
      "VALUES (:uid, :player_volume, :player_shuffle, :player_repeat)";
  } else {
    $query = "UPDATE UserPlayerSettings SET player_volume = :player_volume, player_shuffle = :player_shuffle, player_repeat = :player_repeat WHERE uid = :uid";
  }

  dbAddOne($query, $var);

  return ['status' => true];
}

function UserSongQueueSet (string $jwt, string $type, int $type_value) {
  if (!UserJwtIsValid($jwt)) return [];
  $user = UserJwtDecode($jwt)['data'];

  if (!$user['uid']) return [];

  $type_set = ['alid', 'cid', 'pid'];
  if (!in_array($type, $type_set, true)) return ['status' => false];

  $userSongQueue = UserSongQueueGet($jwt);

  $var = [
    ':uid' => $user['uid'],
    ':type' => $type,
    ':type_value' => $type_value,
    ':updated_at' => time()
  ];

  if ($userSongQueue['uid']) {
    $query = "UPDATE UserSongQueue SET type = :type, type_value = :type_value, updated_at = :updated_at WHERE uid = :uid";
  } else {
    $query = "INSERT INTO UserSongQueue (uid, type, type_value, updated_at, created_at) VALUES (:uid, :type, :type_value, :updated_at, :created_at)";
    $var[':created_at'] = time();
  }

  dbAddOne($query, $var);

  return UserSongQueueGet($jwt);
}

function UserSongQueueGet (string $jwt) {
  if (!UserJwtIsValid($jwt)) return [];
  $user = UserJwtDecode($jwt)['data'];

  if (!$user['uid']) return [];

  $query = "SELECT * FROM UserSongQueue WHERE uid = :uid";
  $var = [
    ':uid' => $user['uid']
  ];
  $userSongQueue = dbGetOne($query, $var);

  if (!$userSongQueue) {
    // need click user to call UserSongQueueSet
    return ['status' => false];
  }

  return $userSongQueue;
}