require_relative '../ext/array'

describe 'using ArrayMatrixHelper' do
  describe Array do
    using ArrayMatrixHelper

    let(:a) { [[1], [2]] }
    let(:b) { [[3], [4]] }

    describe '.to_matrix' do
      it 'converts the array to a matrix' do
        [a, b].each do |vector|
          expect(vector.to_matrix).to eq(Matrix.column_vector(vector.flatten))
        end
      end
    end

    describe '.lt_or_eq_all? b' do
      it 'whether each element is less than its corresponding element in arr' do
        expect(a.lt_or_eq_all? b).to eq(true)
      end
    end
  end
end
