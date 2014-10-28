RSpec.shared_examples "a necessary and unique attribute" do |attribute|
  it { should validate_presence_of(attribute) }
  it { should validate_uniqueness_of(attribute) }
end
