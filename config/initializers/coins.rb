if ActiveRecord::Base.connection.table_exists?('coins')
  markets = YAML.load_file(Rails.root.join('config', 'markets.yml'))

  Coin.find_each do |coin|
    name = coin.ticker
    coin_markets = markets.detect{|key, value| key == name}.try(:last)

    klass = Class.new do
      coin_markets.each do |market|
        market.each do |type, ids|
          define_singleton_method "#{type.downcase}" do
            ids
          end
        end
      end if coin_markets

      def self.user
        ENV["#{name.upcase}_USER"]
      end

      def self.password
        ENV["#{name.upcase}_PASSWORD"]
      end

      def self.port
        ENV["#{name.upcase}_PORT"]
      end
    end

    Object.const_set(coin.ticker, klass)
  end
end
