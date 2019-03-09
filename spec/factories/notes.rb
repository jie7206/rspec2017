FactoryBot.define do
  factory :note do
    message "My test note."
    association :project
    user {project.owner}
  end
end
