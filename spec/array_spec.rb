require_relative '../ext/array'

describe 'using ArrayMatrixHelper' do
  describe Array do
    using ArrayMatrixHelper

    describe '.to_matrix' do
      let(:arr) { [[1], [2]] }

      it 'converts the nested array to a matrix' do
        expect(arr.to_matrix).to eq(Matrix.column_vector(arr.flatten))
      end
    end
  end
end
