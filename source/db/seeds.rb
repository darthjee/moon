# frozen_string_literal: true
# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).

Zyra.register(User, find_by: :email)

Zyra.register(Marriage::Marriage, find_by: :id)
Zyra.register(Marriage::Picture, find_by: :name)
Zyra.register(Marriage::Album, find_by: :name)

Zyra.register(Marriage::Gift, find_by: %i[name marriage])
Zyra.register(Marriage::GiftLink, find_by: %i[gift url store_list account])

Zyra.register(Bank::Bank, find_by: :name)
Zyra.register(Bank::Account, find_by: %i[account agency number])

Zyra.register(Marriage::Invite, find_by: %i[mariage label])
Zyra.register(Marriage::Guest, find_by: %i[invite name])

# Setup
marriage = Zyra.find_or_create(
  :marriage_marriage,
  id: 1,
  display_name: "Test Marriage",
  date: Date.today
)

bank = Zyra.find_or_create(
  :bank_bank,
  name: "Green Bank",
  image_url: "http://localhost:3001/bank.png",
  bg_color: "green"
)

account = Zyra.find_or_create(
  :bank_account,
  name: "Account",
  bank: bank,
  agency: "0001",
  number: "12345-1",
  marriage: marriage
)

# Pictures
album = Zyra.find_or_create(
  :marriage_album,
  name: "Main album",
  marriage: marriage
)

30.times do |i|
  Zyra.find_or_create(
    :marriage_picture,
    album: album,
    name: "Picture #{i}",
    url: "http://localhost:3001/photo.png",
    snap_url: "http://localhost:3001/snap.png"
  )
end

10.times do |i|
  alb = Zyra.find_or_create(
    :marriage_album,
    name: "Album #{i}",
    marriage: marriage
  )

  Zyra.find_or_create(
    :marriage_picture,
    album: alb,
    name: "Pic Alb #{i}",
    url: "http://localhost:3001/photo.png",
    snap_url: "http://localhost:3001/snap.png"
  )
end

# Gifts
20.times do |i|
  price = Random.rand(100..1000) / 10.0

  account_gift = Zyra.find_or_create(
    :marriage_gift,
    marriage: marriage,
    name: "Gift #{i} - Account",
    image_url: "http://localhost:3001/gift.png",
    description: "My first gift",
    quantity: Random.rand(2) + 1,
    bought: Random.rand(2),
    min_price: price,
    max_price: price
  )
  Zyra.find_or_create(
    :marriage_giftlink,
    gift: account_gift,
    account: account,
    price: price,
  )

  store_gift = Zyra.find_or_create(
    :marriage_gift,
    marriage: marriage,
    name: "Gift #{i} - Store",
    image_url: "http://localhost:3001/gift.png",
    description: "My first gift",
    quantity: Random.rand(2) + 1,
    bought: Random.rand(2),
    min_price: price,
    max_price: price
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
    marriage: marriage,
    label: "Family test #{i}",
    invites: 4,
    expected: 3,
    code: user.code,
    user: user
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
    marriage: marriage,
    label: "Honor test #{i}",
    invites: 2,
    expected: 2,
    code: user.code,
    user: user,
    invite_honor: true
  )

  Zyra.find_or_create(
    :marriage_guest,
    name: "Maiden #{i}",
    invite: invite,
    role: :maiden_honor
  )

  Zyra.find_or_create(
    :marriage_guest,
    name: "Best Man #{i}",
    invite: invite,
    marriage: marriage,
    role: :best_man
  )
end
