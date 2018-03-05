class AddPaperclipToUniversities < ActiveRecord::Migration[5.0]
  def change
    add_attachment :universities, :profile_image
    add_attachment :universities, :cover_image
  end
end
