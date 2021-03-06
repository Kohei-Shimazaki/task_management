class LabelsController < ApplicationController
  before_action :set_label, only: %i[show edit update destroy]

  def index
    @labels = current_user.labels
  end
  def new
    @label = Label.new
  end
  def edit
  end
  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      flash[:notice] = "ラベルを作成しました！"
      redirect_to labels_path
    else
      render :new
    end
  end
  def update
    if @label.update(label_params)
      flash[:notice] = "ラベルを編集しました！"
      redirect_to labels_path
    else
      render :edit
    end
  end
  def destroy
    @label.destroy
    flash[:notice] = "ラベルを削除しました！"
    redirect_to labels_url
  end

  private
  def set_label
    @label = Label.find(params[:id])
  end
  def label_params
    params.require(:label).permit(:title, :color, :shape)
  end
end
