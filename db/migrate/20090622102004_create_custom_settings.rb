class CreateCustomSettings < ActiveRecord::Migration
  def self.up
    create_table :custom_settings do |t|
      t.string :config_key
      t.string :config_value
    end
  end

  def self.down
    drop_table :custom_settings
  end

end
