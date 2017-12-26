require 'spec_helper'

RSpec.describe DomainObjectArgumentError do
  it do
    expect { raise described_class.new('argument error') }
      .to raise_error(described_class) do |error|
        expect(error).to_not be_translatable
        expect(error.message).to eq('argument error')
      end
  end

  it do
    expect { raise described_class.i18n(:invalid, count: 7, scope: [:a, :b, :c]) }
      .to raise_error(described_class) do |error|
        aggregate_failures do
          expect(error.i18n_key).to eq(:invalid)
          expect(error.i18n_options).to eq({ count: 7, scope: [:a, :b, :c] })
          expect(error).to be_translatable
        end
      end
  end

  it do
    expect { raise described_class.i18n(:inclusion) }
      .to raise_error(described_class) do |error|
        aggregate_failures do
          expect(error.i18n_key).to eq(:inclusion)
          expect(error.i18n_options).to eq({ scope: [:errors, :messages] })
          expect(error).to be_translatable
        end
      end
  end
end
