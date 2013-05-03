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
#actions :create, :sign, :revoke
actions :create

attribute :subject_cn, :kind_of => String,    :name_attribute => true, :required => true
attribute :key,        :kind_of => String,    :required => true
attribute :cert,       :kind_of => String,    :required => true
attribute :days_valid, :kind_of => Integer,   :default => 730
attribute :length,     :kind_of => Integer,   :default => 2048, :equal_to => [2048, 3072, 4096]
attribute :digest,     :kind_of => String,    :default => 'SHA1', :equal_to => ['SHA1', 'SHA256']
attribute :structure,  :kind_of => String,    :default => 'x509', :equal_to => ['x509', 'pem']
attribute :serial,     :kind_of => Integer,   :default => Time.now.to_i

attr_accessor :exists
