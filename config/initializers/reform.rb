require 'reform/form/dry'

Reform::Form.class_eval do
  feature Reform::Form::Dry
end

Rails.application.config.reform.validations = :dry
Rails.application.config.reform.enable_active_model_builder_methods = true

