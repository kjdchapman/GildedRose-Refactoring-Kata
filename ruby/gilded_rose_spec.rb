require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    before { GildedRose.new(items).update_quality }

    context 'of one normal item with ten quality' do
      let(:item) { Item.new('foo', sell_in, 10 )}
      let(:items) { [item] }

      context 'with ten days left to sell' do
        let(:sell_in) { 10 }

        it 'decreases quality by one' do
          expect(item.quality).to eq 9
        end

        it 'decreases days left to sell by 1' do
          expect(item.sell_in).to eq 9
        end
      end

      context 'with one day left to sell' do
        let(:sell_in) { 1 }

        it 'decreases quality by one' do
          expect(item.quality).to eq 9
        end

        it 'decreases days left to sell by 1' do
          expect(item.sell_in).to eq 0
        end
      end

      context 'with zero days left to sell' do
        let(:sell_in) { 0 }

        it 'decreases quality by two' do
          expect(item.quality).to eq 8
        end
      end

      context 'one day past its sell-by date' do
        let(:sell_in) { -1 }

        it 'decreases quality by two' do
          expect(item.quality).to eq 8
        end
      end
    end

    context 'of one normal item with zero quality and zero time left to sell' do
      let(:item) { Item.new('foo', 0, 0) }
      let(:items) { [item] }

      it 'does not change its name' do
        expect(item.name).to eq 'foo'
      end

      it 'does not change its quantity' do
        expect(items.count).to eq 1
      end

      it 'does not reduce its quality' do
        expect(item.quality).to eq 0
      end

      it 'changes time left to sell to negative 1' do
        expect(item.sell_in).to eq -1
      end
    end

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

      context 'with fifty quality and one day left to sell' do
        let(:quality) { 50 }
        let(:sell_in) { 1 }

        it 'does not change quality' do
          expect(item.quality).to eq(50)
        end
      end

      context 'with fifty quality and one day left to sell' do
        let(:quality) { 50 }
        let(:sell_in) { -1 }

        it 'does not change quality' do
          expect(item.quality).to eq(50)
        end
      end
    end

    context 'of Sulfuras, Hand of Ragnaros' do
      let(:items) { [item] }
      let(:item) { Item.new('Sulfuras, Hand of Ragnaros', sell_in, quality ) }

      context 'with ten quality and one day left to sell' do
        let(:quality) { 10 }
        let(:sell_in) { 1 }

        it 'does not change quality' do
          expect(item.quality).to eq(10)
        end

        it 'does not change the days left to sell' do
          expect(item.sell_in).to eq(1)
        end
      end

      context 'with five hundred quality and zero days left to sell' do
        let(:quality) { 500 }
        let(:sell_in) { 0 }

        it 'does not change quality' do
          expect(item.quality).to eq(500)
        end

        it 'does not change the days left to sell' do
          expect(item.sell_in).to eq(0)
        end
      end
    end

    context 'of Backstage passes to a TAFKAL80ETC concert' do
      let(:items) { [item] }
      let(:item_name) { 'Backstage passes to a TAFKAL80ETC concert' }
      let(:item) { Item.new(item_name, sell_in, quality) }

      context 'with 10 quality' do
        let(:quality) { 10 }

        context 'and eleven days left to sell' do
          let(:sell_in) { 11 }

          it 'increases quality by 1' do
            expect(item.quality).to eq(11)
          end

          it 'decreases days left to sell by one' do
            expect(item.sell_in).to eq(10)
          end
        end

        context 'and ten days left to sell' do
          let(:sell_in) { 10 }

          it 'increases quality by 2' do
            expect(item.quality).to eq(12)
          end
        end

        context 'and six days left to sell' do
          let(:sell_in) { 6 }

          it 'increases quality by 2' do
            expect(item.quality).to eq(12)
          end
        end

        context 'and five days left to sell' do
          let(:sell_in) { 5 }

          it 'increases quality by 3' do
            expect(item.quality).to eq(13)
          end
        end

        context 'and one day left to sell' do
          let(:sell_in) { 1 }

          it 'increases quality by 3' do
            expect(item.quality).to eq(13)
          end
        end

        context 'and zero days left to sell' do
          let(:sell_in) { 0 }

          it 'drops quality to 0' do
            expect(item.quality).to eq(0)
          end
        end
      end

      context 'with 50 quality' do
        let(:quality) { 50 }

        context 'and no days left to sell' do
          let(:sell_in) { 0 }

          it 'sets quality to 0' do
            expect(item.quality).to eq(0)
          end
        end
      end
    end

    context 'two normal items' do
      let(:items) { [Item.new('foo', 5, 5 ), Item.new('bar', 5, 5 )] }

      it 'decrease in quality and time left to sell' do
        expect(items.map(&:to_s)).to match_array([
          'foo, 4, 4',
          'bar, 4, 4'
        ])
      end
    end

    context 'two normal items and a very old brie' do
      let(:items) do
        [
          Item.new('foo', 5, 5 ),
          Item.new('bar', 5, 5 ),
          Item.new('Aged Brie', -5, 5 ),
        ]
      end

      it 'change quality and time left to sell correctly' do
        expect(items.map(&:to_s)).to match_array([
          'foo, 4, 4',
          'bar, 4, 4',
          'Aged Brie, -6, 7'
        ])
      end
    end

    context 'all the special items' do
      let(:items) do
        [
          Item.new('Sulfuras, Hand of Ragnaros', 5, 50 ),
          Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 50 ),
          Item.new('Aged Brie', -5, 50 ),
        ]
      end

      it 'change quality and time left to sell correctly' do
        expect(items.map(&:to_s)).to match_array([
          'Sulfuras, Hand of Ragnaros, 5, 50',
          'Backstage passes to a TAFKAL80ETC concert, -1, 0',
          'Aged Brie, -6, 50'
        ])
      end
    end
  end
end
