require 'rails_helper'

describe 'Create' do
  it 'fails' do
    result = Category::Create.({ category: [], params: [] })
    expect(result).to be_failure
  end
end

