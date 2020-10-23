require_relative '../gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    context do
      let(:sell_in) { 0 }
      let(:quality) { 0 }

      it "does not change the name" do
        items = [Item.new("foo", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].name).to eq "foo"
      end

      it "does not reduce quality below zero" do
        items = [Item.new("foo", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to be_zero
      end

      it "continues to reduce sell in below zero" do
        items = [Item.new("foo", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq -1
      end
    end

    describe 'products going out of date' do
      context "when sell_in is 0" do
        it "it does reduce quality twice as fast" do
          sell_in = 0
          quality = 10

          items = [Item.new("foo", sell_in, quality)]
          GildedRose.new(items).update_quality()

          expect(items[0].quality).to eq 8
        end
      end

      context "when sell_in is 1" do
        it "does not reduce quality twice as fast" do
          sell_in = 1
          quality = 10

          items = [Item.new("foo", sell_in, quality)]
          GildedRose.new(items).update_quality()

          expect(items[0].quality).to eq 9
        end
      end
    end

    context do
      let(:sell_in) { 1 }
      let(:quality) { 1 }

      it "reduces quality by 1" do
        items = [Item.new("foo", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq quality - 1
      end

      it "reduces sell_in by 1" do
        items = [Item.new("foo", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq sell_in - 1
      end
    end
  end

end