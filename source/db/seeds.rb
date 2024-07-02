# frozen_string_literal: true

# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).

Zyra.register(User, find_by: :email)

Zyra.register(Marriage::Marriage, find_by: :id)
Zyra.register(Marriage::Picture, find_by: :name)
Zyra.register(Marriage::Album, find_by: :name)

Zyra.register(Marriage::Location, find_by: %i[name])
Zyra.register(Marriage::Event, find_by: %i[marriage location])

Zyra.register(Marriage::Gift, find_by: %i[name marriage])
Zyra.register(Marriage::GiftLink, find_by: %i[gift url store_list account])

Zyra.register(Bank::Bank, find_by: :name)
Zyra.register(Bank::Account, find_by: %i[account agency number])

Zyra.register(Store::Store, find_by: :name)
Zyra.register(Store::List, find_by: %i[marriage store])

Zyra.register(Marriage::Invite, find_by: %i[mariage label])
Zyra.register(Marriage::Guest, find_by: %i[invite name])

# Setup
marriage = Zyra.find_or_create(
  :marriage_marriage,
  id: 1,
  display_name: 'Test Marriage',
  date: Date.today
)

bank = Zyra.find_or_create(
  :bank_bank,
  name: 'Green Bank',
  image_url: 'http://localhost:3001/bank.png',
  bg_color: 'green'
)

account = Zyra.find_or_create(
  :bank_account,
  name: 'Account',
  bank:,
  agency: '0001',
  number: '12345-1',
  marriage:
)

store = Zyra.find_or_create(
  :store_store,
  name: 'The store',
  image_url: 'http://localhost:3001/store.png',
  bg_color: 'yellow',
  url: 'http://localhost:3001/store/'
)

store_list = Zyra.find_or_create(
  :store_list,
  marriage:,
  store:,
  url: 'http://localhost:3001/store/'
)

church = Zyra.find_or_create(
  :marriage_location,
  name: 'Church',
  address: 'Street name, 169',
  marriage:
)
Zyra.find_or_create(
  :marriage_event,
  location: church,
  time: '17:45',
  description: 'Marriage',
  marriage:
)

party = Zyra.find_or_create(
  :marriage_location,
  name: 'Party',
  address: 'Avenue name, 132',
  marriage:
)
Zyra.find_or_create(
  :marriage_event,
  location: party,
  time: '19:00',
  description: 'Party',
  marriage:
)

# Pictures
album = Zyra.find_or_create(
  :marriage_album,
  name: 'Main album',
  marriage:
)

30.times do |i|
  Zyra.find_or_create(
    :marriage_picture,
    album:,
    name: "Picture #{i}",
    url: 'http://localhost:3001/photo.png',
    snap_url: 'http://localhost:3001/snap.png'
  )
end

10.times do |i|
  alb = Zyra.find_or_create(
    :marriage_album,
    name: "Album #{i}",
    marriage:
  )

  Zyra.find_or_create(
    :marriage_picture,
    album: alb,
    name: "Pic Alb #{i}",
    url: 'http://localhost:3001/photo.png',
    snap_url: 'http://localhost:3001/snap.png'
  )
end

# Gifts
20.times do |i|
  price = Random.rand(100..1000) / 10.0

  account_gift = Zyra.find_or_create(
    :marriage_gift,
    marriage:,
    name: "Gift #{i} - Account",
    image_url: 'http://localhost:3001/gift.png',
    description: 'My first gift',
    quantity: Random.rand(1..2),
    bought: Random.rand(2),
    min_price: price,
    max_price: price
  )
  Zyra.find_or_create(
    :marriage_giftlink,
    gift: account_gift,
    account:,
    price:
  )

  store_gift = Zyra.find_or_create(
    :marriage_gift,
    marriage:,
    name: "Gift #{i} - Store",
    image_url: 'http://localhost:3001/gift.png',
    description: 'My first gift',
    quantity: Random.rand(1..2),
    bought: Random.rand(2),
    min_price: price,
    max_price: price
  )
  Zyra.find_or_create(
    :marriage_giftlink,
    gift: store_gift,
    store_list:,
    price:,
    url: "http://localhost:3001/store/product.html?price=#{price}&name=#{"Gift #{i} - Store"}"
  )
end

# Invites
10.times do |i|
  user = Zyra.find_or_create(
    :user,
    email: "email#{i}@srv.com",
    login: "email#{i}",
    name: "user #{i}",
    password: '123456'
  )

  Zyra.find_or_create(
    :marriage_invite,
    marriage:,
    label: "Family test #{i}",
    invites: 4,
    expected: 3,
    code: user.code,
    user:
  )
end

# Maid of Honor
10.times do |i|
  user = Zyra.find_or_create(
    :user,
    email: "honor#{i}@srv.com",
    login: "honor#{i}",
    name: "honor #{i}",
    password: '123456'
  )

  invite = Zyra.find_or_create(
    :marriage_invite,
    marriage:,
    label: "Honor test #{i}",
    invites: 2,
    expected: 2,
    code: user.code,
    user:,
    invite_honor: true
  )

  Zyra.find_or_create(
    :marriage_guest,
    name: "Maiden #{i}",
    invite:,
    role: :maid_honor,
    color: "##{SecureRandom.hex(3)}"
  )

  Zyra.find_or_create(
    :marriage_guest,
    name: "Best Man #{i}",
    invite:,
    role: :best_man
  )
end
