require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "fixme"
    end
  end

  # Quality decreases once each day
  # Once the sell by date has passed, Quality degrades twice as fast
  # The Quality of an item is never negative
  # “Aged Brie” actually increases in Quality the older it gets
  # The Quality of an item is never more than 50
  # “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
  # “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert
  # “Conjured” items degrade in Quality twice as fast as normal items
end
