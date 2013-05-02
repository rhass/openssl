#
# Cookbook Name:: openssl
# Resource:: 
#
# Copyright:: 2010, Opscode, Inc <legal@opscode.com>
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
actions :create, :sign, :revoke

attribute :key,        :kind_of => String
attribute :cert,       :kind_of => String
attribute :days_valid, :kind_of => Interger,  :default => 730
attribute :subject_cn, :kind_of => String,    :default => node['fqdn']
attribute :algorithmm, :kind_of => String,    :default => 'rsa'
attribute :length,     :kind_of => Interger,  :default => 2048
attribute :digest,     :kind_of => String,    :default => 'sha1'
attribute :structure,  :kind_of => String,    :default => 'x509'

