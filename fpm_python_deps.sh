import os
import sys
import glob
import subprocess


def get_pkg_deps(package, dependencies):
    print "get deps called"
    print "package name is %s" % package
    depstring = subprocess.check_output(["rpm", "-qRp", package]).split('\n')
    for line in depstring:
        if line.startswith("python-"):
            line = line.split()
            pkgname = line[0][7:]
            version = ''.join(line[1:])
            try:
                dependencies[pkgname] += version
            except KeyError:
                dependencies[pkgname] = version
    return dependencies

def main():
    root_pkg = sys.argv[1]
    dependencies = {root_pkg: ''}

    changed = True
    while changed:
        changed = False
        for (pkg, versions) in dependencies.items():
            print "Checking %s..." % pkg
            pkg_full_name = glob.glob("python-%s-[0-9]*.rpm" % pkg)
            if len(pkg_full_name) == 1:
                print "file found, adding dependencies..."
                get_pkg_deps(pkg_full_name[0], dependencies)
            else:
                print pkg
                ## THIS DOESN'T WORK!
                # os.system("fpm -s python -t rpm %s" % pkg)
                changed = True
        print dependencies
        changed = False

if __name__ == "__main__":
    main()
