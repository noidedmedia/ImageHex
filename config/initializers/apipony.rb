require 'json'

Apipony::Documentation.define do
  config do |c|
    c.title = 'ImageHex API Documentation'
    c.base_url = '/'
  end
  subtype :collection_stub do
    attribute :name, type: :string,
      example: "Test's Favorites"
    attribute :id, type: :integer,
      example: 20
    attribute :type, type: :enum do
      choice :Subjective
      choice :Favorite
    end
    attribute :url, type: :url,
      example: "/collections.4.json"
  end

  subtype :user_stub do
    attribute :name, type: :string,
      example: "tony",
      description: "This user's name"
    attribute :id, type: :integer, example: 10
    attribute :slug, type: :string,
      example: "test",
      description: %{The slug for this users's name. You can then access their
      user page at /@:slug}
    attribute :avatar_path, type: :string,
      description: "A URL for the user's avatar",
      example: "http://i.imagehex.com/default-avatar.svg"
  end

  subtype :image_stub do
    attribute :id, type: :integer, example: 1
    attribute :description, type: :string, example: "An image"
    attribute :user_id, type: :integer,
      description: "The uploader ID",
      example: 10
    attribute :created_at, type: :date,
      example: "2015-11-21T19:01:27.751Z"
    attribute :updated_at, type: :date,
      example: "2015-11-21T19:01:27.751Z"
    attribute :license, type: :enum do
      choice :public_domain
      choice :all_rights_reserved
      choice :cc_by
      choice :cc_by_sa
      choice :cc_by_nd
      choice :cc_by_nc
      choice :cc_by_nd_sa
      choice :cc_by_nc_nd
    end
    attribute :medium, type: :enum do
      choice :photograph
      choice :pencil
      choice :paint
      choice :digital_paint
      choice :mixed_media
      choice :three_dimensional_render
    end
    attribute :url, type: :string,
      description: "The URL for this image",
      example: "https://www.imagehex.com/images/3"
    attribute :original_size, type: :url,
      example: "https://i.imaghex.com/1_original.png"
    attribute :nsfw_gore, type: :boolean, example: true
    attribute :nsfw_language, type: :boolean, example: true
    attribute :nsfw_nudity, type: :boolean, example: true
    attribute :nsfw_sexuality, type: :boolean, example: true
  end
  subtype :image_collection do
    attribute :current_page, type: :integer,
      example: 1
    attribute :per_page, type: :integer,
      example: 20
    attribute :total_pages, type: :integer,
      example: 1
    attribute :images, type: :image_stub, array: true
  end
  section "Images" do
    endpoint "get", "/images" do
      request_with do
        param :page
        param :per_page
      end
      response_with 200 do
        attribute :images, array: true, type: :image_stub
        attribute :current_page, type: :integer, example: 1
        attribute :per_page, type: :integer, example: 20
        attribute :total_pages, type: :integer, example: 1
      end 
    end
    endpoint "get", "/images/:id" do
      request_with do
        param :id, type: :integer
      end
      response_with 200 do
        attribute :id, type: :integer, example: 1
        attribute :user_id, type: :integer, example: 1,
          description: "The uploader's id"
        attribute :created_at, type: :date, example: "2015-11-21T19:01:27.751Z"
        attribute :updated_at, type: :date, example: "2015-11-21T19:01:27.751Z"
        attribute :description, type: :string,
          example: "An image"
        attribute :nsfw_gore, type: :boolean, example: false
        attribute :nsfw_nudity, type: :boolean, example: false
        attribute :nsfw_language, type: :boolean, example: false
        attribute :nsfw_sexuality, type: :boolean, example: false
        attribute :content_type, type: :string, example: "image/jpeg",
          description: "The MIME type of the image"
        attribute :file_url, type: :url,
          example: "https://i.imagehex.com/1_original.png"
        attribute :creators, type: :user_stub, array: true,
          description: "A list of users who created this image"
        attribute :tag_groups, array: true do 
          attribute :tags, array: true do
            attribute :name, type: :string,
              example: :dragon
            attribute :id, type: :integer,
              example: 10
            attribute :display_name, type: :string,
              example: "Dragon"
            attribute :url, type: :url,
              example: "/tags/1"
          end
          attribute :id, type: :integer, example: 1
        end
      end
    end
  end
  section "Tags" do
    endpoint "get", "/tags/suggest" do |e|
      e.description = %{
        Get a list of tags given a fragment of a name.
      }
      request_with do
        param :name, description: "The name fragment to suggest",
          required: true
      end

      response_with 200, array: true do
        attribute :id, type: :integer,
          example: 10
        attribute :name, type: :string,
          example: :dragon
        attribute :display_name, type: :string,
          example: "Dragon"
        attribute :importance, type: :integer,
          example: 4,
          description: "How important this tag is when sorting"
      end
    end
    endpoint "get", "/tags/:id" do |e|
      request_with do
        param :id, type: :integer,
          required: true
      end
      response_with 200 do
        attribute :name, type: :string,
          example: :dragon
        attribute :description, type: :string,
          example: "A fire-breathing lizard with wings."
        attribute :display_name, type: :string,
          example: "Dragon"
        attribute :images, type: :image_collection
      end
    end
  end
  section "Collections" do 
    endpoint "get", "/collections" do |e|
      response_with 200 do
        attribute :id, type: :integer,
          example: 1
        attribute :name, type: :string,
          example: "Undertale Images"
        attribute :type, type: :enum do
          choice :Favorite,
            description: "A collection of a user's favorite images"
          choice :Subjective,
            description: "A collection based on some subjective quantity."
        end
      end
    end
    endpoint "get", "/collections/:id" do |e|
      request_with do
        param :id, type: :integer, required: true
      end

      response_with 200 do
        attribute :name, type: :string,
          example: "Red Letter Media Gifs"
        attribute :id, type: :integer,
          example: 4
        attribute :description, type: :string,
          example: "These Hack Frauds make for great reactions!"
        attribute :type, type: :enum do
          choice :Subjective,
            description: "Images based on some subjective quality"
          choice :Favorite,
            description: "Images a user has favorited"
        end
        attribute :images, type: :image_collection
      end
    end
  end
  section "Users" do
    endpoint "get", "/users/:id" do |e|
      response_with 200 do
        attribute :creations, type: :image_collection
        attribute :name, type: :string,
          example: "Tony"
        attribute :id, type: :integer,
          example: 10
        attribute :created_at, type: :date,
          example: "2015-11-21T19:00:38.391Z"
        attribute :uploads, type: :image_collection
        attribute :creations, type: :image_collection
        attribute :favorites, type: :collection_stub
        attribute :collections, array: true, type: :collection_stub,
          description: "A list of collections this user curates"
        attribute :bio, type: :string,
          description: "I do art"
      end
    end
  end
end
