class Order::Group::Image < ActiveRecord::Base
  belongs_to :reference_group,
    class_name: "Order::ReferenceGroup",
    foreign_key: :order_reference_group_id,
    inverse_of: :images

  has_attached_file :img,
    styles: {
      small: "140x140>",
      medium: "300x300>",
      large: "500x500>"
    },
    path: ($REF_PATH ? $REF_PATH : "ref_images/:id_:style.:extension")

    process_in_background :img, 
      processing_image_url: :processing_image_fallback


    validates_attachment :img,
                       content_type: { content_type: %r{\Aimage\/.*\Z} },
                       presence: true

    def processing_image_fallback
      options = img.options
      options[:interpolator].interpolate(options[:url], img, :original)
    end

end
