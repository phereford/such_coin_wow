if ActiveRecord::Base.connection.table_exists?('coins')
  Coin.find_each do |coin|
    name = coin.ticker

    klass = Class.new do
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
