# Joe-test-project

## Tagging Scheme

This project aims to implement a Semantic Version tagging Scheme in the form of:

'''registry/image:Major.Minor.Patch.'''

#### Using buildandpush.sh

Images can be created, tagged and pushed using 'buildandpush.sh' with the options [-Mmp] and the current three component number X.Y.Z Example './buildandpush.sh -m 1.1.1'. The script will increment for you provided you're still working with localhost.

Valid identifiers are [0-9] only and hasn't been tested for [A-Za-z], arguments must be given in order to sucessfully execute.