class GildedRose
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if item.name == SULFURAS

      item.sell_in -= 1

      case item.name
      when AGED_BRIE
        update_aged_brie(item)
      when BACKSTAGE_PASS
        update_backstage_pass(item)
      else
        update_normal_item(item)
      end
    end
  end

  def update_backstage_pass(item)
    increase = 1
    increase = 2 if item.sell_in < 10
    increase = 3 if item.sell_in < 5

    item.quality += increase

    item.quality = 0 if item.sell_in.negative?
  end

  def update_aged_brie(item)
    return if item.quality >= 50

    out_of_date = item.sell_in.negative?

    item.quality += out_of_date ? 2 : 1
  end

  def update_normal_item(item)
    return unless item.quality.positive?

    out_of_date = item.sell_in.positive? || item.sell_in.zero?

    item.quality -= out_of_date ? 1 : 2
  end
end

# not allowed to change this!
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
