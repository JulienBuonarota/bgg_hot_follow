import pexpect
import os
import datetime


def main():
    n = datetime.datetime.now()
    now_str = '_'.join(str(n).split())
    
    path = "/home/brou/Dropbox/bgg_hot_follow/DB_backup/DB_backup_{}".format(now_str)
    
    shell_cmd = "pg_dump BGGDB -h localhost -U bgg > {}".format(path)
    child = pexpect.spawn('/bin/bash', ['-c', shell_cmd])
    child.expect('Password:')
    child.sendline('admin')
    child.expect(pexpect.EOF) # necessary to allow the cmd to complete its execution

if __name__ == '__main__':
    main()

