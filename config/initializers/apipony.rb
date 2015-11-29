Apipony::Documentation.define do
  config do |c|
    c.title = 'API Documentation'
    c.base_url = '/'
  end

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
        set :body, {
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
      end
    end
  end

end
