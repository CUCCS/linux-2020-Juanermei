#!usr/bin/env bash
#帮助手册页
function help()
{
	echo "-a             统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比"
	echo "-p             统计不同场上位置的球员数量、百分比"
	echo "-l             名字最长的球员是谁？名字最短的球员是谁？"
	echo "-o             年龄最大的球员是谁？年龄最小的球员是谁？"
	echo "-h             帮助文档"
}

echo '统计2014世界杯运动员数据'
echo '统计不同年龄区间范围（20岁以下、[20-30]、30岁以上）的球员数量、百分比'
echo '统计不同场上位置的球员数量、百分比'
echo '名字最长的球员是谁？名字最短的球员是谁？'
echo '年龄最大的球员是谁？年龄最小的球员是谁？'
echo '---------------------------------------------------------------------'

#显示当前工作目录
dir=`pwd`

#统计不同年龄区间范围的球员数量、百分比
function age_num{ 
	#count1:20岁以下球员数；count2:20-30岁球员数；count3:30岁以上球员数
	count1=0
	count2=0
	count3=0
	i=0
	for i in "${age[@]}";do
		if [[ $i -lt 20 ]]
		then
			((count1++))
		elif [[ $i -gt 30 ]]
		then
			((count3++))
		else
			((count2++))
		fi
	done

	percent1=`awk 'BEGIN{printf "%.1f%%\n",('$count1'/'$count')*100}'`
	percent2=`awk 'BEGIN{printf "%.1f%%\n",('$count2'/'$count')*100}'`
	percent3=`awk 'BEGIN{printf "%.1f%%\n",('$count3'/'$count')*100}'`
	#打印结果,bash不支持浮点运算，借助bc,awk实现
	printf "20岁以下的球员数量为%-3d，占比%.1f%% \n" $count1 $percent1
	printf "20-30岁的球员数量为%-3d，占比%.1f%% \n" $count2 $percent2
	printf "30岁以上的球员数量为%-3d，占比%.1f%% \n" $count3 $percent3
}
#统计不同场上位置的球员数量、百分比
function position_num{
	#数组赋值,遇空格换行
	array=($(awk -vRS=' ' '!a[$1]++' <<< ${position[@]}))
	echo ${array[@]}
	i=0
	#声明member数组，初始化每一位置上的球员数量均为0
	declare -A member
	for((i=0;i<${#array[@]};i++))
		{
			m=${array[$i]}
			member["$m"]=0
		}
		#遍历位置数组，对不同位置上的球员数进行统计
		for each in ${position[@]};do
			case $each in
				${array[0]})
					((member["${array[0]}"]++));;
					${array[1]})
						((member["${array[1]}"]++));;
						${array[2]})
							((member["${array[2]}"]++));;
							${array[3]})
								((member["${array[3]}"]++));;
								${array[4]})
									((member["${array[4]}"]++));;
								esac
							done
							printf "%-10s :%10s %15s  \n" "Position" "Number" "Percent"
							for((i=0;i<${#array[@]};i++))
								{
									temp=${member["${array[$i]}"]}
									percent=`awk 'BEGIN{printf "%.1f%%\n",('$temp'/'$count')*100}'`
									printf "%-10s : %10d %10.8f %% \n" ${array[$i]} $temp $percent
								}
							}
							#名字最长的球员是谁？名字最短的球员是谁？
							function len_name{
								i=0
								min_name=100
								max_name=0
								while [[ i -lt $count ]];do
									name=${player[$i]//\*/}
									n=${#name}
									if [[ n -gt max_name ]];then
										max_name=$n
										max_num=$i
									elif [[ n -lt min_name ]];then
										min_name=$n
										min_num=$i
									fi
									((i++))
								done
								echo "名字最长的球员是 ${player[max_num]//\*/ }"
								echo "名字最短的球员是 ${player[min_num]}"
							}
							#年龄最大的球员是谁？年龄最小的球员是谁?
							function age{
								oldest=0
								youngest=100
								i=0
								while [[ i -lt $count ]];do
									a=age[$i]
									if [[ a -lt $youngest ]];then
										youngest=$a
										max_num=$i
									elif [[ a -gt $oldest ]];then
										oldest=$a
										min_num=$i
									fi
									((i++))
								done
								echo "年龄最大的球员是 ${player[max_num]//\*/ }"
								echo "年龄最小的球员是 ${player[min_num]//\*/ }"
							}
							#主程序
							count=0
							#以行读取文件
							while read line
							do
								((count++))
								if [[ $count -gt 1 ]];then
									#字符串转化为数组,以空格作为分隔
									str=(${line// /*})
									position[$(($count-2))]=${str[4]}
									age[$(($count-2))]=${str[5]}
									player[$(($count-2))]=${str[8]}
								fi
							done < worldcupplayerinfo.tsv
							count=$(($count-1))
							echo "数组元素个数为：$count"



							while [ "$1" != "" ];do
								case "$1" in
									"-a")
										age_num 
										exit 0
										;;
									"-p")
										position_num 
										exit 0
										;;
									"-l")
										len_name 
										exit 0
										;;
									"-o")
										age 
										exit 0
										;;
									"-h")
										help
										exit 0
										;;
								esac
							done
