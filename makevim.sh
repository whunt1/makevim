#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================
#	System Required: CentOS/Debian/Ubuntu
#	Description:  vim Update
#	Version: 1.0.0
#	Author: July
#=================================================

vim_file="/usr/bin/vim"
vim_ver_backup="v8.1.1635"

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}" && Error="${Red_font_prefix}[错误]${Font_color_suffix}" && Tip="${Green_font_prefix}[注意]${Font_color_suffix}"

check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
	bit=`uname -m`
}
Check_vim_ver(){
	echo -e "${Info} 开始获取 vim 最新版本..."
	vim_ver=$(wget -qO- "https://github.com/vim/vim/tags"|grep "/vim/vim/releases/tag/"|head -1|sed -r 's/.*tag\/(.+)\">.*/\1/')
	[[ -z ${vim_ver} ]] && vim_ver=${vim_ver_backup}
	echo -e "${Info} vim 最新版本为 ${Green_font_prefix}[${vim_ver}]${Font_color_suffix} !"
}
Install_vim(){
	if [[ -e ${vim_file} ]]; then
		echo -e "${Error} vim 已安装 , 是否覆盖安装(或者更新)？[y/N]"
		read -e -p "(默认: n):" yn
		[[ -z ${yn} ]] && yn="n"
		if [[ ${yn} == [Nn] ]]; then
			echo "已取消..." && exit 1
		fi
	else
		echo -e "${Info} vim 未安装，开始安装..."
	fi
	Check_vim_ver
	check_sys
	if [[ ${release} == "centos" ]]; then
		yum update
		echo -e "${Info} 安装依赖..."
		yum -y groupinstall "Development Tools"
		echo -e "${Info} 下载..."
		wget  --no-check-certificate -O vim-${vim_ver}.tar.gz "https://github.com/vim/vim/archive/${vim_ver}.tar.gz"
		if [[ -e vim-${vim_ver}.tar.gz ]]; then
			echo  -e "${Info} 下载成功..."
		else
			[[ ! -e vim-${vim_ver}.tar.gz ]] && echo -e "${Error} vim 下载失败 !" && exit 1
		fi
		echo -e "${Info} 解压..."
		tar -xzf vim-${vim_ver}.tar.gz
		cd vim-*/src
		echo -e "${Info} 编译安装..."
		make -j2
		make install
		mv vim /usr/bin
	else
		apt-get update
		echo -e "${Info} 安装依赖..."
		apt-get install -y build-essential
		echo -e "${Info} 下载..."
		wget  --no-check-certificate -O vim-${vim_ver}.tar.gz "https://github.com/vim/vim/archive/${vim_ver}.tar.gz"
		if [[ -e vim-${vim_ver}.tar.gz ]]; then
			echo  -e "${Info} 下载成功..."
		else
			[[ ! -e vim-${vim_ver}.tar.gz ]] && echo -e "${Error} vim 下载失败 !" && exit 1
		fi
		echo -e "${Info} 解压..."
		tar -xzf vim-${vim_ver}.tar.gz
		cd vim-*/src
		echo -e "${Info} 编译安装..."
		make -j2
		make install
		mv vim /usr/bin
	fi
	cd ../../
	rm -rf vim-${vim_ver}.tar.gz
	rm -rf vim-*
	[[ ! -e ${vim_file} ]] && echo -e "${Error} vim 安装失败 !" && exit 1
	echo && echo -e "${Info} vim 安装成功 !" && echo
}
action=$1
[[ -z $1 ]] && action=install
case "$action" in
	install)
	Install_vim
	;;
    *)
    echo "输入错误 !"
    echo "用法: [ install ]"
    ;;
esac