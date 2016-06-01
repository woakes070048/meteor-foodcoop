Package.describe({
  name: 'redhead:angular-avatar',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.use('ecmascript');
  api.imply(['angular', 'pbastowski:angular-babel'], 'client');
  api.addFiles('md5.js', 'client');
  api.mainModule('angular-avatar.js', 'client');
  api.addFiles('publish.js', 'server');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('redhead:angular-avatar');
  api.addFiles('angular-avatar-tests.js');
});
