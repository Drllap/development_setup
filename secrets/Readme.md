### Tools to safely share secrets between machines via git

#### `keys_read_from_file`
* Reads the `secrets/plain.txt` and uses `awk` to create environmental variables from it
* The function is created, executed and then removed when `secrets/secret-handlers.sh` is sourced

#### `keys_encrypt`
* Encrypts `secrets/plain.txt` into `secrets/encrypted.gpg` by running `gpg`.
* `gpg` will prompt the user for a passphrase to encrypt the file with.
* Creates `secrets/plain.txt.sha256sum` by running `sha256sum` on `secrets/plain.txt`.
* The `secrets/plain.txt.sha256sum` will be checked in to the repo with the `secrets/encrypted.gpg`
  so we can check if the `secrets/plain.txt` file has chanced without decrypting the `secrets/encrypted.gpg`.

#### `keys_check`
* Calculates the SHA-256 sum of the `secrets/plain.txt`
* Reads the `secrets/plain.txt.sha256sum`
* Compares the SHA-256 sums
* Print message on whether or not they compare equal 

#### `keys_decrypt`
* Runs `gpg` on `secrets/encrypted.gpg` 
* The user will be prompted for a passphrase
* Uses the passphrase to decrypt the file and saves it to `secrets/plain.txt`

#### Requires: 
  * gnupg
  * sha256sum

### Usage:

1. Add the key to encrypt to `secrets/plain.txt`.
1. Run `keys_encrypt` to encrypt the file into `secrets/encrypted.gpg`.
1. Commit and push the new `secrets/encrypted.gpg` and `secrets/plain.txt.sha256sum`.
1. Pull the new files on the other machine.
1. Run `keys_check` to check if the secrete file has been updated.
1. Run `keys_decrypt` to update the secrets file.

