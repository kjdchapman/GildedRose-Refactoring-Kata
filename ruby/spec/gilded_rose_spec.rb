require_relative '../gilded_rose'

describe GildedRose do
  describe 'update quality of any item' do
    it "does not change the name" do
      _ = 0
      items = [Item.new("foo", _, _)]

      GildedRose.new(items).update_quality()

      expect(items[0].name).to eq "foo"
    end

    it "does not reduce quality below zero" do
      _ = ""
      past_sell_by_date = 0
      minimum_quality = 0

      items = [Item.new("", past_sell_by_date, minimum_quality)]
      GildedRose.new(items).update_quality()

      expect(items[0].quality).to eq minimum_quality
    end

    it "reduces sell_in by 1" do
      _ = ""
      __ = 0
      sell_in = 10

      items = [Item.new(_, sell_in, __)]
      GildedRose.new(items).update_quality()

      expect(items[0].sell_in).to eq sell_in - 1
    end

    it "continues to reduce sell in below zero" do
      _ = ""
      __ = 0
      past_sell_by_date = 0

      items = [Item.new(_, past_sell_by_date, __)]
      GildedRose.new(items).update_quality()

      expect(items[0].sell_in).to eq -1
    end
  end

  describe 'an item without a special name' do
    context "when it has sell in days left" do
      let(:sell_in) { 1 }
      let(:quality) { 10 }

      it "reduces quality by 1" do
        items = [Item.new("foo", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq quality - 1
      end
    end

    context "when passed sell by date" do
      let(:sell_in) { 0 }
      let(:quality) { 10 }

      it "reduces quality by 2" do
        items = [Item.new("foo", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq quality - 2
      end
    end
  end

  describe 'an item named "Sulfuras, Hand of Ragnaros"' do
    let(:_) { 0 }
    let(:quality) { 80 }

    it "stays at quality 80" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", _, quality)]
      GildedRose.new(items).update_quality()

      expect(items[0].quality).to eq 80
    end
  end

  describe 'an item named "aged brie"' do
    context "when it has sell in days left" do
      let(:sell_in) { 1 }
      let(:quality) { 10 }

      it "increases quality by 1" do
        items = [Item.new("Aged Brie", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq quality + 1
      end
    end

    context "when passed sell by date" do
      let(:sell_in) { 0 }
      let(:quality) { 10 }

      it "increases quality by 2" do
        items = [Item.new("Aged Brie", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq quality + 2
      end
    end

    context "when passed sell by date and quality is near maximum" do
      let(:sell_in) { 0 }
      let(:quality) { 49 }

      it "does not increase quality past 50" do
        items = [Item.new("Aged Brie", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end
    end

    context "when the quality is 50" do
      let(:_) { 1 }
      let(:quality) { 50 }

      it "does not increase quality past 50" do
        items = [Item.new("Aged Brie", _, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end
    end
  end

  describe 'an item named "Backstage passes to a TAFKAL80ETC concert"' do
    context "when it has eleven sell in days left" do
      let(:sell_in) { 11 }
      let(:quality) { 10 }

      it "increases quality by 1" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq quality + 1
      end
    end

    context "when it has ten sell in days left" do
      let(:sell_in) { 10 }
      let(:quality) { 10 }

      it "increases quality by 2" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq quality + 2
      end
    end

    context "when it has five sell in days left" do
      let(:sell_in) { 5 }
      let(:quality) { 10 }

      it "increases quality by 3" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq quality + 3
      end
    end

    context "when it has one sell in days left" do
      let(:sell_in) { 1 }
      let(:quality) { 10 }

      it "increases quality by 3" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq quality + 3
      end
    end

    context "when it has zero sell in days left" do
      let(:sell_in) { 0 }
      let(:_) { 10 }

      it "decreases quality to 0" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, _)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to be_zero
      end
    end

    context "when the quality is 50" do
      let(:sell_in) { 1 }
      let(:quality) { 50 }

      it "does not increase quality past 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end
    end

    context "when nearly sell by date and quality is near maximum" do
      let(:sell_in) { 1 }
      let(:quality) { 49 }

      it "does not increase quality past 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 50
      end
    end
  end
end
