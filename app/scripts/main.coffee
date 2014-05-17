require.config
  baseUrl: '/'
  paths:
    jquery: 'vendor/jquery/dist/jquery'
    text: 'vendor/requirejs-text/text'
    spine: 'vendor/spine/lib'
    models: 'scripts/models'

  shim:
    jquery:
      exports: '$'

    'spine/spine':
      deps: ['jquery']
      exports: 'Spine'

    'spine/ajax':
      deps: ['spine/spine']
      exports: 'Spine'

    'spine/route':
      deps: ['spine/spine']
      exports: 'Spine'

    'spine/manager':
      deps: ['spine/route']
      exports: 'Spine'
