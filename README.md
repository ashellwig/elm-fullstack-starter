# MEEN-stack (Mongo, Elm, Express, Node) starter package

**Elm** (0.18) fullstack starter package with Pug (formerly Jade), Sass, Browser-sync and a Node-Express backend.

## Serverless

Don't need the node server?  No problem, delete /server and run the 'serverless' scripts

## Use, install and run...:

```
git clone https://github.com/simonh1000/elm-fullstack-starter
npm install
# the line above should complete by calling elm-package install, otherwise do manually

npm start       // == gulp    (if you get compile errors with npm start, just use gulp directly)

npm production  // == gulp build

npm compile     // == gulp compile

npm serverless  // == gulp serverless
```

Client side files are compiled into, and served from, './dist'.

<!-- ## Hotloading!!!!
See my [Webpack starter](https://github.com/simonh1000/elm-hot-loader) -->

## Want to try Elm with Elixir / Phoenix?
See my [blog](http://simonh1000.github.io/2016/10/elm-phoenix-gulp/)
