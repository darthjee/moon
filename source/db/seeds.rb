# frozen_string_literal: true
# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).

Zyra.register(Marriage::Marriage, find_by: :id)
Zyra.register(Marriage::Picture, find_by: :name)
Zyra.register(Marriage::Album, find_by: :name)
Zyra.register(Marriage::Gift, find_by: :name)

marriage = Zyra.find_or_create(
  :marriage_marriage,
  id: 1,
  display_name: "Test Marriage",
  date: Date.today
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

Zyra.find_or_create(
  :marriage_gift,
  marriage: marriage,
  name: "First gift",
  image_url: "http://localhost:3001/gift.png",
  description: "My first gift"
)
