# foldersync

Simple Tool to sync certain folders specified in synclist from one Mac to another. 

### Usage
```bash
$ cd "<foldersync dir>"
$ export remote_ip="ip of remote machine"
$ ./syncmacs.sh
```
---
### Beware
- Uses rsync, expects rsync to be available on both machines (provided via `--rsyn-path` option)
- **Sync does delete files on destination side, that do not exist in source**
- add --dry-run to rsync command, to test before sync
- synclist.txt should only contain blank lines, no whitespace lines.
