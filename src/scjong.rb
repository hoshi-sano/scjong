module Scjong
  class << self
    def init
      @current_scene = TitleScene.new
    end

    def run
      init

      Window.load_resources do
        Window.loop do
          @current_scene.play
        end
      end
    end
  end

  module Input
    class << self
      def mouse_push?
        DXOpal::Input.mouse_push?(DXOpal::M_LBUTTON)
      end

      def mouse_xy
        [DXOpal::Input.mouse_x, DXOpal::Input.mouse_y]
      end

      def touch?
        DXOpal::Input.touch_push?
      end

      def new_touches
        DXOpal::Input.new_touches.each do |t|
          yield(t)
        end
      end
    end
  end

  # TODO: ファイル分け
  class TouchCircle < DXOpal::Sprite
    SIZE = 10

    def initialize(x, y)
      img = Image.new(SIZE, SIZE)
      # TODO: デバッグモードのときのみ円を表示する
      img.circle_fill(SIZE/2, SIZE/2, (SIZE/2)-1, C_YELLOW)
      super(x, y, img)
      self.z = 999
    end

    def update
      prev = self.scale_x
      current = prev - 0.1

      if current <= 0
        self.vanish
      else
        self.scale_x = current
        self.scale_y = current
      end
    end
  end

  # TODO: ファイル分け
  class BaseScene
    def init
      @components = []
      generate_components
      @draw_components = @components.select { |c| c.respond_to?(:draw) }
    end

    def generate_components
    end

    def play
      update_components
      draw_components
      check_keys
    end

    def update_components
      @components.each(&:update)
      @components.delete_if(&:vanished?)
    end

    def draw_components
      @components.each(&:draw)
    end

    def check_keys
      if Input.mouse_push?
        @components << TouchCircle.new(*Input.mouse_xy)
      end

      Input.new_touches do |t|
        @components << TouchCircle.new(t.x, t.y)
      end
    end
  end

  class TitleScene < BaseScene
    def initialize
      init
      @bg = Sprite.new(0, 0, Image.new(Window.width, Window.height, C_GREEN))
    end

    def draw_components
      @bg.draw
      Window.draw_font(50, 50, "Hello Scjong!", Font.default, color: C_BLACK)
      super
    end
  end
end
