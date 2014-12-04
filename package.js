Package.describe({
  name: 'respondly:router-server',
  summary: 'Simple server-side routing',
  version: '1.0.1',
  git: 'https://github.com/Respondly/meteor-router-server.git'
});



Npm.depends({
  'connect':   '2.9.0',
  'useragent': '2.0.7',
  'jade': '0.35.0',
  'stylus': '0.41.0',
  'nib': '1.0.1'
});



Package.onUse(function (api) {
  api.use('coffeescript@1.0.4');
  api.use('http@1.0.8')
  api.use('webapp@1.1.4');
  api.use('respondly:css-stylus@1.0.3');
  api.use('respondly:util@1.0.1');
  api.export('Server');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('server/ns.js', 'server');
  api.addFiles('server/router.coffee', 'server');
  api.addFiles('server/render-jade.coffee', 'server');
  api.addFiles('server/render-stylus.coffee', 'server');
  api.addFiles('server/render.coffee', 'server');
  api.addFiles('server/response-send.coffee', 'server');

});


