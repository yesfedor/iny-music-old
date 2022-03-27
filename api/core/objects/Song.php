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
  }

  return $artists;
}

function SongGetArtistForSong(int $aid) {
  $query = "SELECT name, suranme, altname FROM Artists WHERE aid = :aid";
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

  return $queueCurrent;
}
