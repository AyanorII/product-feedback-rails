require 'json'
require 'faker'

# rubocop:disable Metrics/MethodLength
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

    users = JSON.parse(File.read('db/users.json'))

    users.each do |user|
      first_name = user['name'].split(' ').first.downcase

      User.create!(
        email: Faker::Internet.email,
        password: Faker::Internet.password,
        username: user['username'],
        name: user['name'],
        photo: "#{ActionController::Base.helpers.image_path(first_name)}.jpg",
      )

      puts "Created user: #{user['username']}"
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

  def create_comment(attr = {})
    if attr[:parent]
      Comment.create!(
        content: attr[:content],
        product: attr[:product],
        user: User.find_by(username: attr[:user]),
        parent: attr[:parent],
        replying_to: User.find_by(username: attr[:replying_to]),
      )
    else
      Comment.create!(
        content: attr[:content],
        product: attr[:product],
        user: User.find_by(username: attr[:user]),
      )
    end
  end

  def seed_comments(comments, product)
    puts "\nCreating comments for product: #{product.title}..."

    comments.each do |product_comment|
      created_comment =
        create_comment(
          {
            content: product_comment['content'],
            user: product_comment['user']['username'],
            product: product,
          },
        )

      puts 'Created comment'

      replies = product_comment['replies']
      replies&.each do |reply|
        create_comment(
          {
            content: reply['content'],
            user: reply['user']['username'],
            product: product,
            parent: created_comment,
            replying_to: reply['replyingTo'],
          },
        )

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
