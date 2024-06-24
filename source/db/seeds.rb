# frozen_string_literal: true
# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).

Zyra
  .register(Marriage::Marriage, find_by: :id)

Zyra.find_or_create(
  :marriage_marriage,
  id: 1,
  display_name: "Test Marriage",
  date: Date.today
)
