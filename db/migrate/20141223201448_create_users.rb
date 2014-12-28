class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :profile_image_url
      t.string :nickname
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps null: false
    end
  end
end
