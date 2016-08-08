class QuestionsController < ApplicationController
  def index
    @survey = Survey.find(params[:survey_id])
    @question = Question.all
  end

  def new
    @survey = Survey.find(params[:survey_id])
    @question = Question.new
    @type = params[:question_type]
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @question = Question.new(question_params)

    if @question.save!
      flash[:success] = "Your question has been created!"
      redirect_to @survey
    else
      flash.now[:danger] = "Your question could not be created :("
      render :new
    end

    Option.create_options_from_range(@question,
                              min: params[:question][:min],
                              max: params[:question][:max],
                              step: params[:question][:step]) if @question.question_type == 1
  end

  def show
    @survey = Survey.find(params[:survey_id])
    @question = Question.find(params[:id])
  end

  def edit
    @survey = Survey.find(params[:survey_id])
    @question = Question.find(params[:id])
  end

  def update
    @survey = Survey.find(params[:survey_id])
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
    @survey = Survey.find(params[:survey_id])
    @question = Question.find(params[:id])
    if @question.destroy
      flash[:success] = "Your question has been deleted!"
      redirect_to @survey
    else
      render :show
    end
  end

  private

  def question_params
    p = params.require(:question).permit(:text, :question_type, :required)
    p[:survey_id] = params[:survey_id]
    p
  end
end
