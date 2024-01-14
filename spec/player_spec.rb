require './lib/player'

describe ConnectFour::Player do
  subject(:player) { ConnectFour::Player.new('XYZ', "\u{1F535}") }

  describe '#get_input' do
    context 'when the player inputs a valid number' do
      before do
        allow(player).to receive(:puts)
        allow(player).to receive(:gets).and_return('3')
      end

      it 'returns 3' do
        expect(player.get_input(2, 4)).to eq(3)
      end
    end

    context 'when the player inputs an invalid number then a valid number' do
      before do
        allow(player).to receive(:puts)
        allow(player).to receive(:gets).and_return('7', '4')
      end

      it 'returns 4' do
        expect(player.get_input(2, 4)).to eq(4)
      end
    end
  end
end
