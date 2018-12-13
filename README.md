## Route53 - Replace multiple IPs in multiple zones

### Dependencies

* [cli53](https://github.com/barnybug/cli53)

### Working flow

			READ FROM				  SCRIPT				WRITE TO
	---------------------------------------------------------------------------
	zones.txt,Route53     			> export.sh         > original_zones/*.zone
	zones.txt,original_zones/*.zone > replace.sh        > changed_zones/*.zone
	zones.txt,changed_zones/*.zone  > apply_changes.sh  > Route53
	zones.txt,original_zones/*.zone > revert_changes.sh > Route53

### Configurations

`AWS_PROFILE`: Configures the AWS profile to be used when running the scripts. The default value is `default`. For information about named profiles, read [CLI - Named Profiles](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html).

`ORIGINAL_ZONES_FOLDER`: Configure the folder where your original zone files will reside. This configuration tells `export.sh` where to write the zones exported from Route53. The default value is `original_zones`.

`CHANGED_ZONES_FOLDER`: Configure the folder where your changed zone files will reside. This configuration tells `replace.sh` where to copy the original zones files and perform the replacements. It also tells `apply_changes.sh` which zone files it should import to Route53. The default value is `changed_zones`.

`ZONE_FILE_EXTENSION`: Configure the zone files extension, without the leading dot. The default value is `zone`.

`ZONES_FILE`: Configure the file where the Route53 Zone IDs are defined. Each row in `ZONES_FILE` specifies a Route53 zone ID. The zone IDs specified there are the ones to be used by `replace.sh`, `apply_changes.sh`, and `revert_changes.sh`. The default value is `zones.txt`.

`MAP_FILE`: Configure the file where the IP mappings are stored. The default value is `maps.txt`.

`MAP_SEPARTOR`. Configure the separator character used to separate the OLD_IP and the NEW_IP in the `MAP_FILE`. The default value is `':'`. Example: `10.1.1.1:172.16.0.10`.

### How to use?

1. Export all zone(s) specified in `zones.txt` from Route53 to `original_zones/*.zone`:

    ./export.sh

2. Define all IP replacements you want to apply to the zones stored in `original_zones/*.zone`. Each row in `maps.txt` should use the following format:

    OLD_IP:NEW_IP

Example:

    10.1.1.1:172.16.0.10
    10.1.1.2:172.16.0.11
    10.1.1.3:172.16.0.12

3. Replace all mapped IPs locally. Each zone in `original_zones/*.zone` will be copied to `changed_zones/*.zone` and the IPs replacement will be applied only to `changed_zones/*.zone`:

    ./replace.sh

4. Apply the changes to Route53 by re-importing the zones from `changed_zones/*.zone`:

    ./apply_changes.sh

If you want to undo/revert/rollback the changes you applied to Route53 in step 4, just run:

    ./revert_changes.sh

This will re-import the zones from `original_zones/*.zone` over the existing zones in Route53.
