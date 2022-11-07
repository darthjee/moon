# frozen_string_literal: true

module Marriage
  class Gift < ActiveRecord::Base
    has_many :gift_links
    belongs_to :marriage
    belongs_to :thread, class_name: 'Comment::Thread'

    scope(:not_hidden, -> { where.not(status: :hidden) })

    default_scope do
      where.not(status: :canceled)
    end

    def as_json(*args)
      options = args.extract_options!
      options = {
        except: %i[created_at updated_at]
      }.merge(options)

      super(*args, options).merge(
        price_range: [min_price, max_price].uniq.compact,
        packages_quantity: packages_quantity,
        gift_links: gift_links.not_hidden.map(&:as_json),
        comments: thread.comments.count
      )
    end

    def thread
      super || create_thread
    end

    def cancel
      update(status: :canceled)
      gift_links.each(&:cancel)
    end

    def packages_quantity
      (1.0 * quantity / package).ceil
    end

    def price_list
      gift_links.map(&:price)
    end

    def min_link_price
      price_list.min
    end

    def max_link_price
      price_list.max
    end

    def add_link(attributes)
      gift_links.create(attributes)
      update_prices
    end

    def update_bought(bought = nil)
      update(bought: bought) if bought

      update(status: :bought) if self.bought == quantity
    end

    def update_prices(price = nil)
      gift_links.update_all(price: price) if price

      update(
        min_price: min_link_price.to_f * package,
        max_price: max_link_price.to_f * package
      )
    end

    private

    def create_thread
      Comment::Thread.create(marriage_id: marriage_id, name: name).tap do |thread|
        update(thread_id: thread.id)
      end
    end
  end
end
