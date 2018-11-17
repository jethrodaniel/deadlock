require_relative '../ext/matrix_helper'

describe 'using MatrixHelper' do
  using MatrixHelper

  describe Array do
    describe '.to_matrix' do
      let(:arr) { [[1], [2]] }

      it 'converts the nested array to a matrix' do
        expect(arr.to_matrix).to eq(Matrix.column_vector(arr.flatten))
      end
    end
  end

  describe Vector do
    describe '.lt_or_eq_all?' do
      let(:a) { Vector[1, 2] }
      let(:b) { Vector[3, 4] }

      it 'whether each element is less than its corresponding element in arr' do
        expect(a.lt_or_eq_all?(b)).to eq(true)
      end
    end
  end
end
