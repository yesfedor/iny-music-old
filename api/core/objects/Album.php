<?php
function AlbumGetByAlid ($alid) {
  $query = "SELECT * FROM Albums WHERE alid = :alid";
  $var = [
    ':alid' => $alid
  ];
  $album = dbGetOne($query, $var);

  if (!$album['alid']) return ['status' => 404];

  $query_artist = "SELECT * FROM Artists WHERE aid = :aid";
  $var_artist = [
    ':aid' => $album['aid']
  ];

  $album['artist'] = dbGetOne($query_artist, $var_artist);

  return $album;
}

function AlbumGetContent ($alid) {
  $query = "SELECT sid FROM Song WHERE alid = :alid";
  $var = [
    ':alid' => $alid
  ];

  $songs = dbGetAll($query, $var);

  if (!count($songs)) return ['status' => 404];

  for ($i = 0; $i < count($songs); $i++) {
    $songs[$i] = SongGetBySid($songs[$i]['sid']);
  }

  return $songs;
}