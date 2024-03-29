# frozen_string_literal: true

control 'php.fpm.config.file' do
  title 'Verify the subcomponent configuration file'

  describe file('/etc/php-fpm-formula.conf') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') do
      should include(
        '# File managed by Salt at ' \
        '<salt://php/fpm/config/files/default/' \
        'fpm-example.tmpl.jinja>.'
      )
    end
    its('content') do
      should include(
        'This is another subcomponent example file from SaltStack ' \
        'template-formula.'
      )
    end
  end
end
