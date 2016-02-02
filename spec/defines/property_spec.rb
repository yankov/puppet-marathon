require 'spec_helper'

describe 'marathon::property' do
  let(:title) { 'some-property' }
  let(:directory) { '/tmp/marathon-conf' }

  let(:params) {{
    :value   => 'foo',
    :dir     => directory,
    :service => '',
  }}

  it 'should create a property file' do
      should contain_file(
        "#{directory}/#{title}"
      ).with_content(/^foo$/).with({
      'ensure'  => 'present',
      })
  end

  context 'with an empty string value' do
    let(:params) {{
      :value   => '',
      :dir     => directory,
      :service => '',
    }}

    it 'should not contain a property file' do
        should contain_file(
          "#{directory}/#{title}"
        ).with({
        'ensure'  => 'absent',
        })
    end
  end

  context 'with an empty array value' do
    let(:params) {{
      :value   => [],
      :dir     => directory,
      :service => '',
    }}

    it 'should not contain a property file' do
        should contain_file(
          "#{directory}/#{title}"
        ).with({
        'ensure'  => 'absent',
        })
    end
  end

  context 'with a boolean (true) value' do
    let(:params) {{
      :value   => true,
      :dir     => directory,
      :service => '',
    }}

    it 'should contain a property file' do
        should contain_file(
          "#{directory}/?#{title}"
        ).with({
        'ensure'  => 'present',
        })
    end
  end

  context 'with a boolean (false) value' do
    let(:params) {{
      :value   => false,
      :dir     => directory,
      :service => '',
    }}

    it 'should contain a "no-property" file' do
        should contain_file(
          "#{directory}/?no-#{title}"
        ).with({
        'ensure'  => 'present',
        })
    end
  end

  context 'with a numeric value' do
    let(:params) {{
      :value   => 3.14,
      :dir     => directory,
      :service => '',
    }}

    it 'should contain a property file' do
        should contain_file(
          "#{directory}/#{title}"
        ).with_content(/^3.14$/).with({
      'ensure'  => 'present',
      })
    end
  end
end