class Category
  class Create < Trailblazer::Operation
    step Model(Category, :new)
    step Contract::Build(constant: Category::Contracts::Create)
    step Contract::Validate()
    step :persist!

#    contract do
#      property :Name
#      property :flow
#
#      validates :name,
#        presence: true,
#        length: { minumum: 3, maximum: 250 }
#
#      validates :flow,
#        presence: true,
#        uniqueness: { scope: [:user_id, :flow], message: 'name already in use' }
#    end

    def persist!(options, model:, **)
      model.save
    end
  end
end

