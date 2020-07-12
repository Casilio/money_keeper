require 'reform'
require 'reform/form/dry'

module Category::Contracts
  class Create < Reform::Form
    include Dry

    property :name
    property :flow

    validation do
      required(:name).filled
      required(:flow).value(included_in?: [:income, :expense])
    end
  end
end
