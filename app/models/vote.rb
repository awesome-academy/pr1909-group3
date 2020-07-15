class Vote < ApplicationRecord
  belongs_to :option
  belongs_to :participant
  counter_culture :option

  after_create_commit do
    option_poll = option.poll
    data = {
      poll: option_poll,
      options: option_poll.options.to_a
    }
    PollUpdateJob.perform_later(data)
  end
end
