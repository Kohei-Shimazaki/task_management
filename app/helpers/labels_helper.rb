module LabelsHelper
  def label_color(label)
    if label.green?
      "color_green"
    elsif label.blue?
      "color_blue"
    elsif label.red?
      "color_red"
    elsif label.orange?
      "color_orange"
    end
  end
  def label_shape(label)
    if label.ellipse?
      "shape_ellipse"
    elsif label.square?
      "shape_square"
    elsif label.arrow?
      if label.green?
        "shape_arrow_green"
      elsif label.blue?
        "shape_arrow_blue"
      elsif label.red?
        "shape_arrow_red"
      elsif label.orange?
        "shape_arrow_orange"
      end
    end
  end
end
