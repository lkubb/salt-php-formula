# frozen_string_literal: true

control 'php.package.install' do
  title 'The required package should be installed'

  package_name = 'php'

  describe package(package_name) do
    it { should be_installed }
  end
end
