<?php
http_response_code(200);
define('DIR','/home/c/cc38255/music-app');
require_once(DIR . '/core/boot/init.php');
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Документация | Разработчикам | INY</title>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">

    <style>
      @import url('https://fonts.googleapis.com/css2?family=Poiret+One&display=swap');

      @-webkit-keyframes background {
          0%{background-position:99% 0%}
          50%{background-position:2% 100%}
          100%{background-position:99% 0%}
      }
      @-moz-keyframes background {
          0%{background-position:99% 0%}
          50%{background-position:2% 100%}
          100%{background-position:99% 0%}
      }
      @keyframes background {
          0%{background-position:99% 0%}
          50%{background-position:2% 100%}
          100%{background-position:99% 0%}
      }

      * {
        color: white;
        font-family: 'Poiret One', cursive;
      }
      html, body, h1, h4 {
        margin: 0px;
        padding: 0px;
        display: block;
      }
      .grid-container {
        background-color: #4158D0;
        background-size: 300% 300%;
        background-image: linear-gradient(45deg, #4158D0 5%, #C850C0 50%, #FFCC70 95%);
        animation: background 8s infinite alternate;
        height: 100vh;
        display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        grid-template-rows: 1fr 1fr 1fr 1fr;
        gap: 0px 0px;
        grid-template-areas:
          ". . ."
          ". logo ."
          ". desc ."
          ". . .";
      }
      .logo {
        grid-area: logo;
        display: flex;
        justify-content: center;
        align-items: center;
      }
      .desc {
        grid-area: desc;
        display: flex;
        justify-content: center;
        align-items: center;
      }
      .link {
        color: white;
        font-weight: 700;
      }
    </style>
  </head>
  <body>
    <div class="grid-container">
      <div class="logo">
        <h1>Документация | Разработчикам | INY</h1>
        <h3>
          <a class="link" href="https://apollo.iny.su/dev" target="_blank" rel="noopener noreferrer">Документация временно тут</a>
        </h3>
      </div>
      <div class="desc">
        <h3>
          By 
          <a class="link" target="_blank" href="https://vk.com/yesfedor">Garanin Fedor</a>
        </h3>
      </div>
    </div>
  </body>
</html>