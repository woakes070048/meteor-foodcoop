Package.describe({
  name: 'redhead:cart',
  version: '0.0.2',
  // Brief, one-line summary of the package.
  summary: 'a really simple shopping cart',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');
  api.use(['mongo', 'random', 'coffeescript', 'check']);
  api.use(['tracker', 'session'], 'client');
  api.addFiles('cart.coffee');
  api.export('Cart');
});

Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.use('redhead:cart');
  api.addFiles('cart-tests.js');
});
