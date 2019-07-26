require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  subject { GildedRose.new(items) }

  describe '#update_quality' do
    context 'of one item with zero quality and zero time left to sell' do
      let(:item) { Item.new('foo', 0, 0) }
      let(:items) { [item] }

      before { subject.update_quality }

      it 'does not change its name' do
        expect(item.name).to eq 'foo'
      end

      it 'does not change its quantity' do
        expect(items.count).to eq 1
      end

      # The Quality of an item is never negative
      it 'does not reduce its quality' do
        expect(item.quality).to eq 0
      end

      it 'makes the time left to sell negative 1' do
        expect(item.sell_in).to eq -1
      end
    end
  end

  # Quality decreases once each day
  # Once the sell by date has passed, Quality degrades twice as fast
  # “Aged Brie” actually increases in Quality the older it gets
  # The Quality of an item is never more than 50
  # “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
  # “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert
  # “Conjured” items degrade in Quality twice as fast as normal items
end
