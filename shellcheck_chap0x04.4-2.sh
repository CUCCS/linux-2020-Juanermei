#!/usr/bin/env bash

for chap0x04.4-2.sh in ./*.sh;do
        if [[ $chap0x04.4-2.sh =~ $0 ]];then
                continue
        fi
        printf "==================== %s ====================\n" "$chap0x04.4-2.sh"
        bash "$chap0x04.4-2.sh"
        printf "-------------------- %s --------------------\n" "$chap0x04.4-2.sh"
        shellcheck "$chap0x04.4-2.sh"
done
