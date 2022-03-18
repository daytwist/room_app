FactoryBot.define do
  factory :room do
    name { 'テストルーム' }
    address { '日本' }
    price_per_day { '1000' }
    introduction { 'テスト' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/images/test_image.jpeg')) }
  end
end
