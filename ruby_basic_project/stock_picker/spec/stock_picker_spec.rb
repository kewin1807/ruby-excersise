require "spec_helper"
require_relative "../main.rb"

RSpec.describe 'Stock picker' do
    describe 'Stock picker' do
        it '[17,3,6,9,15,8,6,1,10] => [1, 4]' do
            expect(stock_picker([17,3,6,9,15,8,6,1,10])).to eq([1, 4])
          end
        end
    end
