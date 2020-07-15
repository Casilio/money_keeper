module Category::Contracts
  class Create < Reform::Form

    property :name
    property :flow

    validation name: :default, with: { form: true } do
      configure do
        def unique?(attr_name, value)
          # TODO
        end
      end

      params do
        required(:name).filled
        required(:flow).value(included_in?: [:income, :expense])
      end
    end
  end
end
