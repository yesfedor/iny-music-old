<?php

function GetArtistsOnFeaturing (int $fid) {
  $query = "SELECT `aid`, `position` FROM `Feat` WHERE fid = :fid";
  $var = [
    ':fid' => $fid
  ];

  $artists = dbGetAll($query, $var);
  for ($index = 0; $index < count($artists); $index++){
    $artists[$index]['artist'] = GetArtistForSong($artists[$index]['aid']);
  }
  
  return $artists;
}

function GetArtistForSong (int $aid) {
  $query = "SELECT `name`, `suranme`, `altname` FROM `Artists` WHERE aid = :aid";
  $var = [
    ':aid' => $aid 
  ];
  $artist = dbGetOne($query, $var);
  return $artist;
}

function GetSong (int $sid) {
  $query = "SELECT `aid`, `fid`, `title`, `subtitle`, `explicit`, `duration`, `uri`, `img_1024`FROM `Song` WHERE sid = :sid"; 
  $var = [
    ':sid' => $sid
  ];
  $song = dbGetOne($query, $var);

  $data = [
    'artist' => GetArtistForSong(intval($song['aid'])),
    'featuring' => GetArtistsOnFeaturing(intval($song['fid'])),
    'title' => $song['title'],
    'subtitle' => $song['subtitle'],
    'explicit' => $song['explicit'],
    'duration' => $song['duration'],
    'song' => $song['uri'],
    'img_1024'=> $song['img_1024']
  ];

  return $data;
}