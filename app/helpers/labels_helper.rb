module LabelsHelper
  def label_color(color)
    if color == "緑"
      "color_green"
    elsif color == "青"
      "color_blue"
    elsif color == "赤"
      "color_red"
    elsif color == "オレンジ"
      "color_orange"
    end
  end
  def label_shape(shape, color)
    if shape == '楕円'
      "shape_ellipse"
    elsif shape == '四角'
      "shape_square"
    elsif shape == '矢印'
      if color == "緑"
        "shape_arrow_green"
      elsif color == "青"
        "shape_arrow_blue"
      elsif color == "赤"
        "shape_arrow_red"
      elsif color == "オレンジ"
        "shape_arrow_orange"
      end
    end
  end
end
