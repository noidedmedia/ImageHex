json.images @images, partial: "stub", as: :image
json.current_page @images.current_page
json.per_page @images.per_page
json.total_pages @images.total_pages
json.total_images @images.count
