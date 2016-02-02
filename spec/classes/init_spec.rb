require 'spec_helper'

describe 'marathon' do

  let(:marathon) { '/etc/marathon' }
  let(:conf) { '/etc/marathon/conf' }
  let(:zk_dir) { '/etc/mesos' }
  let(:zk) { 'zk://localhost:2181/mesos' }

  context 'with modified parameters' do
    let(:params){{
      :marathon_dir => marathon,
      :conf_dir => conf,
      :zookeeper => zk,
      :mesos_role => 'marathon',
      :event_subscriber => 'http_callback',
      :http_endpoints => 'http://localhost:8085/events',
      :task_launch_timeout => '300000',
    }}

    it { should contain_file(
      "#{conf}/mesos_role"
    ).with_content(/^marathon$/)}

    it { should contain_file(
      "#{conf}/event_subscriber"
    ).with_content(/^http_callback$/)}

    it { should contain_file(
      "#{conf}/http_endpoints"
    ).with_content(/^http:\/\/localhost:8085\/events$/)}

    it { should contain_file(
      "#{conf}/task_launch_timeout"
    ).with_content(/^300000$/)}

    it { should contain_file(
      "#{zk_dir}/zk"
    ).with_content(/^zk:\/\/localhost:2181\/mesos$/)}
  end

  context 'allow changing config directory' do
    let(:my_marathon_dir) { '/tmp/marathon' }
    let(:my_conf_dir) { '/tmp/marathon/conf' }
    let(:params){{
      :marathon_dir => my_marathon_dir,
      :conf_dir => my_conf_dir,
      :mesos_role => 'marathon',
    }}

    it 'contains mesos_role file in config directory' do
      should contain_file(
        "#{my_conf_dir}/mesos_role"
      ).with_content(/^marathon$/)
    end
  end

  context 'with defaults for all parameters' do
    it { should contain_class('marathon') }
    it { should contain_class('marathon::config') }
    it { should contain_class('marathon::params') }
      it { should contain_file(
        "#{conf}/mesos_role"
      ).with_content(/^$/)}

      it { should contain_file(
        "#{conf}/event_subscriber"
      ).with_content(/^$/)}

      it { should contain_file(
        "#{conf}/http_endpoints"
      ).with_content(/^$/)}

      it { should contain_file(
        "#{conf}/task_launch_timeout"
      ).with_content(/^$/)}

      it { should contain_file(
        "#{zk_dir}/zk"
      ).with_content(/^$/)}
  end

  it { should compile.with_all_deps }
end
