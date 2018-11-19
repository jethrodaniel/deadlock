# frozen_string_literal: true

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

  describe Matrix do
    describe '.set_row' do
      let(:matrix) { Matrix[[1, 2], [3, 4]] }
      let(:vector) { Vector[9, 9] }

      it 'sets the specified row to the vector' do
        matrix.set_row 0, vector
        expect(matrix.row_vectors.first).to eq(vector)
      end

      it 'raises an exception if the index is out of bounds' do
        expect do
          matrix.set_row -1, vector
          matrix.set_row matrix.row_count + 1, vector
        end.to raise_error(ExceptionForMatrix::ErrDimensionMismatch)
      end

      it 'raises an exception if the vector is not the right size' do
        expect do
          matrix.set_row 0, Vector[]
          matrix.set_row 0, Vector[9]
          matrix.set_row 0, Vector[9, 9, 9]
        end.to raise_error(ExceptionForMatrix::ErrDimensionMismatch)
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

      it "raises an exception if the vectors aren't the same length" do
        expect do
          expect(a.lt_or_eq_all?(Vector[]))
          expect(a.lt_or_eq_all?(Vector[1, 2, 3]))
        end.to raise_error(ExceptionForMatrix::ErrDimensionMismatch)
      end
    end
  end
end
