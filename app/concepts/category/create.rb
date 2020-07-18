class Category
  class Create < Trailblazer::Operation
    step Model(Category, :new)
    step :assign_current_user!
    step Contract::Build(constant: Category::Contracts::Create)
    step Contract::Validate()
    step Contract::Persist()

    def assign_current_user!(options, model:, **params)
      model.user = options[:current_user]
    end
  end
end

