require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    before { GildedRose.new(items).update_quality }

    context 'of one item with zero quality and zero time left to sell' do
      let(:item) { Item.new('foo', 0, 0) }
      let(:items) { [item] }

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

      it 'changes time left to sell to negative 1' do
        expect(item.sell_in).to eq -1
      end
    end

    # Quality decreases once each day
    # sell_in decreases once per day
    context 'of one item with ten quality' do
      let(:item) { Item.new('foo', sell_in, 10 )}
      let(:items) { [item] }

      context 'with ten days left to sell' do
        let(:sell_in) { 10 }

        it 'changes quality to 9' do
          expect(item.quality).to eq 9
        end

        it 'changes the days left to sell to 9' do
          expect(item.sell_in).to eq 9
        end
      end

      context 'with one day left to sell' do
        let(:sell_in) { 1 }

        it 'changes quality to 9' do
          expect(item.quality).to eq 9
        end

        it 'changes the days left to sell to 0' do
          expect(item.sell_in).to eq 0
        end
      end

      # Once the sell by date has passed, Quality degrades twice as fast
      context 'with zero days left to sell' do
        let(:sell_in) { 0 }

        it 'changes quality to 8' do
          expect(item.quality).to eq 8
        end

        it 'changes the days left to sell to -1' do
          expect(item.sell_in).to eq -1
        end
      end

      # Once the sell by date has passed, Quality degrades twice as fast
      context 'one day past its sell-by date' do
        let(:sell_in) { -1 }

        it 'changes quality to 8' do
          expect(item.quality).to eq 8
        end

        it 'changes the days left to sell to -2' do
          expect(item.sell_in).to eq -2
        end
      end
    end

    # “Aged Brie” actually increases in Quality the older it gets
    context 'of aged brie' do
      let(:items) { [item] }
      let(:item) { Item.new('Aged Brie', sell_in, quality ) }

      context 'with ten quality' do
        let(:quality) { 10 }

        context 'with one day left to sell' do
          let(:sell_in) { 1 }

          it 'changes quality to 11' do
            expect(item.quality).to eq(11)
          end
        end

        # and apparently increases at double speed if it goes out of date!
        context 'with zero days left to sell' do
          let(:sell_in) { 0 }

          it 'changes quality to 12' do
            expect(item.quality).to eq(12)
          end
        end

        context 'one day past its sell-by date' do
          let(:sell_in) { -1 }

          it 'changes quality to 12' do
            expect(item.quality).to eq(12)
          end
        end
      end

      # The Quality of an item is never more than 50
      context 'with fifty quality and one day left to sell' do
        let(:quality) { 50 }
        let(:sell_in) { 1 }

        it 'does not change quality' do
          expect(item.quality).to eq(50)
        end
      end
    end
  end

  # “Sulfuras”, being a legendary item, never has to be sold or decreases in Quality
  # “Backstage passes”, like aged brie, increases in Quality as it’s SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert
  # “Conjured” items degrade in Quality twice as fast as normal items
end
