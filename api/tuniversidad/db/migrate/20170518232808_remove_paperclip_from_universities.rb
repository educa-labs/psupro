class RemovePaperclipFromUniversities < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :universities, :profile_image
    remove_attachment :universities, :cover_image
  end
end
