require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ObsFactory::DistributionStrategyOpenSUSELeap15 do
  let(:project) { create(:project, name: 'openSUSE:Leap:15.2') }
  let(:distribution) { ObsFactory::Distribution.new(project) }
  let(:strategy) { distribution.strategy }

  describe '#openqa_version' do
    it { expect(strategy.openqa_version).to eq('15.2') }
  end

  describe '#opensuse_leap_version' do
    it { expect(strategy.opensuse_leap_version).to eq('15.2') }
  end

  describe '#openqa_group' do
    it { expect(strategy.openqa_group).to eq('openSUSE Leap 15') }
  end

  describe '#repo_url' do
    it { expect(strategy.repo_url).to eq('http://download.opensuse.org/distribution/leap/15.2/repo/oss/media.1/media') }
  end

  describe '#url_suffix' do
    it { expect(strategy.url_suffix).to eq('distribution/leap/15.2/iso') }
  end

  describe '#published_arch' do
    it { expect(strategy.published_arch).to eq('x86_64') }
  end

  describe '#test_dvd_prefix' do
    it { expect(strategy.test_dvd_prefix).to eq('000product:openSUSE-dvd5-dvd') }
  end

  describe '#totest_version_package' do
    it { expect(strategy.totest_version_package).to eq('000product:openSUSE-cd-mini-x86_64') }
  end

  describe '#published_version' do
    let(:file) { "openSUSE - openSUSE-15.2-x86_64-Build317.2-Media\nopenSUSE-15.2-x86_64-Build317.2\n1" }

    before do
      stub_request(:get, strategy.repo_url).and_return(body: file)
    end

    it { expect(strategy.published_version).to eq('317.2') }
  end
end
