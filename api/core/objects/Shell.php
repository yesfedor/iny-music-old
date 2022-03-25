<?php
function ShellSetGenre () {
  $genres = json_decode(file_get_contents('https://raw.githubusercontent.com/nekomeowww/MusicGenres/master/gen/genres.json'), true);
  $query = "INSERT INTO `Genre`(`gid`, `title`) VALUES (NULL, :title)";
  $var = [
    ':title' => null
  ];
  for ($i = 0; $i < count($genres); $i++) {
    $var[':title'] = $genres[$i];
    // dbAddOne($query, $var);
  }
  return ['ok'];
}