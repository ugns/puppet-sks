require 'spec_helper_acceptance'

describe 'sks class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'sks': }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe package('sks') do
      it { should be_installed }
    end

    describe service('sks') do
      it { should be_enabled }
    end
  end

  context 'non-default parameters' do
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'sks':
        recon_address  => ['10.10.10.10', '10.20.10.10'],
        hkp_address    => ['10.10.10.10', '10.20.10.10'],
        members        => [{
          hostname => 'sks.example.net',
          keyid    => '0xFEEDBEEF',
        },{
          hostname => 'sks.example.org',
          email    => 'oscar@example.org',
          keyid    => '0xABCDFE98',
        },{
          hostname => 'sks.example.com',
        },{
          hostname => 'keyserver.example.net',
          port     => '11371',
          admin    => 'John Doe',
          email    => 'jdoe@example.com',
          keyid    => '0xDEADBEEF',
        },{
          hostname => 'keyserver.example.org',
          admin    => 'Jane Doe',
        },{
          hostname => 'keyserver.example.com',
          admin    => 'J Edgar Hoover',
          keyid    => '0x01234567',
        }],
      }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe package('sks') do
      it { should be_installed }
    end

    describe service('sks') do
      it { should be_enabled }
    end
  end
end
