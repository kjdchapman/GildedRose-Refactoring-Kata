class GildedRose
  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when AGED_BRIE
        update_aged_brie_quality(item)
      when BACKSTAGE_PASS
        update_backstage_pass_quality(item)
      when SULFURAS
        nil
      else
        update_normal_item_quality(item)
      end

      item.sell_in -= 1 unless item.name == SULFURAS
    end
  end

  def update_backstage_pass_quality(item)
    return if item.quality > 50

    if item.sell_in < 1
      item.quality = 0
    elsif item.sell_in < 6
      item.quality += 3
    elsif item.sell_in < 11
      item.quality += 2
    else
      item.quality += 1
    end
  end

  def update_aged_brie_quality(item)
    return if item.quality >= 50

    if item.sell_in < 1
      item.quality += 2
    else
      item.quality += 1
    end
  end

  def update_normal_item_quality(item)
    unless item.sell_in.positive?
      item.quality -= 1 if item.quality.positive?
    end

    if item.quality.positive?
      item.quality -= 1
    end
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
