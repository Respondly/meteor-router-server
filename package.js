Package.describe({
  summary: 'Simple server-side routing'
});


Npm.depends({
  'connect':   '2.9.0',
  'useragent': '2.0.7',
  'jade': '0.35.0',
  'stylus': '0.41.0',
  'nib': '1.0.1'
});



Package.on_use(function (api) {
  api.use(['coffeescript', 'http']);
  api.use(['templating'], 'client');
  api.use(['css-stylus', 'ctrl', 'util']);
  api.export('Server');

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('server/ns.js', 'server');
  api.add_files('server/router.coffee', 'server');
  api.add_files('server/render-jade.coffee', 'server');
  api.add_files('server/render-stylus.coffee', 'server');
  api.add_files('server/render.coffee', 'server');
  api.add_files('server/response-send.coffee', 'server');

});


