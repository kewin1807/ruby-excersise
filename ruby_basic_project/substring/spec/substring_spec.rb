require "spec_helper"
require_relative "../main.rb"

RSpec.describe 'Sub string' do
    describe 'Sub string' do
        it 'Test 1' do
            dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
            drink_list = substring("below", dictionary)
            result = { "below" => 1, "low" => 1 }
            expect(drink_list).to eq(result)
          end
        
        it 'Test 2' do
            dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
            drink_list = substring("Howdy partner, sit down! How's it going?", dictionary)
            result = { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }
            expect(drink_list).to eq(result)
        end  
        end
    end
