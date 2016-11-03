# Elm development environment with gulp and live reloading

**Elm** (0.17) development environment including:

 - automatic recompilation of Elmm code
 - Pug (formerly Jade),
 - Sass,
 - Node-Express server (optional)
 - Browser-sync and a Node-Express backend.

## fullstack - MEEN-stack (Mongo, Elm, Express, Node) starter package

Fullstack starter package with a Node-Express backend.

It is also possible to use the compilation functions *without* the node server.

To use, install and run...:

```
git clone https://github.com/simonh1000/elm-fullstack-starter
npm install
# includes installation of Elm packages (i.e. `elm-package install -y`)

npm start       // == gulp

npm production  // == gulp build --production

npm compile     // == gulp compile

npm serverless  // == gulp serverless
```

Client side files are compiled into, and served from, './dist'.

## Want to try Elm with Elixir / Phoenix?
See my [blog](http://simonh1000.github.io/2016/10/elm-phoenix-gulp/)

## TODO

 - incorporate elm-bundle
 - 0.18 : elm-make --debug, when supported by gulp-elm
