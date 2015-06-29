module.exports =
class ScrapfyView
  constructor: (serializedState) ->

    # Create root element
    @element = document.createElement('div')
    @element.classList.add('scrapfy')
    @element.classList.add('inline-block')

    # Create message element
    message = document.createElement('div')
    message.textContent = "The MyPackage package is Alive! It's ALIVE!"
    message.classList.add('message')
    @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  attach: (url) ->
    statusbar = atom.workspaceView.statusBar
    statusbar.appendLeft this
    @html("SCRAPfy's URL has been copied to your clipboard: <a href='#{url}'>#{url}</a>")
