# frozen_string_literal: true
# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).

Zyra.register(Marriage::Marriage, find_by: :id)
Zyra.register(Marriage::Picture, find_by: :name)
Zyra.register(Marriage::Album, find_by: :name)
Zyra.register(Marriage::Gift, find_by: :name)
Zyra.register(Marriage::GiftLink, find_by: %i[gift url store_list account])

Zyra.register(Bank::Bank, find_by: :name)
Zyra.register(Bank::Account, find_by: %i[account agency number])

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

20.times do |i|
  account_gift = Zyra.find_or_create(
    :marriage_gift,
    marriage: marriage,
    name: "Account gift #{i}",
    image_url: "http://localhost:3001/gift.png",
    description: "My first gift",
  )
  Zyra.find_or_create(
    :marriage_giftlink,
    gift: account_gift,
    account: account,
    price: Random.rand(100..1000) / 10.0
  )

  store_gift = Zyra.find_or_create(
    :marriage_gift,
    marriage: marriage,
    name: "Store gift #{i}",
    image_url: "http://localhost:3001/gift.png",
    description: "My first gift",
    bought: 1
  )
end
