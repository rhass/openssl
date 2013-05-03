#
# Cookbook Name:: openssl
# Provider:: generate_keypair
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

def load_current_resource
  begin
    require 'certificate_authority'
  rescue LoadError
    Chef::Log.error("Missing gem 'certificate_authority'. Use the default openssl recipe to install it before using the resource.")
  end

  #@current_resource = CertificateAuthority::Certificate.new(@new_resource.name)
  @current_resource = CertificateAuthority::Certificate.new
  @current_resource.subject.common_name = @new_resource.subject_cn
  @current_resource.serial_number = @new_resource.serial

end

action :create do
  description = "Create SSL Key/Certifcate pair #{new_resource}"
  converge_by(description) do
    status = generate_keypair(@new_resource.subject_cn)
    if status
      new_resource.updated_by_last_action(true)
    end
  end
end

def generate_keypair(scn)
  cert = CertificateAuthority::Certificate.new
  cert.subject.common_name = scn
  cert.serial_number.number = @new_resource.serial

  file @new_resource.key do
    content cert.key_material.generate_key.to_s
    action :create
  end

  file @new_resource.cert do
    content cert.sign!.to_s
    action :create
  end
end
