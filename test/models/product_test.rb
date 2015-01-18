require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

fixtures:products

test "product attributes must not be empty" do
  product = Product.new
  assert product.invalid?
  assert product.errors[:image_url].any?
  assert product.errors[:description].any?
  assert product.errors[:title].any?
  assert product.errors[:price].any?
end

test "price must be positive" do
  product = Product.new(
    title:"p1",
    image_url:"abc.jpg",
    description:"hahaha"
  )

  product.price = -1
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01"] ,
    product.errors[:price]

  product.price = 0
  assert product.invalid?
  assert_equal ["must be greater than or equal to 0.01" ] ,
    product.errors[:price]

  product.price = 1
  assert product.valid?
  
end

def new_product(image_url)
  Product.new(
    title:"zhiyozho-test-image_url-validate",
    description:"as shown in titlea", 
    price:1,
    image_url:image_url
  )
end

test "image_url must be legal" do
  ok = %w{zhiyozho.jpg zhiyozho.png zhiyozho.gif zhiyozho.Gif}
  bad = %w{zhiyozho.jpg/ zhiyozho.abc}
  
  ok.each do |testString|
    assert new_product(testString).valid? , "#{testString} should be valid"
  end

  bad.each do |testString|
    assert new_product(testString).invalid? , "#{testString} should be invalid"
  end
end

test "title in db should be unique" do
  product = Product.new(
    title: products(:ruby).title,
    description: "hahahahahahahaha...",
    image_url: "hahaha.png",
    price:1
  )
  assert product.invalid?
  assert_equal ["has already been taken"] , product.errors[:title]

end


end

