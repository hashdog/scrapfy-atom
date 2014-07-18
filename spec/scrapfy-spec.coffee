{WorkspaceView} = require 'atom'
Scrapfy = require '../lib/scrapfy'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Scrapfy", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('scrapfy')

  describe "when the scrapfy:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.scrapfy')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'scrapfy:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.scrapfy')).toExist()
        atom.workspaceView.trigger 'scrapfy:toggle'
        expect(atom.workspaceView.find('.scrapfy')).not.toExist()
