require 'json'

Apipony::Documentation.define do
  config do |c|
    c.title = 'ImageHex API Documentation'
    c.base_url = '/'
  end

  subtype :collection_stub do
    attribute :name,
              type: :string,
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
    attribute :id,
              type: :integer,
              example: 20
    attribute :type, type: :enum do
      choice :Favorite,
             description: "A collection of a user's favorite images."
      choice :Subjective,
             description: "A collection based on some subjective quantity."
    end
    attribute :url,
              type: :url,
              example: "/collections/4.json"
  end

  subtype :user_stub do
    attribute :name,
              type: :string,
              example: "tony",
              description: "This user's name"
    attribute :id,
              type: :integer,
              example: 10,
              description: "The id of the user"
    attribute :slug,
              type: :string,
              description: %(The slug for this users's name. You can then access their
              user page at `/@:slug`.),
              example: "test"
    attribute :avatar_path,
              type: :url,
              description: "The user's avatar.",
              example: "https://i.imagehex.com/default-avatar.svg"
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

    attribute :license, description: "The type of copyright license under which the image has been made available.", type: :enum do
      choice :public_domain
      choice :all_rights_reserved
      choice :cc_by
      choice :cc_by_sa
      choice :cc_by_nd
      choice :cc_by_nc
      choice :cc_by_nd_sa
      choice :cc_by_nc_nd
    end

    attribute :medium, description: "The medium within which the image was made.", type: :enum do
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
                            description: %(
      Whether or not this image is marked as NSFW due to nudity
    )
    attribute :nsfw_sexuality, type: :boolean, example: true,
                               description: %(
      Whether or not this image is marked as NSFW due to a depiction of
      sexuality
    )
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
                                 description: %(The current page of the images. Same as what you
          passed in the query parameter.)
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
                               description: %(
          When the image was last updated. Note that updating tag groups, adding
          comments, or adding uploaders does not modify this timestamp.
        )
        attribute :description, type: :string,
                                example: "An image",
                                description: %(
          A user-set description for this image. The user will expect this
          to render any markdown formatting to the proper display format.
        )
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
                               description: %(A list of tag groups on the image) do
          attribute :tags, array: true,
                           description: %(A list of tags within this group) do
            attribute :name, type: :string,
                             example: :dragon,
                             description: "This tag's name. Note that the display_name should
              be shown to the user, as it will have proper capitalization."
            attribute :id, type: :integer,
                           example: 10
            attribute :url, type: :url, example: "/tags/1"
          end
          attribute :id,
                    type: :integer,
                    example: 1
        end
      end
    end
  end

  section "Tags" do
    endpoint "get", "/tags/suggest" do |e|
      e.description = %(
        Get a list of tags given a fragment of a name.
      )

      request_with do
        param :name,
              required: true,
              description: "The name fragment to suggest"
      end

      response_with 200, array: true do
        attribute :id,
                  type: :integer,
                  description: "The tag ID.",
                  example: 10
        attribute :name,
                  type: :string,
                  description: "The tag's name.",
                  example: :dragon
        attribute :display_name,
                  type: :string,
                  description: "The tag's display name.",
                  example: "Dragon"
        attribute :importance,
                  type: :integer,
                  description: "The importance of the tag for sorting purposes.",
                  example: 4
      end
    end

    endpoint "get", "/tags/:id" do |_e|
      request_with do
        param :id,
              type: :integer,
              required: true,
              description: "The tag ID."
      end

      response_with 200 do
        attribute :name,
                  type: :string,
                  description: "The tag's name.",
                  example: :dragon
        attribute :description,
                  type: :string,
                  description: "The tag's description.",
                  example: "A fire-breathing lizard with wings."
        attribute :display_name,
                  type: :string,
                  description: "The tag's display name.",
                  example: "Dragon"
        attribute :images,
                  type: :image_collection,
                  description: "A list of the images associated with the tag."
      end
    end
  end

  section "Collections" do
    endpoint "get", "/collections" do |_e|
      response_with 200 do
        attribute :id,
                  type: :integer,
                  description: "The collection ID.",
                  example: 1
        attribute :name,
                  type: :string,
                  description: "The collection's name",
                  example: "Undertale Images"
        attribute :type, type: :enum do
          choice :Favorite,
                 description: "A collection of a user's favorite images."
          choice :Subjective,
                 description: "A collection based on some subjective quantity."
        end
      end
    end

    endpoint "get", "/collections/:id" do |_e|
      request_with do
        param :id,
              type: :integer,
              description: "The collection ID.",
              required: true
      end

      response_with 200 do
        attribute :name, type: :string,
                         example: "Red Letter Media GIFs"
        attribute :id,
                  type: :integer,
                  description: "The collection ID.",
                  example: 4
        attribute :description,
                  type: :string,
                  description: "The collection's description.",
                  example: "These Hack Frauds make for great reactions!"
        attribute :type, type: :enum do
          choice :Subjective,
                 description: "Images based on some subjective quality"
          choice :Favorite,
                 description: "Images a user has favorited"
        end
        attribute :images,
                  type: :image_collection,
                  description: "A list of images in the collection."
      end
    end
  end

  section "Users" do
    endpoint "get", "/users/:id" do |_e|
      response_with 200 do
        attribute :name,
                  type: :string,
                  description: "The user's username.",
                  example: "tony"
        attribute :id,
                  type: :integer,
                  description: "The user ID.",
                  example: 10
        attribute :created_at,
                  type: :date,
                  description: "The Unix time stamp at which the user's account was created.",
                  example: "2015-11-21T19:00:38.391Z"
        attribute :uploads,
                  type: :image_collection,
                  description: "A list of the images uploaded by the user."
        attribute :creations,
                  type: :image_collection,
                  description: "A list of the images the user has been given credit for."
        attribute :favorites,
                  type: :collection_stub,
                  description: "A list of the images favorited by the user."
        attribute :collections,
                  array: true,
                  type: :collection_stub,
                  description: "A list of collections the user curates."
        attribute :bio,
                  type: :string,
                  description: "The user's description.",
                  example: "I do art."
      end
    end
  end
end
