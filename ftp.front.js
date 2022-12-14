var FtpDeploy = require('ftp-deploy')
var ftpDeploy = new FtpDeploy()

var configFront = {
  user: 'cc38255',
  // Password optional, prompted if none given
  password: 'asd486982asd',
  host: 'vh370.timeweb.ru',
  port: 21,
  localRoot: `${__dirname}/dist/`,
  remoteRoot: 'spotyfree/public_html/',
  // include: ["*", "**/*"],      // this would upload everything except dot files
  include: ['*', '**/*'],
  // e.g. exclude sourcemaps, and ALL files in node_modules (including dot files)
  exclude: ['dist/**/*.map', 'node_modules/**', 'node_modules/**/.*', '.git/**'],
  // delete ALL existing files at destination before uploading, if true
  deleteRemote: false,
  // Passive mode is forced (EPSV command is not sent)
  forcePasv: true,
  // use sftp or ftp
  sftp: false
}

ftpDeploy
  .deploy(configFront)
  .then(res => console.log('finished:', res))
  .catch(err => console.log(err))
