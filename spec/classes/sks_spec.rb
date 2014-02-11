require 'spec_helper'

describe 'sks' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "sks class without any parameters on #{osfamily}" do
        let(:node) { 'sks.example.com' }
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('sks::params') }
        it { should contain_class('sks::install').that_comes_before('sks::config') }
        it { should contain_class('sks::config') }
        it { should contain_class('sks::service').that_subscribes_to('sks::config') }
        it { should contain_class('sks') }

        it { should contain_file('/etc/sks/sksconf').with({
              'ensure' => 'present',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0644',
        }) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^hostname: sks.example.com$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^nodename: sks$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^recon_port: 11370$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^#recon_address: 0.0.0.0$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^hkp_port: 11371$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^#hkp_address: 0.0.0.0$/) }

        it { should contain_file('/etc/sks/membership').with({
              'ensure' => 'present',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0644',
        }) }

        it { should contain_service('sks') }
        it { should contain_package('sks').with_ensure('present') }
      end

      describe "sks class with non-default parameters on #{osfamily}" do
        let(:node) { 'sks.example.com' }
        let(:params) {{
          :server_contact => '0xDEADBEEF',
          :recon_port     => 11372,
          :recon_address  => '10.10.10.10',
          :hkp_port       => 11373,
          :hkp_address    => '10.10.10.10',
          :members        => [{
            'hostname' => 'keyserver.example.net',
          }],
        }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_file('/etc/sks/sksconf').with_content(/^server_contact: 0xDEADBEEF$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^recon_port: 11372$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^recon_address: 10.10.10.10$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^hkp_port: 11373$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^hkp_address: 10.10.10.10$/) }

        it { should contain_file('/etc/sks/membership').with_content(/^keyserver.example.net 11372$/) }
      end

      describe "sks class with multiple address parameter values on #{osfamily}" do
        let(:node) { 'sks.example.com' }
        let(:params) {{
          :recon_address  => ['10.10.10.10', '10.20.10.10'],
          :hkp_address    => ['10.10.10.10', '10.20.10.10'],
          :members        => [{
            'hostname' => 'keyserver.example.net',
            'port'     => '11371',
            'admin'    => 'John Doe',
            'email'    => 'jdoe@example.com',
            'keyid'    => '0xDEADBEEF',
          },{
            'hostname' => 'keyserver.example.org',
            'admin'    => 'Jane Doe',
          },{
            'hostname' => 'sks.example.org',
            'email'    => 'oscar@example.org',
            'keyid'    => '0xABCDFE98',
          },{
            'hostname' => 'sks.example.net',
            'keyid'    => '0xFEEDBEEF',
          }],
        }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_file('/etc/sks/sksconf').with_content(/^recon_address: 10.10.10.10 10.20.10.10$/) }
        it { should contain_file('/etc/sks/sksconf').with_content(/^hkp_address: 10.10.10.10 10.20.10.10$/) }

        it { should contain_file('/etc/sks/membership').with_content(/^keyserver.example.net 11371$/) }
        it { should contain_file('/etc/sks/membership').with_content(/^# John Doe <jdoe@example.com> 0xDEADBEEF$/) }
        it { should contain_file('/etc/sks/membership').with_content(/^keyserver.example.org 11370$/) }
        it { should contain_file('/etc/sks/membership').with_content(/^# Jane Doe$/) }
        it { should contain_file('/etc/sks/membership').with_content(/^# <oscar@example.org> 0xABCDFE98$/) }
        it { should contain_file('/etc/sks/membership').with_content(/^# 0xFEEDBEEF$/) }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'sks class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('sks') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
