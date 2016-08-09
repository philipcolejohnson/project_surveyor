# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Survey.destroy_all

SCALE = 3

SCALE.times do
  Survey.create!(title: Faker::Hipster.word.capitalize, description: Faker::ChuckNorris.fact)
end
puts "#{Survey.count} surveys created."

Survey.all.each do |survey|
  # range questions
  2.times do
    q = Question.create!(question_type: 1, text: Faker::StarWars.quote[0..-2] + "?", required: false, survey_id: survey.id)
    4.times do |count|
      Option.create!(text: count + 1, question_id: q.id)
    end
  end

  # multiple choice
  2.times do
    q = Question.create!(question_type: 2, text: Faker::StarWars.quote[0..-2] + "?", required: false, survey_id: survey.id)
    4.times do
      Option.create!(text: Faker::Beer.name, question_id: q.id)
    end
  end
  puts "#{survey.questions.count} questions created."
end

# add an empty survey
Survey.create!(title: Faker::Hipster.word.capitalize, description: Faker::ChuckNorris.fact)
