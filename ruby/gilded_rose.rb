class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if backstage_pass?(item)
        update_backstage_pass_quality(item)
      elsif aged_brie?(item)
        update_aged_brie_quality(item)
      elsif sulfuras?(item)
      else
        update_normal_item_quality(item)
      end

      unless sulfuras?(item)
        item.sell_in -= 1
      end

      unless sulfuras?(item)
        unless backstage_pass?(item) || aged_brie?(item)
          if item.sell_in.negative?
            item.quality -= 1 if item.quality.positive?
          end
        end
      end

      if backstage_pass?(item)
        item.quality = 0 if item.sell_in.negative?
      end

      if sulfuras?(item)
        item.quality = 0 if item.sell_in.negative?
      end
    end
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def backstage_pass?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def update_backstage_pass_quality(item)
    return if item.quality > 50

    if item.sell_in < 6
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
