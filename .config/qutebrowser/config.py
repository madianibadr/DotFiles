# run on tor network
# c.content.proxy = 'socks5://localhost:9050/'

# dark mode
# config.set("colors.webpage.darkmode.enabled", True)

# using custom styles
# config.set("content.user_stylesheets", ["~/.config/qutebrowser/themes/dark_theme.css"])


# c.content.user_stylesheets = [
#     './themes/solarized-dark.css',
#     './themes/custom_solarized.css'
# ]

# Disable Auto-Completion for URLs
c.completion.web_history.max_items = 0



# Disable session saving, so no browsing history is retained
c.auto_save.session = False

# clear cookies after the browser is closed
# c.content.cookies.store = False

config.bind('<Ctrl-h>', 'fake-key <Backspace>', 'insert')
config.bind('<Ctrl-j>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl-k>', 'completion-item-focus prev', mode='command')
# Opens vim to edit current text
config.bind('<Ctrl+e>', 'edit-text')

# Aliase
c.aliases['w'] = 'session-save'
c.aliases['wq'] = 'quit --save'

# Enable private browsing mode to reduce cache usage
c.content.private_browsing = False

# Disable auto-playing of videos
c.content.autoplay = False

# Limit the number of open tabs
c.tabs.last_close = 'close'

### appearance

# hide tabs when only one tab
c.tabs.show = 'multiple'

#hide status bar
c.statusbar.show = 'in-mode'

#disable webgl
c.content.webgl = False

#limit history
c.history_gap_interval = 10

### calling userscripts
#yt_download
config.bind('<Alt-d>', 'spawn --userscript yt_download')

# Zoom In
config.bind('<Alt+Shift+J>', 'zoom-in')
# Zoom Out
config.bind('<Alt+Shift+K>', 'zoom-out')



# Move tab to the right
config.bind('<Ctrl+Shift+J>', 'tab-move +')

# Move tab to the left
config.bind('<Ctrl+Shift+K>', 'tab-move -')

#sets vim as the editor
c.editor.command = ["st", "-e", "nvim", "{}"]

#edit-url command
config.bind('E', 'edit-url')

#websites shortcuts
config.bind('aa', 'open -t https://myanimelist.net')
config.bind('wx', 'open -t https://youtube.com')
config.bind('ww', 'open -t https://www.w3schools.com/python')
config.bind('xx', 'open -t https://web.whatsapp.com')
config.bind('wc', 'open -t https://chatgpt.com/')

#spawn photos feh
config.bind('go', 'hint images run :spawn feh {hint-url}')

# config.bind('gv', 'hint links spawn mpv {hint-url}')
config.bind('gv', 'hint links spawn mpv --ytdl-format="bestvideo[height<=720]+bestaudio/best[height<=720]" {hint-url}')

# Change the argument to True to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

config.set('content.cookies.accept', 'never', 'chrome-devtools://*')

config.set('content.cookies.accept', 'never', 'devtools://*')

config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')

config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# Allow locally loaded documents to access remote URLs.
# Type: Bool
config.set('content.local_content_can_access_remote_urls', True, 'file:///home/sumida/.local/share/qutebrowser/userscripts/*')

# Allow locally loaded documents to access other local URLs.
# Type: Bool
config.set('content.local_content_can_access_file_urls', False, 'file:///home/sumida/.local/share/qutebrowser/userscripts/*')

# Allow websites to show notifications.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.notifications.enabled', False, 'https://www.facebook.com')

# Allow websites to register protocol handlers via
# `navigator.registerProtocolHandler`.
# Type: BoolAsk
# Valid values:
#   - true
#   - false
#   - ask
config.set('content.register_protocol_handler', False, 'https://mail.google.com?extsrc=mailto&url=%25s')

c.url.searchengines = {
    'DEFAULT':  'https://duckduckgo.com/?ia=web&q={}',
    'gm':       'https://www.google.com/search?tbm=isch&q={}&tbs=imgo:1',
    'g':        'https://google.com/search?q={}',
    'm':        'https://www.google.com/maps/search/{}',
    'dd':       'https://thefreedictionary.com/{}',
    'e':        'https://www.ebay.com/sch/i.html?_nkw={}',
    'gh':       'https://github.com/search?o=desc&q={}&s=stars',
    '!gist':    'https://gist.github.com/search?q={}',
    '!p':       'https://pry.sh/{}',
    'r':        'https://www.reddit.com/search?q={}',
    '!w':       'https://en.wikipedia.org/wiki/{}',
    'yt':       'https://www.youtube.com/results?search_query={}',
    'mal':      'https://myanimelist.net/search/all?q={}&cat=all',
    'market':   'https://www.facebook.com/marketplace/casablanca/search?query={}',
    'ar':       'https://archive.org/search?query={}',
}
