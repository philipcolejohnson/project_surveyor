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
  end

  def self.update_options_from_range(question, min:, max:, step: 1)
    min = min.to_i
    max = max.to_i
    step = step.to_i

    options = []
    question_options = Question.includes(:options).find(question.id).options
    question_options.each do |option|
      options << option.text.to_i
    end

    count = min
    until count > max
      Option.create(text: count, question_id: question.id) unless options.include?(count)
      count += step
    end

    question_options.each do |option|
      option.destroy if option.text.to_i < min || option.text.to_i > max
    end
    
  end

end
