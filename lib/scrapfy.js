'use babel';

import https from 'https';
import { CompositeDisposable } from 'atom';

var langsMap = {
  'text.plain': 'plain_text',
  'source.shell': 'sh',
  'c++': 'c_cpp',
  'source.coffee': 'coffee',
  // 'csharp': 'c_sharp',
  'source.css': 'css',
  'source.go': 'golang',
  'text.html.basic': 'html',
  'text.html.ruby': 'html_ruby',
  'text.html.erb': 'html_ruby',
  'source.java': 'java',
  'source.js': 'javascript',
  'source.json': 'json',
  'source.perl': 'perl',
  'text.html.php': 'php',
  'source.python': 'python',
  'source.ruby': 'ruby',
  'source.ruby.rails': 'ruby',
  'source.sql': 'sql',
  // '': 'stylus',
  'text.xml': 'xml',
  'source.yaml': 'yaml'
};

export default {

  subscriptions: null,

  activate(state) {
    this.subscriptions = new CompositeDisposable();
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'scrapfy:create': () => this.create()
    }));
  },

  deactivate() {
    this.subscriptions.dispose();
  },

  serialize() {},

  post(data) {
    var options = {
      protocol: 'https:',
      hostname: 'api.scrapfy.io',
      path: '/scraps',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'SCRAPfy Atom'
      }
    };

    var that = this;
    var request = https.request(options, function (res) {
      var body = '';

      res.setEncoding('utf8');

      res.on('data', function (chunk) {
        body += chunk;
      });

      res.on('end', function () {
        var response = JSON.parse(body);

        atom.clipboard.write(response.url);
        atom.notifications.addSuccess('Your SCRAPfy URL is in your clipboard!');
      });
    });

    request.write(JSON.stringify(data));
    request.end();
  },

  create() {
    var editor = atom.workspace.getActiveTextEditor();
    var grammar = editor.getGrammar().scopeName;
    var selection = editor.getSelectedText();
    var allText = editor.getText();

    var content = selection ? selection : allText;
    var lang = langsMap[grammar];

    this.post({
      content: content,
      lang: lang
    });
  }

};
