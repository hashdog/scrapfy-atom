http = require 'http'
Clipboard = require 'clipboard'
ScrapfyView = require './scrapfy-view'

langsMap =
  'text.plain': 'plain_text'
  'source.shell': 'sh'
  'c++': 'c_cpp'
  'source.coffee': 'coffee'
  # 'csharp': 'c_sharp'
  'source.css': 'css'
  'source.go': 'golang'
  'text.html.basic': 'html'
  'text.html.ruby': 'html_ruby'
  'text.html.erb': 'html_ruby'
  'source.java': 'java'
  'source.js': 'javascript'
  'source.json': 'json'
  'source.perl': 'perl'
  'text.html.php': 'php'
  'source.python': 'python'
  'source.ruby': 'ruby'
  'source.ruby.rails': 'ruby'
  'source.sql': 'sql'
  # '': 'stylus'
  'text.xml': 'xml'
  'source.yaml': 'yaml'

module.exports =
  activate: (state) ->
    atom.workspaceView.command 'scrapfy:create', => @create()

  post: (data)->
    options =
      hostname: 'api.scrapfy.io'
      path: '/scraps'
      method: 'POST'
      headers:
        'Content-Type': 'application/json',
        'User-Agent': 'Atom'

    request = http.request options, (res) ->
      res.setEncoding 'utf8'
      body = ''

      res.on 'data', (chunk) ->
        body += chunk

      res.on 'end', ->

        response = JSON.parse(body)
        Clipboard.writeText response.url
        scrapfyView = new ScrapfyView(response.url)

        setTimeout (->
          scrapfyView.destroy()
        ), 5000


    request.write(JSON.stringify(data))
    request.end()

  create: ->
    editor = atom.workspace.getActiveEditor()
    grammar = editor.getGrammar().scopeName
    selection = editor.getSelectedText()
    allText = editor.getText()

    content = (if selection then selection else allText)
    lang = langsMap[grammar]

    @post(
      content: content
      lang: lang
    )
