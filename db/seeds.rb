class Seed

  def self.start
    seed = Seed.new
    # seed.generate_roles
    # seed.generate_users
    # seed.generate_categories
    # seed.generate_user_questions
    # seed.generate_user_answers
    seed.generate_question_comments
    seed.generate_answer_comments
    # seed.generate_admin
  end

  def generate_roles
    Role.create(name: 'registered_user')
    Role.create(name: 'admin')
    puts "Generated registered_user and admin roles"
  end

  def generate_users
    puts "Generating Users"
    1000.times do |i|
      User.create!(name:     Faker::Name.unique.first_name,
                  email:     Faker::Internet.free_email,
                  password:  "password",
                  phone:     Faker::Base.numerify('###-###-####'),
                  image:     Faker::Avatar.image)
      User.last.user_roles.create(role_id: Role.find_by(name: 'registered_user').id)
      puts "Generated User: #{User.last.name} as #{User.last.roles.first.name}"
    end
  end

  def generate_categories
    puts "Generating Categories"
    20.times do |i|
      Category.create!(name: Faker::Hipster.word)
      puts "Generated Category: #{Category.last.name}"
    end
  end

  def generate_user_questions
    User.all.each do |user|
      5.times do |i|
        user.questions.create!(title:    Faker::Hipster.sentence,
                              body:     Faker::Hipster.paragraph,
                              category: Category.find(Random.new.rand(1..20)))
        puts "Generated Question #{user.questions.count} for #{user.name}"
      end
    end
  end

  def generate_user_answers
    User.all.each do |user|
      5.times do |i|
        user.answers.create!(body:     Faker::Hipster.paragraph,
                            question: Question.find(Random.new.rand(1..5000)))
        puts "Generated Answer #{user.answers.count} for #{user.name}"
      end
    end
  end

  def generate_question_comments
    Question.all.each do |question|
        question.comments.create!(body:     Faker::Hipster.paragraph,
                                  user_id:  User.find(Random.new.rand(1..1000)).id)
      puts "Generated #{question.comments.count} comment for #{question.title}"
    end
  end

  def generate_answer_comments
    Answer.all.each do |answer|
        answer.comments.create!(body:     Faker::Hipster.paragraph,
                                user_id:  User.find(Random.new.rand(1..1000)).id)
      puts "Generated #{answer.comments.count} comment for #{answer.question.title}"
    end
  end

  def generate_admin
    User.create!(name:     'admin',
                email:     Faker::Internet.free_email,
                password:  "password",
                phone:     Faker::Base.numerify('###-###-####'),
                image:     Faker::Avatar.image)
    User.last.user_roles.create(role: Role.last)
    puts "Generated #{User.last.name} as #{User.last.roles.first.name}"
  end
end

Seed.start
