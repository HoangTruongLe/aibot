FactoryBot.define do
  factory :session_statistic do
		session_key SecureRandom.hex
  end
end
