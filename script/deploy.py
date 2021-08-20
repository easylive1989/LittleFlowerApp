#!/usr/bin/python
#
# Copyright 2014 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the 'License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""Uploads apk to rollout track."""

import argparse
import sys
import httplib2
import mimetypes
from apiclient.discovery import build
from oauth2client.service_account import ServiceAccountCredentials, client


# Declare command-line flags.
argparser = argparse.ArgumentParser(add_help=False)
argparser.add_argument('package_name',
                       help='The package name. Example: com.android.sample')
argparser.add_argument('key_json',
                       help='The package name. Example: com.android.sample')
argparser.add_argument('bundle_file',
                       nargs='?',
                       default='test.aab',
                       help='The path to the Bundle file to upload.')
argparser.add_argument('track',
                       nargs='?',
                       default='alpha',
                       help='the track for deploy')

mimetypes.add_type("application/octet-stream", ".apk")
mimetypes.add_type("application/octet-stream", ".aab")

def main(argv):
  flags = argparser.parse_args()
  # Process flags and read their values.
  package_name = flags.package_name
  key_json = flags.key_json
  bundle_file = flags.bundle_file
  track = flags.track

  credentials = ServiceAccountCredentials.from_json_keyfile_name(
      key_json,
      scopes=['https://www.googleapis.com/auth/androidpublisher'])
  http = httplib2.Http()
  http = credentials.authorize(http)

  service = build('androidpublisher', 'v3', http=http)



  try:
    edit_request = service.edits().insert(body={}, packageName=package_name)
    result = edit_request.execute()
    edit_id = result['id']

    apk_response = service.edits().bundles().upload(
        editId=edit_id, packageName=package_name, media_body=bundle_file).execute()

    print('Version code %d has been uploaded' % apk_response['versionCode'])

    track_response = service.edits().tracks().update(
        editId=edit_id,
        track=track,
        packageName=package_name,
        body={u'releases': [{
            u'name': str(apk_response['versionCode']),
            u'versionCodes': [str(apk_response['versionCode'])],
            u'status': u'completed',
        }]}).execute()

    print( 'Track %s is set with releases: %s' % (
        track_response['track'], str(track_response['releases'])))

    commit_request = service.edits().commit(
        editId=edit_id, packageName=package_name).execute()

    print('Edit "%s" has been committed' % (commit_request['id']))

  except client.AccessTokenRefreshError:
    print ('The credentials have been revoked or expired, please re-run the '
           'application to re-authorize')

if __name__ == '__main__':
  main(sys.argv)