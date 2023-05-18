require 'spec_helper'
require_relative '../main.rb'

RSpec.describe 'Caesar cipher' do
    describe 'Testing Caesar cipher' do
        it 'What a string! factor 5 => Bmfy f xywnsl!' do
            drink_list = caesar_cipher("What a string!", 5)
            expect(drink_list).to eq("Bmfy f xywnsl!")
          end
        end
    end



