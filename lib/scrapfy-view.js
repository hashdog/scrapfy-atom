'use babel';

export default class ScrapfyView {

  constructor(serializedState) {
    // Create root element
    this.element = document.createElement('div');
    this.element.classList.add('scrapfy');
  }

  // Returns an object that can be retrieved when package is activated
  serialize() {}

  // Tear down any state and detach
  destroy() {
    this.element.remove();
  }

  getElement() {
    return this.element;
  }

  // attach(url) {
  //   statusbar = atom.workspaceView.statusBar
  //   // statusbar.appendLeft this
  //   this.html("SCRAPfy's URL has been copied to your clipboard: <a href='#{url}'>#{url}</a>")
  // }

}
