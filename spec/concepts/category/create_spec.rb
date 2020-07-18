require 'rails_helper'

describe Category::Create do
  let(:user) { create(:user) }

  context 'when params are valid' do
    it 'creates new category' do
      result = Category::Create.(params: { name: 'salary', flow: 'income' }, current_user: user)

      expect(result).to be_truthy
      expect(result[:model].persisted?).to be_truthy
      expect(result[:model].user).to eq(user)
    end
  end

  context 'when user is not provided' do
    it 'fails' do
      result = Category::Create.(params: { name: 'salary', flow: 'income' })

      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey
    end
  end

  context 'when flow is abnsent'  do
    it 'fails' do
      result = Category::Create.(params: { name: 'salary' }, current_user: user)

      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey

      errors = result['contract.default'].errors[:flow]
      expect(errors).to include 'must be filled'
      expect(errors).to include 'must be one of: income, expense'
    end
  end

  context 'when flow is invalid' do
    it 'fails' do
      result = Category::Create.(params: { name: 'salary', flow: 'invalid' }, current_user: user)

      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey

      errors = result['contract.default'].errors[:flow]
      expect(errors.length).to eq(1)
      expect(errors.first).to eq('must be one of: income, expense')
    end
  end

  context 'when name is absent' do
    it 'fails' do
      result = Category::Create.(params: { flow: 'invalid' }, current_user: user)

      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey

      errors = result['contract.default'].errors[:name]
      expect(errors).to include 'must be filled'
      expect(errors).to include 'size must be within 3 - 250'
    end
  end

  context 'when name is too short/long' do
    it 'fails' do
      result = Category::Create.(params: { name: 'a', flow: 'invalid' }, current_user: user)

      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey

      errors = result['contract.default'].errors[:name]
      expect(errors.length).to eq(1)
      expect(errors.first).to eq('length must be within 3 - 250')
    end

    it 'fails' do
      result = Category::Create.(params: { name: 'a' * 251, flow: 'invalid' }, current_user: user)

      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey

      errors = result['contract.default'].errors[:name]
      expect(errors.length).to eq(1)
      expect(errors.first).to eq('length must be within 3 - 250')
    end
  end

  context 'when category with same name & flow is already exists' do
    before(:each) do
      Category::Create.(params: { name: 'salary', flow: 'income' }, current_user: user)
    end

    it 'fails' do
      result = Category::Create.(params: { name: 'salary', flow: 'income' }, current_user: user)

      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey

      errors = result['contract.default'].errors[:name]
      expect(errors.length).to eq(1)
      expect(errors.first).to eq('name is already in use')
    end

    context 'for different user' do
      let(:other_user) { create(:user, email: 'othe@test.com') }

      it 'create a category' do
        result = Category::Create.(params: { name: 'salary', flow: 'income' }, current_user: other_user)

        expect(result).to be_truthy
        expect(result[:model].persisted?).to be_truthy
      end
    end
  end
end

