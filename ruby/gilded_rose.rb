class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_pass_quality(item)
      end

      if item.name != "Aged Brie"
        if item.name != "Backstage passes to a TAFKAL80ETC concert"
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality -= 1 if item.quality.positive?
          end
        end
      end

      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in -= 1
      end

      if item.name == "Aged Brie"
        update_aged_brie_quality(item)
      end

      if item.name != "Sulfuras, Hand of Ragnaros"
        if item.name != "Backstage passes to a TAFKAL80ETC concert"
          if item.name != "Aged Brie"
            if item.sell_in.negative?
              item.quality -= 1 if item.quality.positive?
            end
          end
        end
      end

      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        item.quality = 0 if item.sell_in.negative?
      end

      if item.name == "Sulfuras, Hand of Ragnaros"
        item.quality = 0 if item.sell_in.negative?
      end
    end
  end

  def update_backstage_pass_quality(item)
    if item.quality < 50
      item.quality += 1
    end

    if item.quality < 50
      item.quality += 2 if item.sell_in < 6
      item.quality += 1 if item.sell_in >= 6 && item.sell_in < 11
    end
  end

  def update_aged_brie_quality(item)
    if item.quality < 50
      item.quality += 1
    end

    if item.sell_in.negative?
      if item.quality < 50
        item.quality += 1
      end
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
