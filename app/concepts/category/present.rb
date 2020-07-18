class Category
  class Present < Trailblazer::Operation
    step Model(Category, :new)
    step Contract::Build(constant: Category::Contracts::Present)
  end
end

