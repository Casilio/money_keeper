class AddDateAndDescriptionToCash < ActiveRecord::Migration[5.1]
  def change
  	add_column :cashes, :event_date, :date, default: Time.zone.now
  	add_column :cashes, :description, :string
  end
end
