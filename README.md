# Server Router
Simple server-side routing.

[![Circle CI](https://circleci.com/gh/Respondly/meteor-router-server.svg?style=svg)](https://circleci.com/gh/Respondly/meteor-router-server)

## Example
Registering routes is analagous to how this is done within **Express.js**.

```coffeescript
Server.get '*', (req, res) ->
      false # False to continue ("not handled").


Server.get '/server/send/404', (req, res) -> res.send 404
Server.get '/server/send/404-not-found', (req, res) -> res.send 404, 'Sorry, not found.'
Server.get '/server/send/html', (req, res) -> res.send "<h1>Some HTML</h1>"
Server.get '/server/send/json', (req, res) -> res.send { foo:'json' }



Server.get '/server/render/jade/:id', (req, res) ->
  file = 'path/to/html.jade'
  title = "My Title - #{ req.params.id }"
  res.render file, { pageTitle:title, youAreUsingJade:true }



Server.get '/server/render/css/:sheet', (req, res) ->
  file = "path/to/css/#{ req.params.sheet }.styl"
  res.render(file)

```







## License (MIT)

Copyright © 2015, **Respondly**

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
