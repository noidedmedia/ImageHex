module FileHelper
  def test_image_path
    Rails.root.join("spec", "fixtures", "files", "test.jpg")
  end
end
