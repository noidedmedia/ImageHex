# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the `rake db:seed`
# (or created alongside the db with db:setup).

fail "Should not seed in production" if Rails.env.production?

def img(filename)
  filename = "#{Rails.root}/db/seed_assets/#{filename}"
  File.open(filename)
end

##
# Seed Users
#
# Email                | Username | Password
# ------------------------------------------
# test@example.com     | test     | password
# foo@example.com      | foo      | password
# moot@example.com     | moot     | password
# connor@noided.media  | connor   | password
# anthony@noided.media | anthony  | password
# 

user_list = [
  ["test", "test@example.com", "password", :normal, false],
  ["foo", "foo@example.com", "password", :normal, false],
  ["moot", "moot@example.com", "password", :normal, false],
  ["connor", "connor@noided.media", "password", :admin, "avatars/connor.jpg"],
  ["anthony", "anthony@noided.media", "password", :admin, false]
]

user_list.each do |user|
  User.create(
    name: user[0],
    email: user[1],
    password: user[2],
    password_confirmation: user[2],
    role: user[3],
    avatar: user[4] ? img(user[4]) : nil
  )
end

# Confirm each user
User.find_each(&:confirm)
test = User.first
foo = User.second
moot = User.third
connor = User.fourth
anthony = User.fifth

Image.create!([
  {
    f: img("tiamat.jpg"),
    user: test,
    nsfw_gore: false,
    nsfw_sexuality: false,
    nsfw_language: false,
    nsfw_nudity: false,
    description: "A toy tiamat. Is adorable, no?",
    license: :public_domain,
    medium: :photograph,
    created_by_uploader: true
  },
  {
    f: img("tiamat2.png"),
    user: test,
    nsfw_gore: false,
    nsfw_nudity: false,
    nsfw_sexuality: false,
    nsfw_language: false,
    description: "A scarier tiamat model",
    medium: :photograph,
    license: :public_domain,
    created_by_uploader: true
  },
  {
    f: img("planedragon.png"),
    user: foo,
    nsfw_gore: false,
    nsfw_nudity: false,
    nsfw_sexuality: false,
    nsfw_language: false,
    description: "A dragon I drew with fighter jets.",
    medium: :digital_paint,
    license: :public_domain,
    created_by_uploader: false
  },
  {
    f: img("connor1.png"),
    user: connor,
    nsfw_gore: false,
    nsfw_nudity: false,
    nsfw_sexuality: false,
    nsfw_language: false,
    description: "A piece from my school newspaper that I did for our 80's issue. I really liked the color scheme for this one.",
    medium: :digital_paint,
    license: :all_rights_reserved,
    created_by_uploader: true
  },
  {
    f: img("connor2.png"),
    user: connor,
    nsfw_gore: false,
    nsfw_nudity: false,
    nsfw_sexuality: false,
    nsfw_language: false,
    description: "A poster I created for a school project, I was learning to code :)",
    medium: :digital_paint,
    license: :all_rights_reserved,
    created_by_uploader: true
  },
  {
    f: img("connor3.png"),
    user: connor,
    nsfw_gore: false,
    nsfw_nudity: false,
    nsfw_sexuality: false,
    nsfw_language: false,
    description: "The logo for WavHead, a Noided Media project. We made a small application you can host on your local network that lets anyone connected vote on music to be played. Meant for parties and the like.",
    medium: :digital_paint,
    license: :all_rights_reserved,
    created_by_uploader: true
  }
])

Image.first.comments.create!(user: foo,
                             body: "Wow, this actually is adorable.")
Image.find(2).comments.create(user: foo,
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

Image.find(3).comments.create(user: test,
                              body: <<-eos)
This is a really cool drawing.
I can see the headline now:
# Fighter Jets Fly with Freaking Dragon
## US Military Somehow Manages to One-Up Itself
eos

Subjective.create(curators: [foo],
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
desk = Tag.create(name: "Desk", description: "A piece of furniture with a flat or sloped surface and typically with drawers, at which one can read, write, or do other work.")
brown = Tag.create(name: "Brown")
Image.first.tag_groups.create!(tag_ids: [dragon, tiamat].map(&:id))
Image.find(2).tag_groups.create!(tag_ids: [dragon, tiamat].map(&:id))
Image.find(3).tag_groups.create!(tag_ids: [dragon.id])
Image.find(3).tag_groups.create!(tag_ids: [fighter.id])
Image.find(5).tag_groups.create!(tag_ids: [desk.id, brown.id])
test.favorite! Image.first
foo.favorite! Image.first
moot.favorite! Image.first
test.subscribe! foo
foo.subscribe! test
moot.subscribe! foo
