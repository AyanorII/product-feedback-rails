require 'json'
require 'faker'
class Seeder
  def initialize
    serialized_data = File.read('db/data.json')
    @data = JSON.parse(serialized_data)
  end

  def run
    clear_database(User, Comment, Product)
    seed_users
    seed_products
  end

  private

  def clear_database(*models)
    puts 'Cleaning database...'

    models.each do |model|
      record_count = model.count
      model.destroy_all
      puts "Destroyed #{record_count} #{model.to_s.downcase.pluralize}!"
    end

    puts 'Finished cleaning database!'
  end

  def seed_users
    puts ''
    puts 'Creating users...'

    10.times do
      user =
        User.create!(
          email: Faker::Internet.email,
          password: Faker::Internet.password,
          username: Faker::Internet.username,
          name: Faker::Name.name,
          photo: Faker::Avatar.image,
        )

      puts "Created user: #{user.username}"
    end

    puts "Finished seeding users. #{User.count} users created!"
  end

  def create_product(data)
    Product.create!(
      title: data['title'],
      description: data['description'],
      status: data['status'].underscore.to_sym,
      category: data['category'].to_sym,
      upvotes: data['upvotes'],
      user: User.all.sample,
    )
  end

  def create_comment(content, product, parent = nil)
    if parent
      Comment.create!(
        content: content,
        product: product,
        user: User.all.sample,
        parent: parent,
      )
    else
      Comment.create!(content: content, product: product, user: User.all.sample)
    end
  end

  def seed_comments(comments, product)
    puts "\nCreating comments for product: #{product.title}..."

    comments.each do |product_comment|
      created_comment = create_comment(product_comment['content'], product)

      puts 'Created comment'

      replies = product_comment['replies']
      replies&.each do |reply|
        create_comment(reply['content'], product, created_comment)

        puts 'Created reply'
      end
    end
  end

  def seed_products
    puts ''
    puts 'Seeding products...'

    @data.each do |product_request|
      product = create_product(product_request)
      comments = product_request['comments']
      seed_comments(comments, product) if comments
    end

    puts "Finished seeding products. #{Product.count} products created"
  end
end

seeder = Seeder.new
seeder.run
