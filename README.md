# vim 一键编译安装脚本

由于 vim 爆出漏洞 [CVE-2019-12735](https://github.com/numirias/security/blob/master/doc/2019-06-04_ace-vim-neovim.md) (相关[poc](https://github.com/mikuKeeper/security/tree/master/data/2019-06-04_ace-vim-neovim))，但是各软件仓库并未更新最新的 vim 版本，故写此脚本自动编译安装以及更新最新 vim 版本

- 脚本说明: vim 一键编译安装脚本
- 系统支持: CentOS6+ / Debian6+ / Ubuntu14+
  
#### 下载安装:

执行下面的代码下载并运行脚本:
```bash
wget -N --no-check-certificate https://raw.githubusercontent.com/whunt1/makevim/master/makevim.sh && chmod +x makevim.sh && bash makevim.sh
```
运行脚本后会直接开始检测安装，如果**以前安装的有 vim** 则还会提示：
```bash
vim 已安装 , 是否覆盖安装(或者更新)？[y/N](默认: n):# 输入 Y 并回车即可。
```
本脚本只有一个 vim 功能，不过 vim 和安装步骤是一样的，但是因为 vim 当前安装的版本无法检测，所以 只能把升级和安装都扔在一起了。   

**手动安装教程：[Upgrade vim](https://gist.github.com/yevrah/21cdccc1dc65efd2a4712781815159fb)**