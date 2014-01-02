module DynamicCoinKlassHelper
  def set_klass(coin)
    klass = Class.new do
      def self.user
        'doge123adklj'
      end

      def self.password
        'pEhAtHa4AjexewR'
      end

      def self.port
        22555
      end
    end

    Object.const_set(coin.ticker, klass)
  end
end
