#
# Cookbook Name:: openssl
# Provider:: ssl_keypair
# Author:: Ryan Hass <ryan_hass@rapid7.com>
#
# Copyright 2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

chef_gem 'certificate_authority'

require 'openssl'
require 'certificate_authority'

action :create do
  root = CertificateAuthority::Certificate.new
  root.subject.common_name = subject_cn
  root.serial_number.number = Time.now.to_i # TODO: Allow users to define this if they wish.
  unless File.exist?(key_file)
    open(key, 'w') {|k| k.write(root.key_material.generate_key)}
  end
  unless File.exist?(cert_file)
    File.open(cert, 'w') {|c| c.write(root.sign!(signing_profile))}
  end
  root.signing_entity = true
  signing_profile = {"extensions" => {"keyUsage" => {"usage" => ["critical", "keyCertSign"] }} }
  root.sign!(signing_profile)
end
