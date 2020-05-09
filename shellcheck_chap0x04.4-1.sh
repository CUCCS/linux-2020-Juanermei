#!/usr/bin/env bash

for chap0x04.4-1.sh in ./*.sh;do
        if [[ $chap0x04.4-1.sh =~ $0 ]];then
                continue
        fi
        printf "==================== %s ====================\n" "$chap0x04.4-1.sh"
        bash "$chap0x04.4-1.sh"
        printf "-------------------- %s --------------------\n" "$chap0x04.4-1.sh"
        shellcheck "$chap0x04.4-1.sh"
done
