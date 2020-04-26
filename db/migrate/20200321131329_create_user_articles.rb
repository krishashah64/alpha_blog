class CreateUserArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_articles do |t|
    	t.belongs_to :user
    	t.belongs_to :article
    end
  end
end
