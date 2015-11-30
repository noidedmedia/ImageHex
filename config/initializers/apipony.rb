require 'json'

Apipony::Documentation.define do
  config do |c|
    c.title = 'ImageHex API Documentation'
    c.base_url = '/'
  end

  images_collection =  {
    images: [
      {
        id: 1,
        description: "An example API image",
        user_id: 10,
        created_at: "2015-11-24T06:08:57.212Z",
        updated_at: "2015-11-24T06:08:57.212Z",
        license: "public_domain",
        medium: "photograph",
        url: "http://www.imagehex.com/images/1/",
        medium_thumbnail: "http://i.imagehex.com/1_medium.png",
        large_thumbnail: "http://i.imagehex.com/1_large.png",
        original_size: "http://i.imagehex.com/1_original.png",
        nsfw_gore: false,
        nsfw_nudity: false,
        nsfw_language: true,
        nsfw_sexuality: false
      }
    ],
    current_page: 1,
    per_page: 20,
    total_pages: 100
  }

  section 'Images' do
    endpoint 'get', '/images' do |e|
      e.description = %{
        Obtain a paginated list of all images.
      }

      request_with do
        param :page, example: "2", required: false, type: :number
        param :per_page, example: "20", required: false, type: :number
      end

      response_with 200 do
        set :body, images_collection
      end
    end

    endpoint 'get', '/search' do |e|
      e.description = %{
        Find images by searching for things.
        The JSON in the query parameter is extremely ugly, and will
        most likely be replaced as soon as possible. 
      }
      
      request_with do
        query = JSON.dump(
          {
            tag_groups: {
              tags: [
                {id: 1},
                {id: 2}
              ]
            }
          }
        )
        param :query, type: :json, example: query, required: false
      end

      response_with 200 do
        set :body, images_collection
      end
    end

    endpoint "get", "/images/:id" do |e|
      e.description = "Get information about a given image."

      response_with 200 do
        set :body, {
          id: 1,
          user_id: 2,
          created_at: "2015-11-21T19:01:27.751Z",
          updated_at: "2015-11-21T19:01:27.751Z",
          description: "An example API test image",
          license: "public_domain",
          medium: "photograph",
          nsfw_gore: false,
          nsfw_nudity: false,
          nsfw_sexuality: false,
          nsfw_language: false,
          content_type: "image/png",
          file_url: "https://i.imagehex.com/1_original.jpg",
          creators: [
            { 
              id: 1, 
              name: "Anthony", 
              slug: "anthony",
              avatar_path: "default-avatar.svg"
            }
          ],
          tag_groups: [
            id: 1,
            tags: [
              {
                name: "anthony super",
                id: 10,
                display_name: "Anthony Super",
                url: "/tags/10"
              }
            ]
          ]
        }
      end
    end
  end
end
