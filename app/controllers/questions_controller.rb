class QuestionsController < ApplicationController
  def index
    @survey = Survey.includes(questions: :options).find(params[:survey_id])
    @questions = @survey.questions
  end

  def new
    @survey = Survey.includes(questions: :options).find(params[:survey_id])
    @question = Question.new
    @type = params[:question_type]
  end

  def create
    @survey = Survey.find(params[:survey_id])
    @question = Question.new(question_params)

    if @question.save
      flash[:success] = "Your question has been created!"
      if params[:question][:question_type] == "1"
        redirect_to @survey
      else
        redirect_to edit_survey_question_path(@survey,
                    @question,
                    num_answers: params[:question][:num_answers])
      end
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
    @survey = Survey.includes(questions: :options).find(params[:survey_id])
    @question = Question.find(params[:id])
  end

  def edit
    @survey = Survey.includes(questions: :options).find(params[:survey_id])
    @question = Question.find(params[:id])
    @type = @question.question_type.to_s

    if @type == "2"
      (params[:num_answers].to_i + 1).times do
        @question.options.build
      end
    end
  end

  def update
    @survey = Survey.find(params[:survey_id])
    @question = Question.find(params[:id])

    Option.update_options_from_range(@question,
                              min: params[:question][:min],
                              max: params[:question][:max],
                              step: params[:question][:step]) if @question.question_type == 1

    if @question.update(question_params)
      flash[:success] = "Your question has been updated!"
      redirect_to @survey
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
    p = params.require(:question).
    permit(:text, :question_type, :required,
          { options_attributes: [
              :text,
              :id,
              :_destroy
          ] } )

    p[:survey_id] = params[:survey_id]
    p
  end
end
