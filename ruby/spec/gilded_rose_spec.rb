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