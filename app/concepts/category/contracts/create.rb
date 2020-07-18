module Category::Contracts
  class Create < Reform::Form

    property :name
    property :flow

    validation do
      option :form

      schema do
        required(:name).filled(:str?, size?: 3..250)
        required(:flow).filled(:str?, included_in?: ['income', 'expense'])
      end

      rule(:name) do
        record = form.model

        if record.class.where.not(id: record.id).where(name: values[:name], flow: values[:flow], user: record.user).exists?
          key.failure('name is already in use')
        end
      end
    end
  end
end
