class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" && item.quality.positive?
        item.quality -= 1 if item.name != "Sulfuras, Hand of Ragnaros"
      else
        if item.quality < 50
          item.quality += 1

          if item.name == "Backstage passes to a TAFKAL80ETC concert" && item.sell_in < 11 && item.quality < 50
            item.quality += 1
            item.quality += 1 if item.sell_in < 6
          end
        end
      end

      item.sell_in -= 1 if item.name != "Sulfuras, Hand of Ragnaros"

      if item.sell_in.negative?
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            item.quality -= 1 if item.quality.positive? && item.name != "Sulfuras, Hand of Ragnaros"
          else
            item.quality = 0
          end
        elsif item.quality < 50
          item.quality += 1
        end
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
