puts "-----------User-----------"
20.times do |n|
  name  = Faker::Name.name
  email = "user#{n+1}@user.com"
  password = "12345678"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password
  )
end
puts "----------Event-------"
10.times do |n|
  event = Event.create!(
    name: "event-#{n+1}",
    user: User.all.sample,
    starts_on: Faker::Time.forward(10),
    degit_code: n + 1
  )
puts "-------Role------"
  3.times do |n|
    puts "-------Participant------"
    15.times do |n|
      participant = Participant.create!(
        name: Faker::Name.name,
        event: event,
        is_admin: true
      )
    end
  end
end

10.times do |n|
  note = Note.create!(
      title: "note-#{n+1}",
      content: "note-#{n+1}",
      event: Event.first,
      starts_on: Faker::Time.forward(2),
      active: true
  )
end
10.times do |n|
  question = Question.create!(
    title: "question-#{n+1}",
    content: Faker::Lorem.question,
    event: Event.first,
    starts_on: Faker::Time.forward(1),
    active: true
  )
  4.times do |n|
    answer = Answer.create!(
        content: question.content + "answer #{n}",
        question: question,
        participant: Event.first.participants.sample
    )
  end
end

10.times do |n|
  poll = Poll.create!(
    title: "poll-#{n+1}",
    content: Faker::Lorem.question,
    event: Event.first,
    starts_on: Faker::Time.forward(1),
    multi_vote: 1,
    active: true
  )
  4.times do |n|
    Option.create!(
        content: poll.content + "answer #{n}",
        poll: poll,
    )
  end
end
