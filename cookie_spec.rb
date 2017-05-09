
require "byebug"
require 'rspec'

require_relative 'cookie'

describe Cookie do

  let(:type)   { "peanut butter" }
  let(:cookie) { Cookie.new(type) }
  let(:time)   { 2 }

  describe "#initialize" do
    context "with valid input" do
      it "creates a new Cookie of the specified type" do
        expect(cookie.type).to eq(type)
      end
    end

    context "with invalid input" do
      it "throws an argument error when not given a type argument" do
        expect { Cookie.new }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#type" do
    it "returns the type of the cookie" do
      expect(cookie.type).to eq(type)
    end
  end


  describe "#bake!" do
    context "with valid input" do
      it "requires an integer time argument" do
        cookie.bake!(time)
        expect(cookie.time_baked).to be > 0
      end
    end

    context "with invalid input" do
      it "requires an integer time argument" do
        expect{cookie.bake!("hello")}.to raise_error
      end
    end

    it "returns the cookie object" do
      expect(cookie.bake!(time)).to be_kind_of(Object)
    end

    it "changes the status of the cookie when given enough time" do
      expect { cookie.bake!(10) }.to change(cookie, :status)
    end
  end

  describe "#status" do
    # it "returns the cookie's current status" do
      context "when unbaked" do
        it "returns the cookie's current status, doughy" do #"is `:doughy`"
          expect(cookie.bake!(5).status).to be == :doughy
        end
      end

    # end

    context "when baked for less than 7 minutes" do
      it "is `:doughy`" do
        expect(cookie.bake!(6).status).to be == :doughy
      end
    end

    context "when baked for at least 7 but less than 10 minutes" do
      it "is `:almost_ready`" do
        expect(cookie.bake!(9).status).to be == :almost_ready
      end
    end

    context "when baked for at least 10 but less than 12 minutes" do
      it "is `:ready`" do
        expect(cookie.bake!(11).status).to be == :ready
      end
    end

    context "when baked for at least 12 minutes" do
      it "is `:burned`" do
        expect(cookie.bake!(12).status).to be == :burned
      end
    end
  end
end