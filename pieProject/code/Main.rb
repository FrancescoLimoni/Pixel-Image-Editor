$LOAD_PATH << '.'


require 'Canvas.rb'
require 'BrushPanel.rb'
require 'Menu'
require 'fox16'
require 'ColorPanel.rb'

include Fox

class EditorWindow < FXMainWindow
  
  def initialize(app)
    super(app, "Pixel Image Editor", :width => 700, :height => 700)
    addMenuBar
  end
  
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end


if __FILE__ == $0
  FXApp.new do |app|
    editor_window = EditorWindow.new(app)
    brush_window = BrushPanel.new(editor_window,LAYOUT_FIX_WIDTH | LAYOUT_FIX_HEIGHT,0,0,69,196)
    canvas_window = Canvas.new(editor_window, LAYOUT_SIDE_TOP|LAYOUT_FILL_X|LAYOUT_FILL_Y, 0, 0, 0, 0, 0, 0, 0, 0)
    color_window = ColorPanel.new(editor_window, LAYOUT_FIX_WIDTH | LAYOUT_FIX_HEIGHT | LAYOUT_CENTER_X , 0, 0, 176, 55)
    FXToolTip.new(app)
    app.create
    app.run
  end
end