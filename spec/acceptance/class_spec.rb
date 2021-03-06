require 'spec_helper_acceptance'

describe 'owncloud class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'mysql::server':
        override_options => {
          'mysqld' => { 'bind-address' => '0.0.0.0' }
        },
        restart       => true,
        root_password => 'sup3rt0ps3cr3t',
      }

      class { 'owncloud':
        db_user => 'owncloud',
        db_pass => 'p4ssw0rd',
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe package('owncloud') do
      it { should be_installed }
    end
  end
end
