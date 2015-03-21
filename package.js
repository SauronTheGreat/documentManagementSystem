Package.describe({
  name: 'rushabhhathi:dms',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'A simple and configurable Document Managemet System for your meteor application',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0.4.2');
  api.addFiles('dms.js');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('rushabhhathi:dms');
  api.addFiles('dms-tests.js');
});
