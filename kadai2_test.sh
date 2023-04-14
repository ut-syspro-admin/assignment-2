#!/bin/bash
# Test code for syspro2023 kadai2
# Written by Shinichi Awamoto and Daichi Morita
# Edited by PENG AO

state=0
warn() { echo $1; state=1; }
dir=$(mktemp -d)
trap "rm -rf $dir" 0

kadai-a() {
    if [ -d kadai-a ]; then
        cp -r kadai-a $dir
        pushd $dir/kadai-a > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            warn "kadai-a: Missing Makefile."
        fi

        make measure > /dev/null 2>&1

        if [ ! -f measure ]; then
            warn "kadai-a: Failed to generate the binary(measure) with '$ make measure'"
        fi

        make clean > /dev/null 2>&1

        if [ -f measure ]; then
            warn "kadai-a: Failed to remove the binary(measure) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            warn "kadai-a: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            warn "kadai-a: Missing '-Wall' option."
        fi

        if [ ! -f report-a.txt ]; then
            warn "kadai-a: Missing report-a.txt"
        fi

        popd > /dev/null 2>&1
    else
        warn "kadai-a: No 'kadai-a' directory!"
    fi
}

kadai-b() {
    if [ -d kadai-b ]; then
        cp -r kadai-b $dir
        pushd $dir/kadai-b > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            warn "kadai-b: Missing Makefile."
        fi

        make mycp > /dev/null 2>&1

        if [ ! -f mycp ]; then
            warn "kadai-b: Failed to generate the binary(mycp) with '$ make mycp'"
        fi

        man open > tmp.txt
        ./mycp tmp.txt myresult.txt
        cp tmp.txt result.txt

        if [ ! -z "`diff myresult.txt result.txt`" ]; then
            warn "kadai-b: diff detected between the result of cp and mycp"
        fi

        make clean > /dev/null 2>&1

        if [ -f mycp ]; then
            warn "kadai-b: Failed to remove the binary(mycp) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            warn "kadai-b: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            warn "kadai-b: Missing '-Wall' option."
        fi

        if [ ! -f report-b.txt ]; then
            warn "kadai-b: Missing report-b.txt"
        fi

        popd > /dev/null 2>&1
    else
        warn "kadai-b: No 'kadai-b' directory!"
    fi
}

kadai-c() {
    if [ -d kadai-c ]; then
        cp -r kadai-c $dir
        pushd $dir/kadai-c > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            warn "kadai-c: Missing Makefile."
        fi

        make measure1 > /dev/null 2>&1

        if [ ! -f measure1 ]; then
            warn "kadai-c: Failed to generate the binary(measure1) with '$ make measure1'"
        fi

        make measure2 > /dev/null 2>&1

        if [ ! -f measure2 ]; then
            warn "kadai-c: Failed to generate the binary(measure2) with '$ make measure2'"
        fi

        make clean > /dev/null 2>&1

        if [ -f measure1 ]; then
            warn "kadai-c: Failed to remove the binary(measure1) with '$ make clean'."
        fi

        if [ -f measure2 ]; then
            warn "kadai-c: Failed to remove the binary(measure2) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            warn "kadai-c: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            warn "kadai-c: Missing '-Wall' option."
        fi

        if [ ! -f report-c.txt ]; then
            warn "kadai-c: Missing report-c.txt"
        fi

        popd > /dev/null 2>&1
    else
        warn "kadai-c: No 'kadai-c' directory!"
    fi
}

kadai-d() {
    if [ -d kadai-d ]; then
        cp -r kadai-d $dir
        pushd $dir/kadai-d > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            warn "kadai-d: Missing Makefile."
        fi

        make mywc > /dev/null 2>&1

        if [ ! -f mywc ]; then
            warn "kadai-d: Failed to generate the binary(mywc) with '$ make mywc'"
        fi

        man open > tmp.txt
        ./mywc tmp.txt > myresult.txt
        wc tmp.txt > result.txt

        sed 's/^[ \t]*//' myresult.txt | sed -e 's/\s\+/ /g' > myresult1.txt
        sed 's/^[ \t]*//' result.txt | sed -e 's/\s\+/ /g' > result1.txt

        if [ ! -z "`diff myresult1.txt result1.txt`" ]; then
            warn "kadai-d: diff detected between the result of wc and mywc"
        fi

        make clean > /dev/null 2>&1

        if [ -f mywc ]; then
            warn "kadai-d: Failed to remove the binary(mywc) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            warn "kadai-d: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            warn "kadai-d: Missing '-Wall' option."
        fi

        if [ ! -f report-d.txt ]; then
            warn "kadai-d: Missing report-d.txt"
        fi

        popd > /dev/null 2>&1
    else
        warn "kadai-d: No 'kadai-d' directory!"
    fi
}

kadai-e() {
    if [ -d kadai-e ]; then
        cp -r kadai-e $dir
        pushd $dir/kadai-e > /dev/null 2>&1

        if [ ! -f Makefile ]; then
            echo "kadai-e: Missing Makefile."
        fi

        make myls > /dev/null 2>&1

        if [ ! -f myls ]; then
            echo "kadai-e: Failed to generate the binary(myls) with '$ make myls'"
        fi

        ./myls . > ls1.txt
        for file in `ls .`; do
            if [ `grep $file ls1.txt | wc -l` -eq 0 ]; then
                echo "kadai-e: Failed to list the items in one directory"; break
            fi
        done

        ./myls . .. > ls2.txt
        for file in `ls . ..`; do
            if [ `grep $file ls2.txt | wc -l` -eq 0 ]; then
                echo "kadai-e: Failed to list the items in several directories"; break
            fi
        done

        make clean > /dev/null 2>&1

        if [ -f myls ]; then
            echo "kadai-e: Failed to remove the binary(myls) with '$ make clean'."
        fi

        if [ ! -z "`find . -name \*.o`" ]; then
            echo "kadai-e: Failed to remove object files(*.o) with '$ make clean'."
        fi

        if [ `grep '\-Wall' Makefile | wc -l` -eq 0 ]; then
            echo "kadai-e: Missing '-Wall' option."
        fi

        if [ ! -f report-e.txt ]; then
            echo "kadai-e: Missing report-e.txt"
        fi

        popd > /dev/null 2>&1
    fi
}

if [ $# -eq 0 ]; then
    echo "#############################################"
    echo "Running tests..."
fi
for arg in {a..e}; do
    if [ $# -eq 0 ] || [[ "$@" == *"$arg"* ]]; then kadai-$arg; fi
done
if [ $# -eq 0 ]; then
    if [ $state -eq 0 ]; then echo "All tests have passed!"; fi
    echo "#############################################"
fi
exit $state
