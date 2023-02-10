require "test_helper"

class Administrate::Field::CSVTest < Minitest::Test

  csv_data = "A,B,C\n1,2,3"

  describe '#transform' do
    it 'returns a CSV object' do
      csv_field = Administrate::Field::CSV.new(:csv_text, csv_data, :show)
      assert_instance_of CSV, csv_field.transform
    end

    it 'returns nil if data is blank' do
      csv_field = Administrate::Field::CSV.new(:csv_text, '', :show)
      assert_nil csv_field.transform
    end
  end

  describe '#rewind' do
    it 'returns nil if data is blank' do
      csv_field = Administrate::Field::CSV.new(:csv_text, '', :show)
      assert_nil csv_field.rewind
    end

    it 'rewinds CSV object' do
      csv_field = Administrate::Field::CSV.new(:csv_text, csv_data, :show)
      transform_obj = csv_field.transform
      transform_obj.first(2)

      assert_nil transform_obj.first
      csv_field.rewind
      assert_equal %w(A B C), transform_obj.first
    end
  end

  describe '#headers' do
    it 'returns an empty array when has_headers? is false' do
      csv_field = Administrate::Field::CSV.new(:csv_text, csv_data, :show)

      csv_field.stub :has_headers?, false do
        assert_equal [], csv_field.headers
      end
    end

    it 'returns the headers' do
      csv_field = Administrate::Field::CSV.new(:csv_text, csv_data, :show, headers: true)

      assert_equal %w(A B C), csv_field.headers
    end
  end

  describe '#to_partial_path' do
    it 'returns a partial based on the page being rendered' do
      page = :show
      csv_field = Administrate::Field::CSV.new(:csv_text, "hello", page)

      assert_equal "/fields/csv/#{page}", csv_field.to_partial_path
    end
  end

  describe '#truncate' do
    it 'defaults to 50 chars' do
      short = Administrate::Field::CSV.new(:csv_text, lorem(30), :show)
      long = Administrate::Field::CSV.new(:desc, lorem(60), :show)

      assert_equal 30, short.truncate.length
      assert_equal 50, long.truncate.length
    end

    it 'renders an empty string for nil' do
      csv_field = Administrate::Field::CSV.new(:csv_text, nil, :show)
      assert_equal '', csv_field.truncate
    end

    it 'uses truncate option' do
      csv_field = Administrate::Field::CSV.new(:csv_text, lorem(10), :page, truncate: 5)
      assert_equal 5, csv_field.truncate.length
    end

    it 'uses ... to truncate' do
      csv_field = Administrate::Field::CSV.new(:csv_text, lorem(10), :page, truncate: 5)
      assert_equal '...', csv_field.truncate.last(3)
    end
  end

  describe '#blank_sign' do
    it 'returns the default blank value of -' do
      csv_field = Administrate::Field::CSV.new(:csv_text, nil, :page)
      assert_equal '-', csv_field.blank_sign
    end

    it 'uses blank_sign option' do
      csv_field = Administrate::Field::CSV.new(:csv_text, nil, :page, blank_sign: '--')
      assert_equal '--', csv_field.blank_sign
    end
  end

end
