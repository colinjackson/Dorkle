RSpec.shared_examples "a necessary and unique attribute" do |model, attribute|
  before { create(model) }

  it { should validate_presence_of(attribute) }
  it { should validate_uniqueness_of(attribute) }
end
