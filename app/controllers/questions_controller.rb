class QuestionsController < ApplicationController
  def index
    @question = Question.all
  end

  def new
    @survey = Survey.find(params[:survey_id])
    @question = Question.new
    @type = params[:type]
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Your question has been created!"
      redirect_to @question
    else
      flash.now[:danger] = "Your question could not be created :("
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update
      flash[:success] = "Your question has been updated!"
      redirect_to @question
    else
      flash.now[:danger] = "Your question could not be updated :("
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:success] = "Your question has been destroyed!"
      redirect_to questions_path
    else
      render :show
    end
  end

  private

  def question_params
    params.require(:question).permit(:text, :type, :required)
  end
end
