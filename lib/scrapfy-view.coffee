{View} = require 'atom'

module.exports =
class ScrapfyView extends View
  @content: ->
    @div class: 'scrapfy inline-block'

  initialize: (url) ->
    @attach(url)

  serialize: ->

  destroy: ->
    @detach()

  attach: (url) ->
    statusbar = atom.workspaceView.statusBar
    statusbar.appendLeft this
    @html("SCRAPfy's URL has been copied to your clipboard: <a href='#{url}'>#{url}</a>")
