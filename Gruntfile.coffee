module.exports = (grunt) ->
  pkgData = grunt.file.readJSON 'package.json'

  grunt.initConfig
    pkg: pkgData

    qunit:
      all: 'test/*.html'

    connect:
      tests:
        options:
          port: 8888
          base: ['.', 'test']
          open: 'http://localhost:8888'
          keepalive: true
          livereload: true

    watch:
      options:
        livereload: true
      files: '{src,test}/*.coffee'
      tasks: 'default'

    clean:
      prepare: '{build,dist,test}/*.{js,map}'

    coffee:
      compile:
        options:
          bare: true
          sourceMap: true
        files: [
          expand: true
          cwd: 'src'
          src: '*.coffee'
          dest: 'build/'
          ext: '.js'
        ,
          expand: true
          cwd: 'test'
          src: '*.coffee'
          dest: 'test'
          ext: '.js'
        ]

    concat:
      options:
        banner: "/*!<%=pkg.name%> ver.<%=pkg.version%> | <%=pkg.license%>*/ (function() {"
        footer: '}).call(this);'
        sourceMap: true
      dist:
        files:
          'dist/jquery.egen.js': 'build/*.js'

    uglify:
      options:
        banner: '/*!<%=pkg.name%> ver.<%=pkg.version%> | <%=pkg.license%>*/'
        sourceMap: true
        sourceMapIncludeSource: true
        sourceMapIn: 'dist/jquery.egen.js.map'
      build:
        files: [
          'dist/jquery.egen.min.js': 'dist/jquery.egen.js'
        ]

    closurecompiler:
      minify:
        files:
          'dist/jquery.egen.min.js': 'dist/jquery.egen.js'
        options:
          banner: '/*!<%=pkg.name%> ver.<%=pkg.version%> | <%=pkg.license%>*/'
          compilation_level: 'ADVANCED_OPTIMIZATIONS'
          externs: ['externs/jquery.js', 'externs/others.js', 'externs/egen.js']

  # loading dependencies for tasks
  for dep, _ of pkgData.devDependencies
    grunt.loadNpmTasks dep if dep isnt 'grunt' and /^grunt/.test dep

  grunt.registerTask 'build', ['clean', 'coffee', 'concat', 'closurecompiler']
  grunt.registerTask 'build_uglify', ['clean', 'coffee', 'concat', 'closurecompiler']

  grunt.registerTask 'default', ['build', 'qunit']
  grunt.registerTask 'test', ['build', 'connect:tests']
