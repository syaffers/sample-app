class AddUploadPdfToPaper < ActiveRecord::Migration
  def up
    add_attachment :papers, :pdf
  end
  
  def down
    remove_attachment :papers, :pdf
  end
end
