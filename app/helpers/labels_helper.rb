module LabelsHelper
  def label_color(color)
    if color == 0
      "color_green"
    elsif color == 1
      "color_blue"
    elsif color == 2
      "color_red"
    end
  end
  def label_shape(shape)
    if shape == 0
      "shape_ellipse"
    elsif shape == 1
      "shape_square"
    elsif shape == 2
      "shape_arrow"
    end
  end
end
