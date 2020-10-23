require_relative '../gilded_rose'

describe GildedRose do
  describe 'update quality of any item' do
    it "does not change the name" do
      _ = 0
      items = [Item.new("foo", _, _)]

      GildedRose.new(items).update_quality()

      expect(items[0].name).to eq "foo"
    end
  end

  describe 'an item without a special name' do
    context 'with quality 0 and sell in 0' do
      let(:sell_in) { 0 }
      let(:quality) { 0 }

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

    context "with quality 10 and sell in 0" do
      let(:sell_in) { 0 }
      let(:quality) { 10 }

      it "reduces quality to 8" do
        items = [Item.new("foo", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 8
      end
    end

    context "with quality 10 and sell in 1" do
      let(:sell_in) { 1 }
      let(:quality) { 10 }

      it "reduces quality to 9" do
        items = [Item.new("foo", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 9
      end
    end

    context "with quality 1 and sell in 1" do
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

  describe 'an item named "aged brie"' do
    context "with quality 10 and sell in 1" do
      let(:sell_in) { 1 }
      let(:quality) { 10 }

      it "increases quality to 11" do
        items = [Item.new("Aged Brie", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 11
      end
    end
  end

  describe "an item that increases in quality" do
    let(:sell_in) { 1 }
    let(:quality) { 50 }

    describe "aged brie" do
      it "does not increase quality past 50" do
        items = [Item.new("Aged Brie", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end
    end

    describe "backstage passes" do
      it "does not increase quality past 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end
    end
  end
end
