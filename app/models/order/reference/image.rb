class Order::Reference::Image < ActiveRecord::Base
  belongs_to :reference,
    class_name: "Order::Reference",
    foreign_key: :order_reference_id

  has_attached_file :img,
    styles: {
      small: "140x140>",
      medium: "300x300>",
      large: "500x500>"
    },
    path: ($REF_PATH ? $REF_PATH : "ref_images/:id_:style.:extension")

    validates_attachment :img,
                       content_type: { content_type: %r{\Aimage\/.*\Z} },
                       presence: true

    validates :description, presence: true
end
