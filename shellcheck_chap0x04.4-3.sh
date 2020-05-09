#!/usr/bin/env bash

for chap0x04.4-3.sh in ./*.sh;do
        if [[ $chap0x04.4-3.sh =~ $0 ]];then
                continue
        fi
        printf "==================== %s ====================\n" "$chap0x04.4-3.sh"
        bash "$chap0x04.4-3.sh"
        printf "-------------------- %s --------------------\n" "$chap0x04.4-3.sh"
        shellcheck "$chap0x04.4-3.sh"
done
~                                  
