class New < ApplicationRecord

  # Returns well formatted date.
  def date
    self.created_at.strftime("%d-%m-%Y")
  end

  # Returns string with base64 image for injection in html.
  def encoded_picture
    "data:image/#{self.extension};base64,#{File.open('public/images/news/' + self.picture,'rb').read}"
  end


end
