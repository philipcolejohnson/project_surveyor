class ResponsesController < ApplicationController
  def create
    @submission = Submission.new
    @survey = Survey.find(params[:survey_id].to_i)

    @submission.survey_id = @survey.id

    check_required

     if @submission.save
       flash[:success] = "Response successfully submitted!"
       redirect_to surveys_path
     else
       flash.now[:danger] = "Survey could not be submitted."
       render survey_questions_path(@survey)
     end

     save_results
  end

  private

  def save_results
    params[:survey].each do |question, option|
      Response.create!(submission_id: @submission.id,
                      question_id: question.to_i,
                      option_id: option.to_i)
    end
  end

  def check_required
    required_ids = []
    @survey.questions.select(:id).where(required: true).each do |item|
      required_ids << item.id
    end
    required_ids
  end
end
