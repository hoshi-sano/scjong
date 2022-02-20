require 'dxopal'
include DXOpal

Window.width = 1134
Window.height = 640
Window.bgcolor = C_BLACK

require_remote "src/scjong.rb"

Scjong.run
