class GildedRose
  def initialize(items)
    @items = items
  end

  # we're updating two things here - quality and sell in
  # quality usually decreases
  # quality changes in different ways based on different names
  def update_quality
    @items.each do |item|
      if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
        if item.quality > 0
          if item.name != 'Sulfuras, Hand of Ragnaros'
            item.quality = item.quality - 1
          end
        end
      end

      if (item.name == 'Aged Brie') || (item.name == 'Backstage passes to a TAFKAL80ETC concert')
        if item.quality < 50
          item.quality = item.quality + 1
        end
      end

      if (item.name == 'Aged Brie') || (item.name == 'Backstage passes to a TAFKAL80ETC concert')
        if item.quality < 50
          if item.name == 'Backstage passes to a TAFKAL80ETC concert'
            if item.sell_in < 11
              item.quality = item.quality + 1
            end
          end
        end
      end

      if (item.name == 'Aged Brie') || (item.name == 'Backstage passes to a TAFKAL80ETC concert')
        if item.quality < 50
          if item.name == 'Backstage passes to a TAFKAL80ETC concert'
            if item.sell_in < 6
              item.quality = item.quality + 1
            end
          end
        end
      end

      if item.name != 'Sulfuras, Hand of Ragnaros'
        item.sell_in = item.sell_in - 1
      end

      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            if item.quality > 0
              if item.name != 'Sulfuras, Hand of Ragnaros'
                item.quality = item.quality - 1
              end
            end
          end
        end
      end

      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if item.name == 'Backstage passes to a TAFKAL80ETC concert'
            item.quality = item.quality - item.quality
          end
        end
      end

      if item.sell_in < 0
        if item.name == 'Aged Brie'
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
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
