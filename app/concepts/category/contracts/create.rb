module Category::Contracts
  class Create < Reform::Form

    property :name
    property :flow


    validation name: :default, with: { form: true } do
      configure do
        def unique?(attr_name, value)
          byebug
        end
      end

      byebug
      params do
        required(:name).filled
        required(:flow).value(included_in?: [:income, :expense], unique?: :flow)
      end
    end
  end
end
