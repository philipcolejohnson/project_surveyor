class Option < ApplicationRecord
  belongs_to :question

  def self.create_options_from_range(question, min:, max:, step: 1)
    min = min.to_i
    max = max.to_i
    step = step.to_i

    count = min
    # options = []
    until count > max
      Option.create(text: count, question_id: question.id)
      # array << count
      count += step
    end
    array
  end

end
