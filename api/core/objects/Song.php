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
  }

  return $artists;
}

function SongGetArtistForSong(int $aid)
{
  $query = "SELECT name, suranme, altname FROM Artists WHERE aid = :aid";
  $var = [
    ':aid' => $aid
  ];
  $artist = dbGetOne($query, $var);
  return $artist;
}

function SongGetBySid(int $sid)
{
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
