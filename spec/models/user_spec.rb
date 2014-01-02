require 'spec_helper'

describe User do
  it { should have_many(:coins) }
  it { should have_many(:transactions).through(:coins) }
end
