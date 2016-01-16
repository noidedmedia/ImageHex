# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

fail "Should not seed in production" if Rails.env.production?

def img(filename)
  filename = "#{Rails.root}/db/seed_assets/#{filename}"
  File.open(filename)
end

User.create!([{ name: "test",
                email: "test@example.com",
                password: "testtest",
                password_confirmation: "testtest" },
              { name: "foo",
                email: "foo@example.com",
                password: "foobarbaz",
                password_confirmation: "foobarbaz" },
              { name: "Moot",
                email: "moot@example.com",
                password: "lol4chanjoke",
                password_confirmation: "lol4chanjoke" }])
User.find_each(&:confirm)
u1 = User.first
u2 = User.second
u3 = User.third

Image.create!([{ f: img("tiamat.jpg"),
                 user: u1,
                 nsfw_gore: false,
                 nsfw_sexuality: false,
                 nsfw_language: false,
                 nsfw_nudity: false,
                 description: "A toy tiamat. Is adorable, no?",
                 license: :public_domain,
                 medium: :photograph,
                 created_by_uploader: true },
               { f: img("tiamat2.png"),
                 user: u1,
                 nsfw_gore: false,
                 nsfw_nudity: false,
                 nsfw_sexuality: false,
                 nsfw_language: false,
                 description: "A scarier tiamat model",
                 medium: :photograph,
                 license: :public_domain,
                 created_by_uploader: true },
               { f: img("planedragon.png"),
                 user: u2,
                 nsfw_gore: false,
                 nsfw_nudity: false,
                 nsfw_sexuality: false,
                 nsfw_language: false,
                 description: "A dragon I drew with fighter jets.",
                 medium: :digital_paint,
                 license: :public_domain,
                 created_by_uploader: true }])

Image.first.comments.create!(user: u2,
                             body: "Wow, this actually is adorable.")
Image.find(2).comments.create(user: u2,
                              body: <<-eos)
This sculpture is both more detailed and more accurate to Tiamat as a character.

To be perfectly honest, though, I think that the other one is better.
I guess I just like cute things more?
Oh well.
Still, you should continue to make these, they're great:

```ruby

    while want_dragons?
      sculpt_dragons!
    end

```
eos

Image.find(3).comments.create(user: u1,
                              body: <<-eos)
This is a really cool drawing.
I can see the headline now:
# Fighter Jets Fly with Freaking Dragon
## US Military Somehow Manages to One-Up Itself
eos

Subjective.create(curators: [u2],
                  name: "Dragons",
                  description: <<-eos)
Flying lizards who breathe fire.
Note: Dragons that breathe other things are cool too.
eos

Subjective.first.collection_images.create([{ image_id: 1 },
                                           { image_id: 2 },
                                           { image_id: 3 }])

## Tag some images
dragon = Tag.create(name: "Dragon")
tiamat = Tag.create(name: "Tiamat (D&D)")
fighter = Tag.create(name: "Fighter Jet")
Image.first.tag_groups.create!(tag_ids: [dragon, tiamat].map(&:id))
Image.find(2).tag_groups.create!(tag_ids: [dragon, tiamat].map(&:id))
Image.find(3).tag_groups.create!(tag_ids: [dragon.id])
Image.find(3).tag_groups.create!(tag_ids: [fighter.id])
u1.favorite! Image.first
u2.favorite! Image.first
u3.favorite! Image.first
u1.subscribe! u2
u2.subscribe! u1
u3.subscribe! u2
