class AddSurveyIdToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :survey_id, :integer
  end
end
