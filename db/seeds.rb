# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
category1 = Category.create(name: 'laptoops')
category2 = Category.create(name: 'phones')
category3 = Category.create(name: 'books')
category4 = Category.create(name: 'others')
product1 = Product.create(title: '11.22.63',
                          description:
    %(<p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean a ullamcorper velit.
        Duis tincidunt vitae arcu ut aliquet. Donec vestibulum orci gravida vehicula efficitur.
        In finibus elementum consequat. Aenean luctus placerat sagittis. Ut laoreet eget ante et porttitor.
        Suspendisse vel vulputate odio, et ullamcorper sem. Morbi ac tempor arcu.
    </p>),
                          price: 55,
                          category_id: 3)

product2 = Product.create(title: 'Iphone 15',
                          description:
    %(<p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean a ullamcorper velit.
        Duis tincidunt vitae arcu ut aliquet. Donec vestibulum orci gravida vehicula efficitur.
        In finibus elementum consequat. Aenean luctus placerat sagittis. Ut laoreet eget ante et porttitor.
        Suspendisse vel vulputate odio, et ullamcorper sem. Morbi ac tempor arcu.
    </p>),
                          price: 550,
                          category_id: 2)

product3 = Product.create(title: 'DELL',
                          description:
    %(<p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean a ullamcorper velit.
        Duis tincidunt vitae arcu ut aliquet. Donec vestibulum orci gravida vehicula efficitur.
        In finibus elementum consequat. Aenean luctus placerat sagittis. Ut laoreet eget ante et porttitor.
        Suspendisse vel vulputate odio, et ullamcorper sem. Morbi ac tempor arcu.
    </p>),
                          price: 800,
                          category_id: 2)

product4 = Product.create(title: 'Frying pan',
                          description:
    %(<p>
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean a ullamcorper velit.
        Duis tincidunt vitae arcu ut aliquet. Donec vestibulum orci gravida vehicula efficitur.
        In finibus elementum consequat. Aenean luctus placerat sagittis. Ut laoreet eget ante et porttitor.
        Suspendisse vel vulputate odio, et ullamcorper sem. Morbi ac tempor arcu.
    </p>),
                          price: 130,
                          category_id: 4)
