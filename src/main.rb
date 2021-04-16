require 'dxopal'
include DXOpal

Window.width = 1134
Window.height = 640
Window.load_resources do
  Window.bgcolor = C_BLACK

  Window.loop do
    Window.draw_font(0, 0, "Hello!", Font.default, color: C_WHITE)

    box_width = 50
    box_height = 50
    left_x = 50
    right_x = Window.width - 50 - box_width
    top_y = 50
    bottom_y = Window.height - 50 - box_height
    [
      [left_x, top_y],
      [left_x, bottom_y],
      [right_x, top_y],
      [right_x, bottom_y],
    ].each do |x, y|
      Window.draw_box_fill(x, y, x + box_width, y + box_height, C_WHITE)
    end
  end
end
