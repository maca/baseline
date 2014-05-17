require.config({
  baseUrl: '/',
  paths: {
    'mocha': 'spec/vendor/mocha/mocha',
    'chai': 'spec/vendor/chai/chai',
    'chai-jquery': 'spec/vendor/chai-jquery/chai-jquery',
    'maquila': 'spec/vendor/maquila/dist/maquila',
    'factories': 'spec/factories'
  },
  shim: {
    'chai-jquery': ['jquery', 'chai'],
    'maquila': {exports: 'Maquila'}
  }
});

specs = [
  'models/user_spec.js',
]

factories = [
  'factories/user_factory'
]
 
require(['require', 'chai', 'chai-jquery', 'mocha', 'jquery'],
  function(require, chai, chaiJquery){
    // Chai
    chai.use(chaiJquery);
    /*globals mocha */
    mocha.setup('bdd');

    requires = [].concat(factories, specs)

    require(requires, function(require) {
      if (window.mochaPhantomJS) {
        mochaPhantomJS.run();
      } else {
        mocha.run();
      }
    });
  }
);
