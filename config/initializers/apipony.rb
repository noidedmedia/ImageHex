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
      example: 20,
      description: "The ID of this collection"
    attribute :type, type: :enum do
      choice :Subjective,
        description: "A collection based on some subjective quantity"
      choice :Favorite,
        description: "A collection of a user's favorite images"
    end
    attribute :url, type: :url,
      example: "/collections.4.json",
      description: "A URL to access more information about this collection"
  end

  subtype :user_stub do
    attribute :name, type: :string,
      example: "tony",
      description: "This user's name"
    attribute :id, 
      type: :integer, 
      example: 10,
      description: "The id of the user"
    attribute :slug, type: :string,
      example: "test",
      description: %{The slug for this users's name. You can then access their
      user page at /@:slug}
    attribute :avatar_path, type: :string,
      description: "A URL for the user's avatar",
      example: "http://i.imagehex.com/default-avatar.svg"
  end

  subtype :image_stub do
    attribute :id, 
      type: :integer, 
      example: 1,
      description: "The ID of this image"
    attribute :description, 
      type: :string, 
      example: "An image",
      description: "A user-set description of this image"
    attribute :user_id, type: :integer,
      description: "The id of the uploader",
      example: 10
    attribute :created_at, type: :date,
      example: "2015-11-21T19:01:27.751Z",
      description: "The time this image was created"
    attribute :updated_at, type: :date,
      example: "2015-11-21T19:01:27.751Z",
      description: "The last time this image was updated"
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
      example: "https://i.imaghex.com/1_original.png",
      description: "A link to the original version of this image"
    attribute :nsfw_gore, type: :boolean, example: true,
      description: "Whether or not this image is marked as NSFW due to gore"
    attribute :nsfw_language, type: :boolean, example: true,
      description: "Whether or not this image is marked as NSFW due to langauge"
    attribute :nsfw_nudity, type: :boolean, example: true,
      description: %{
      Whether or not this image is marked as NSFW due to nudity
    }
    attribute :nsfw_sexuality, type: :boolean, example: true,
      description: %{
      Whether or not this image is marked as NSFW due to a depiction of
      sexuality
    }
  end
  subtype :image_collection do
    attribute :current_page, type: :integer,
      example: 1,
      description: "What page this image collection is currently on"
    attribute :per_page, type: :integer,
      example: 20,
      description: "How many images are in each page of this collection"
    attribute :total_pages, type: :integer,
      example: 1,
      description: "The total number of pages in this collection"
    attribute :images, type: :image_stub, array: true,
      description: "A list of images in this collection"
  end
  section "Images" do
    endpoint "get", "/images" do
      request_with do
        param :page,
          description: "What page of the list of images to get. Default 0.",
          required: false
        param :per_page,
          description: %{
            How many images you want on each page. If a user is logged in,
            this will default to their page preference. Otherwise, it will
            be the server's default (20)
          },
          required: false
      end
      response_with 200 do
        attribute :images, array: true, type: :image_stub,
          description: "The list of images"
        attribute :current_page, type: :integer, example: 1,
          description: %{The current page of the images. Same as what you
          passed in the query parameter.}
        attribute :per_page, type: :integer, example: 20,
          description: %{
          How many images are on each page. Same as what you passed in the
          query parameter. If you did not pass a number, it will return
          the server default (if no user is logged in), or the user's preference
          (if a user is logged in)
        }
        attribute :total_pages, type: :integer, example: 1,
          description: %{
          How many pages of images (that fit the current user's content
          preference) there are.
        }
      end 
    end
    endpoint "get", "/images/:id" do
      request_with do
        param :id, type: :integer,
          description: "ID of the image to find"
      end
      response_with 200 do
        attribute :id, type: :integer, example: 1,
          description: "The id of this image. Same as in the query param."
        attribute :user_id, type: :integer, example: 1,
          description: "The uploader's id"
        attribute :created_at, type: :date, example: "2015-11-21T19:01:27.751Z",
          description: "When the image was added to ImageHex"
        attribute :updated_at, type: :date, example: "2015-11-21T19:01:27.751Z",
          description: %{
          When the image was last updated. Note that updating tag groups, adding
          comments, or adding uploaders does not modify this timestamp.
        }
        attribute :description, type: :string,
          example: "An image",
          description: %{
          A user-set description for this image. The user will expect this
          to render any markdown formatting to the proper display format.
          }
        attribute :nsfw_gore, type: :boolean, example: false
        attribute :nsfw_nudity, type: :boolean, example: false
        attribute :nsfw_language, type: :boolean, example: false
        attribute :nsfw_sexuality, type: :boolean, example: false
        attribute :content_type, type: :string, example: "image/jpeg",
          description: "The MIME type of the image"
        attribute :file_url, type: :url,
          example: "https://i.imagehex.com/1_original.png",
          description: "A link to the original version of this image"
        attribute :creators, type: :user_stub, array: true,
          description: "A list of users who created this image"
        attribute :tag_groups, array: true,
         description: %{A list of tag groups on the image} do 
          attribute :tags, array: true,
            description: %{A list of tags within this group} do
            attribute :name, type: :string,
              example: :dragon,
              description: "This tag's name. Note that the display_name should
              be shown to the user, as it will have proper capitalization."
            attribute :id, type: :integer,
              example: 10
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
