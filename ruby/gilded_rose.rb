class GildedRose
  def initialize(items)
    @items = items
  end

  # we're updating two things here - quality and sell in
  # quality usually decreases
  # quality changes in different ways based on different names
  def update_quality
    @items.each do |item|
      if item.name != 'Aged Brie'
        if item.name != 'Backstage passes to a TAFKAL80ETC concert'
          if item.name != 'Sulfuras, Hand of Ragnaros'
            if item.quality > 0
              item.quality = item.quality - 1
            end

            if item.sell_in < 1
              if item.quality > 0
                item.quality = item.quality - 1
              end
            end
          end
        end
      end

      if item.name == 'Aged Brie'
        if item.quality < 50
          item.quality = item.quality + 1
        end

        if item.sell_in < 1
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end

      if item.name == 'Backstage passes to a TAFKAL80ETC concert'
        if item.quality < 50
          item.quality = item.quality + 1
        end

        if item.sell_in < 11
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end

        if item.sell_in < 6
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end

        if item.sell_in < 1
          item.quality = item.quality - item.quality
        end
      end

      if item.name != 'Sulfuras, Hand of Ragnaros'
        item.sell_in -= 1
      end
    end
  end
end

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
