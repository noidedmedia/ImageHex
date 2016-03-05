# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the `rake db:seed`
# (or created alongside the db with `db:setup`).

fail "Should not seed in production" if Rails.env.production?

# Helper method for using image assets from the `seed_assets` directory.
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
# Array: [username, email, password, role, avatar, description]
user_list = [
  ["test", "test@example.com", "password", :normal, false, false],
  ["foo", "foo@example.com", "password", :normal, false, false],
  ["moot", "moot@example.com", "password", :normal, false, false],
  ["connor", "connor@noided.media", "password", :admin, "avatars/connor.jpg", "Lead Designer for ImageHex."],
  ["anthony", "anthony@noided.media", "password", :admin, false, false]
]

user_list.each do |user|
  User.create(
    name: user[0],
    email: user[1],
    password: user[2],
    password_confirmation: user[2],
    role: user[3],
    avatar: user[4] ? img(user[4]) : nil,
    description: user[5] ? user[5] : ""
  )
end

# Confirm each user
User.find_each(&:confirm)

# User variables
test = User.first
foo = User.second
moot = User.third
connor = User.fourth
anthony = User.fifth

##
# Seed Images
# 
# Array: [image, uploader, description, medium, license, created_by_uploader]
image_list = [
  ["tiamat.jpg", test, "A toy tiamat. Is adorable, no?", :photograph, :public_domain, true],
  ["tiamat2.png", test, "A scarier tiamat model", :photograph, :public_domain, true],
  ["planedragon.png", foo, "A dragon I drew with fighter jets.", :digital_paint, :public_domain, false],
  ["connor1.png", connor, "A piece from my school newspaper that I did for our 80's issue. I really liked the color scheme for this one.", :digital_paint, :all_rights_reserved, true],
  ["connor2.png", connor, "A poster I created for a school project, I was learning to code :)", :digital_paint, :all_rights_reserved, true],
  ["connor3.png", connor, "The logo for WavHead, a Noided Media project. We made a small application you can host on your local network that lets anyone connected vote on music to be played. Meant for parties and the like.", :digital_paint, :all_rights_reserved, true]
]

image_list.each do |image|
  Image.create(
    f: img(image[0]),
    user: image[1],
    nsfw_gore: false,
    nsfw_sexuality: false,
    nsfw_language: false,
    nsfw_nudity: false,
    description: image[2],
    medium: image[3],
    license: image[4],
    created_by_uploader: image[5]
  )
end


##
# Seed Comments
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


##
# Seed Collections
Subjective.create(curators: [foo],
                  name: "Dragons",
                  description: <<-eos)
Flying lizards who breathe fire.
Note: Dragons that breathe other things are cool too.
eos

Subjective.first.collection_images.create([{ image_id: 1 },
                                           { image_id: 2 },
                                           { image_id: 3 }])


##
# Seed Tags
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

##
# Seed Favorites
test.favorite! Image.first
foo.favorite! Image.first
moot.favorite! Image.first

##
# Seed Subscriptions
test.subscribe! foo
foo.subscribe! test
moot.subscribe! foo
