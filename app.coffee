express = require('express')
coffeeMiddleware = require('coffee-middleware')
app = express()
imjs = require 'imjs'
Q = require 'q'
_ = require 'underscore'

mines = [
  {name: "yeastmine", url: "http://yeastmine.yeastgenome.org/yeastmine"}
  {name: "flymine", url: "http://www.flymine.org/query"}
  {name: "mousemine", url: "http://www.mousemine.org/mousemine"}
  {name: "ratmine", url: "http://ratmine.mcw.edu/ratmine"}
  {name: "zfin", url: "http://www.zebrafishmine.org"}
]


app.set 'views', __dirname + '/public'

app.use express.static(__dirname + '/public')

app.use coffeeMiddleware(
  src: __dirname + '/public'
  compress: true)

app.use express.static(__dirname + '/public')

app.use '/bower_components', express.static(__dirname + '/bower_components')

app.get '/', (request, response) ->
  response.render 'index.html'

app.get '/mines', (request, response) ->
  response.send JSON.stringify mines

app.get '/models', (req, res) ->

  ps = (new imjs.Service(root: mine.url).fetchModel() for mine in mines)

  Q.all(ps).then (immodels) ->

    classes = {}

    for immodel in immodels

      # Get the mine name based on the URL
      index = immodel.service.root.indexOf("/service/")
      root = immodel.service.root.substring 0, index
      {name} = _.findWhere mines, {url: root}

      for imclass, values of immodel.classes

        classes[imclass] ?= {}

        for attribute, value of values.attributes

          classes[imclass][attribute] ?= []
          classes[imclass][attribute].push name

    res.send classes

port = process.env.PORT or 5000

app.listen port, -> console.log 'Listening on ' + port
