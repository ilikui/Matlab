> 本文由 [简悦 SimpRead](http://ksria.com/simpread/) 转码， 原文地址 [www.cnblogs.com](https://www.cnblogs.com/lvdongjie/p/8994092.html)

GDB 是一个强大的命令行调试工具。虽然 X Window 提供了 GDB 的图形版 DDD，但是我仍然更钟爱在命令行模式下使用 GDB。大家知道命令行的强大就是在于，其可以形成执行序列，形成脚本。 UNIX 下的软件全是命令行的，这给程序开发提代供了极大的便利，命令行软件的优势在于，它们可以非常容易的集成在一起，使用几个简单的已有工具的命令，就可以做出一个非常强大的功能。

于是 UNIX 下的软件比 Windows 下的软件更能有机地结合，各自发挥各自的长处，组合成更为强劲的功能。而 Windows 下的图形软件基本上是各自为营，互相不能调用，很不利于各种软件的相互集成。在这里并不是要和 Windows 做个什么比较，所谓 “寸有所长，尺有所短”，图形化工具还是有不如命令行的地方。
 

**1 GDB** **概述**

GDB 是 GNU 开源组织发布的一个强大的 UNIX 下的程序调试工具。或许，各位比较喜欢那种图形界面方式的，像 VC、BCB 等 IDE 的调试，但如果你是在 UNIX 平台下做软件，你会发现 GDB 这个调试工具有比 VC、BCB 的图形化调试器更强大的功能。所谓 “寸有所长，尺有所短” 就是这个道理。  
一般来说，GDB 主要帮忙你完成下面四个方面的功能：  
1、启动你的程序，可以按照你的自定义的要求随心所欲的运行程序。  
2、可让被调试的程序在你所指定的调置的断点处停住。（断点可以是条件表达式）  
3、当程序被停住时，可以检查此时你的程序中所发生的事。  
4、动态的改变你程序的执行环境。  
从上面看来，GDB 和一般的调试工具没有什么两样，基本上也是完成这些功能，不过在细节上，你会发现 GDB 这个调试工具的强大，大家可能比较习惯了图形化的调试工具，但有时候，命令行的调试工具却有着图形化工具所不能完成的功能。

**一个调试示例**

源程序：tst.c  
代码:

```c
/**
 * @brief  This is example C code
 *
 * @param argc
 * @param argv
 * @return int
 */
#include <stdio.h>
int func(int n)
{
    int sum = 0, i;
    for (i = 1; i <= 100; i++)

    {
        sum += i;
    }
    return sum;
}

void main()
{
    int i;
    long result = 0;
    for (i = 1; i <= 100; i++)

    result += i;

    printf("result[1-100] = %d", result);
    printf("result[1-250] = %d", func(250));
}
```

编译生成执行文件：（Linux 下）  
root@linux:/home/benben/test# gcc -g tst.c -o tst

使用 GDB 调试，代码:

```
root@linux: /home/benben /test# gdb tst <---------- 启动GDB
GNU gdb 5.1.1
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB. Type "show warranty" for details.
This GDB was configured as "i386-suse-linux"...
(gdb) l <-------------------- l命令相当于list，从第一行开始例出原码。
1 #include
2
3 int func(int n)
4 {
5 int sum=0,i;
6 for(i=0; i
7 {
8 sum+=i;
9 }
10 return sum;
(gdb) <-------------------- 直接回车表示，重复上一次命令
11 }
12
13
14 main()
15 {
16 int i;
17 long result = 0;
18 for(i=1; i<=100; i++)
19 {
20 result += i;
(gdb) break 16 <-------------------- 设置断点，在源程序第16行处。
Breakpoint 1 at 0x8048496: file tst.c, line 16.
(gdb) break func <-------------------- 设置断点，在函数func()入口处。
Breakpoint 2 at 0x8048456: file tst.c, line 5.
(gdb) info break <-------------------- 查看断点信息。
Num Type Disp Enb Address What
1 breakpoint keep y 0x08048496 in main at tst.c:16
2 breakpoint keep y 0x08048456 in func at tst.c:5
(gdb) r <--------------------- 运行程序，run命令简写
Starting program: /home/benben /test/tst
 
Breakpoint 1, main () at tst.c:17 <---------- 在断点处停住。
17 long result = 0;
(gdb) n <--------------------- 单条语句执行，next命令简写。
18 for(i=1; i<=100; i++)
(gdb) n
20 result += i;
(gdb) n
18 for(i=1; i<=100; i++)
(gdb) n
20 result += i;
(gdb) c <--------------------- 继续运行程序，continue命令简写。
Continuing.
result[1-100] = 5050 <----------程序输出。
 
Breakpoint 2, func (n=250) at tst.c:5
5 int sum=0,i;
(gdb) n
6 for(i=1; i<=n; i++)
(gdb) p i <--------------------- 打印变量i的值，print命令简写。
$1 = 134513808
(gdb) n
8 sum+=i;
(gdb) n
6 for(i=1; i<=n; i++)
(gdb) p sum
$2 = 1
(gdb) n
8 sum+=i;
(gdb) p i
$3 = 2
(gdb) n
6 for(i=1; i<=n; i++)
(gdb) p sum
$4 = 3
(gdb) bt <--------------------- 查看函数堆栈。
#0 func (n=250) at tst.c:5
 
#1 0x080484e4 in main () at tst.c:24
 
#2 0x400409ed in __libc_start_main () from /lib/libc.so.6
(gdb) finish <--------------------- 退出函数。
Run till exit from #0 func (n=250) at tst.c:5
 
0x080484e4 in main () at tst.c:24
24 printf("result[1-250] = %d", func(250) );
Value returned is $6 = 31375
(gdb) c <--------------------- 继续运行。
Continuing.
result[1-250] = 31375 <----------程序输出。
 
Program exited with code 027. <--------程序退出，调试结束。
(gdb) q <--------------------- 退出gdb。
root@linux:/home/benben/test#

```

**2 使用 GDB** 
**  
一般来说 GDB 主要调试的是 C/C++ 的程序。要调试 C/C++ 的程序，首先在编译时，我们必须要把调试信息加到可执行文件中。使用编译器（cc/gcc/g++）的 -g 参数可以做到这一点。如：

> gcc -g hello.c -o hello

> g++ -g hello.cpp -o hello  
如果没有 - g，你将看不见程序的函数名、变量名，所代替的全是运行时的内存地址。当你用 - g 把调试信息加入之后，并成功编译目标代码以后，让我们来看看如何用 gdb 来调试他。

**启动 GDB 的方法有以下几种：**

1、gdb program  
program 也就是你的执行文件，一般在当前目录下。

2、gdb program core  
用 gdb 同时调试一个运行程序和 core 文件，core 是程序非法执行后 core dump 后产生的文件。

3、gdb program 1234  
如果你的程序是一个服务程序，那么你可以指定这个服务程序运行时的进程 ID。gdb 会自动 attach 上去，并调试他。program 应该在 PATH 环境变量中搜索得到。  
GDB 启动时，可以加上一些 GDB 的启动开关，详细的开关可以用 gdb -help 查看。下面只列举一些比较常用的参数：

`--symbols=SYMFILE `

从指定文件中读取符号表。

`--se=FILE  `

从指定文件中读取符号表信息，并把他用在可执行文件中。

`--core=COREFILE `

调试时 core dump 的 core 文件。

`--directory=DIR  `

加入一个源文件的搜索路径。默认搜索路径是环境变量中 PATH 所定义的路径。

**3 GDB** **的命令概貌**

启动 gdb 后，就进入 gdb 的调试环境中，就可以使用 gdb 的命令开始调试程序了，gdb 的命令可以使用 help 命令来查看，如下所示：

```c
root@linux:/home/benben# gdb
GNU gdb 5.1.1
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB. Type "show warranty" for details.
This GDB was configured as "i386-suse-linux".
(gdb) help
List of classes of commands:
 
aliases -- Aliases of other commands
breakpoints -- Making program stop at certain points
data -- Examining data
files -- Specifying and examining files
internals -- Maintenance commands
obscure -- Obscure features
running -- Running the program
stack -- Examining the stack
status -- Status inquiries
support -- Support facilities
tracepoints -- Tracing of program execution without stopping the program
user-defined -- User-defined commands
 
Type "help" followed by a class name for a list of commands in that class.
Type "help" followed by command name for full documentation.
Command name abbreviations are allowed if unambiguous.
(gdb)
```

gdb 的命令很多，gdb 把之分成许多个种类。help 命令只是例出 gdb 的命令种类，如果要看种类中的命令，可以使用 help 命令，如：help breakpoints，查看设置断点的所有命令。也可以直接 help 来查看命令的帮助。

gdb 中，输入命令时，可以不用打全命令，只用打命令的前几个字符就可以了，当然，命令的前几个字符应该要标志着一个唯一的命令，在 Linux 下，你可以敲击两次 TAB 键来补齐命令的全称，如果有重复的，那么 gdb 会把其列出来。

**示例一：** 在进入函数 func 时，设置一个断点。可以敲入 break func，或是直接就是 b func

```c
(gdb) b func
Breakpoint 1 at 0x8048458: file hello.c, line 10.
```

**示例二：** 敲入 b 按两次 TAB 键，你会看到所有 b 打头的命令：

```c
(gdb) b
backtrace break bt
```

**示例三：** 只记得函数的前缀，可以这样：

```c
(gdb) b make_ <按TAB键>
（再按下一次TAB键，你会看到:）
make_a_section_from_file make_environ
make_abs_section make_function_type
make_blockvector make_pointer_type
make_cleanup make_reference_type
make_command make_symbol_completion_list
```

GDB 把所有 make 开头的函数全部例出来给你查看。

要退出 gdb 时，只用发 quit 或命令简称 q 就行了。

**4 GDB** **中运行 UNIX 的 shell 程序**

在 gdb 环境中，你可以执行 UNIX 的 shell 的命令，使用 gdb 的 shell 命令来完成：

shell  
调用 UNIX 的 shell 来执行，环境变量 SHELL 中定义的 UNIX 的 shell 将会被用来执行，如果 SHELL 没有定义，那就使用 UNIX 的标准 shell：/bin/sh。  
退出用 exit 命令，回到 gdb 提示符

还有一个 gdb 命令是 make：

`make`

可以在 gdb 中执行 make 命令来重新 build 自己的程序。这个命令等价于 “shell make”。

5 **在 GDB 中运行程序**

当以 gdb 方式启动 gdb 后，gdb 会在 PATH 路径和当前目录中搜索源文件。如要确认 gdb 是否读到源文件，可使用 l 或 list 命令，看看 gdb 是否能列出源代码。

在 gdb 中，运行程序使用 r 或是 run 命令。程序的运行，你有可能需要设置下面四方面的事。

**1** **、程序运行参数。**

set args 可指定运行时参数。（如：set args _10 20 30 40 50_ ）  
show args 命令可以查看设置好的运行参数。

**2** **、运行环境。**

path  
可设定程序的运行路径。  
show paths 查看程序的运行路径。  
set env _environmentVarname=value_ 设置环境变量。如：set env _USER=benben_show env _[varname]_ 查看环境变量，不带 varname，打印出当前所有环境变量。

**3** **、工作目录。**

cd 相当于 shell 的 cd 命令。  
pwd 显示当前的所在目录。

**4** **、程序的输入输出。**

info terminal 显示你程序用到的终端的模式。  
使用重定向控制程序输出。如：run > outfile  
tty 命令可以设置输入输出使用的终端设备。如：tty /dev/tty1

**5** **调试已运行的程序**

两种方法：  
1、在 UNIX 下用 ps 查看正在运行的程序的 PID（进程 ID），然后用 gdb PID _process-id_ 格式挂接正在运行的程序。  
2、先用 gdb 关联上源代码，并进行 gdb，在 gdb 中用 attach _process-id_ 命令来挂接进程的 PID。并用 detach 来取消挂接的进程。

**6** **暂停 / 恢复程序运行**

调试程序中，暂停程序运行是必须的，GDB 可以方便地暂停程序的运行。你可以设置程序的在哪行停住，在什么条件下停住，在收到什么信号时停往等等。以便于你查看运行时的变量，以及运行时的流程。  
当进程被 gdb 停住时，你可以使用 info program 来查看程序的是否在运行，进程号，被暂停的原因。  
在 gdb 中，我们可以有以下几种暂停方式：断点（BreakPoint）、观察点（WatchPoint）、捕捉点（CatchPoint）、信号（Signals）、线程停止（Thread Stops）。如果要恢复程序运行，可以使用 c 或是 continue 命令。

**一、设置断点（BreakPoint）**

我们用 break 命令来设置断点。正面有几点设置断点的方法：

`break _function `

_在进入指定函数时停住。C++ 中可以使用 class::function 或 function(type,type) 格式来指定函数名。

break _linenum  
_在指定行号停住。

break _+offset  
_break _-offset  
_在当前行号的前面或后面的 offset 行停住。offset 为自然数。

break _filename:linenum  
_在源文件 filename 的 linenum 行处停住。

break _filename:function  
_在源文件 filename 的 function 函数的入口处停住。

break _*address  
_在程序运行的内存地址处停住。

break  
break 命令没有参数时，表示在下一条指令处停住。

break ... if _cond_  
... 可以是上述的参数，condition 表示条件，在条件成立时停住。比如在循环境体中，可以设置 break if i=100，表示当 i 为 100 时停住程序。

查看断点时，可使用 info 命令，如下所示：（注：n 表示断点号）  
info breakpoints [n]  
info break [n]  
info watchpoints [n]

**二、设置观察点（WatchPoint）**  
观察点一般来观察某个表达式（变量也是一种表达式）的值是否有变化了，如果有变化，马上停住程序。我们有下面的几种方法来设置观察点：

watch _expr  
_为表达式（变量）expr 设置一个观察点。一量表达式值有变化时，马上停住程序。

rwatch _expr  
_当表达式（变量）expr 被读时，停住程序。

awatch _expr  
_当表达式（变量）的值被读或被写时，停住程序。

info watchpoints  
查看观察点、断点和捕捉点信息，同 **info break** 一样.

**三、设置捕捉点（CatchPoint）**

你可设置捕捉点来补捉程序运行时的一些事件。如：载入共享库（动态链接库）或是 C++ 的异常。设置捕捉点的格式为：

`catch _event_`
  
当 event 发生时，停住程序。event 可以是下面的内容：  
1、throw 一个 C++ 抛出的异常。（throw 为关键字）  
2、catch 一个 C++ 捕捉到的异常。（catch 为关键字）  
3、exec 调用系统调用 exec 时。（exec 为关键字，目前此功能只在 HP-UX 下有用）  
4、fork 调用系统调用 fork 时。（fork 为关键字，目前此功能只在 HP-UX 下有用）  
5、vfork 调用系统调用 vfork 时。（vfork 为关键字，目前此功能只在 HP-UX 下有用）  
6、load 或 load 载入共享库（动态链接库）时。（load 为关键字，目前此功能只在 HP-UX 下有用）  
7、unload 或 unload 卸载共享库（动态链接库）时。（unload 为关键字，目前此功能只在 HP-UX 下有用）

tcatch _event_  
只设置一次捕捉点，当程序停住以后，应点被自动删除。

**四、维护停止点**  
上面说了如何设置程序的停止点，GDB 中的停止点也就是上述的三类。在 GDB 中，如果你觉得已定义好的停止点没有用了，你可以使用 delete、clear、disable、enable 这几个命令来进行维护。

`clear` 

清除所有的已定义的停止点。

`clear _function_ `

清除所有设置在函数上的停止点。

`clear _linenum_`

清除所有设置在指定行上的停止点。  
clear _filename:linenum_  
清除所有设置在指定文件：指定行上的停止点。

delete _[breakpoints] [range...]  
_删除指定的断点，breakpoints 为断点号。如果不指定断点号，则表示删除所有的断点。range 表示断点号的范围（如：3-7）。其简写命令为 d。

比删除更好的一种方法是 disable 停止点，disable 了的停止点，GDB 不会删除，当你还需要时，enable 即可，就好像回收站一样。

disable _[breakpoints] [range...]  
_disable 所指定的停止点，breakpoints 为停止点号。如果什么都不指定，表示 disable 所有的停止点。简写命令是 dis.

enable _[breakpoints] [range...]_  
enable 所指定的停止点，breakpoints 为停止点号。

enable _[breakpoints] once range...  
_enable 所指定的停止点一次，当程序停止后，该停止点马上被 GDB 自动 disable。

enable _[breakpoints] delete range...  
_enable 所指定的停止点一次，当程序停止后，该停止点马上被 GDB 自动删除。

**五、停止条件维护**

前面在说到设置断点时，我们提到过可以设置一个条件，当条件成立时，程序自动停止，这是一个非常强大的功能，这里，我想专门说说这个条件的相关维护命令。一般来说，为断点设置一个条件，我们使用 if 关键词，后面跟其断点条件。并且，条件设置好后，我们可以用 condition 命令来修改断点的条件。（只有 break 和 watch 命令支持 if，catch 目前暂不支持 if）

condition _bnum expression  
_修改断点号为 bnum 的停止条件为 expression。

condition _bnum_  
清除断点号为 bnum 的停止条件。

还有一个比较特殊的维护命令 ignore，你可以指定程序运行时，忽略停止条件几次。  
ignore _bnum count_  
表示忽略断点号为 bnum 的停止条件 count 次。

**六、为停止点设定运行命令**

我们可以使用 GDB 提供的 command 命令来设置停止点的运行命令。也就是说，当运行的程序在被停止住时，我们可以让其自动运行一些别的命令，这很有利行自动化调试。对基于 GDB 的自动化调试是一个强大的支持。  
commands [bnum]  
... command-list ...  
end

为断点号 bnum 指写一个命令列表。当程序被该断点停住时，gdb 会依次运行命令列表中的命令。

例如：  
break foo if x>0  
commands  
printf "x is %d",x  
continue  
end  
断点设置在函数 foo 中，断点条件是 x>0，如果程序被断住后，也就是，一旦 x 的值在 foo 函数中大于 0，GDB 会自动打印出 x 的值，并继续运行程序。

如果你要清除断点上的命令序列，那么只要简单的执行一下 commands 命令，并直接在打个 end 就行了。

**七、断点菜单**

在 C++ 中，可能会重复出现同一个名字的函数若干次（函数重载），在这种情况下，break 不能告诉 GDB 要停在哪个函数的入口。当然，你可以使用 break 也就是把函数的参数类型告诉 GDB，以指定一个函数。否则的话，GDB 会给你列出一个断点菜单供你选择你所需要的断点。你只要输入你菜单列表中的编号就可以了。如：

```c
(gdb) b String::after
[0] cancel
[1] all
[2] file:String.cc; line number:867
[3] file:String.cc; line number:860
[4] file:String.cc; line number:875
[5] file:String.cc; line number:853
[6] file:String.cc; line number:846
[7] file:String.cc; line number:735
> 2 4 6
Breakpoint 1 at 0xb26c: file String.cc, line 867.
Breakpoint 2 at 0xb344: file String.cc, line 875.
Breakpoint 3 at 0xafcc: file String.cc, line 846.
Multiple breakpoints were set.
Use the "delete" command to delete unwanted breakpoints.
(gdb)
```

可见，GDB 列出了所有 after 的重载函数，你可以选一下列表编号就行了。0 表示放弃设置断点，1 表示所有函数都设置断点。

**八、恢复程序运行和单步调试**

当程序被停住了，你可以用 continue 命令恢复程序的运行直到程序结束，或下一个断点到来。也可以使用 step 或 next 命令单步跟踪程序。

continue _[ignore-count]  
_c _[ignore-count]  
_fg _[ignore-count]  
_恢复程序运行，直到程序结束，或是下一个断点到来。ignore-count 表示忽略其后的断点次数。continue，c，fg 三个命令都是一样的意思。

step _[count]_  
单步跟踪，如果有函数调用，他会进入该函数。进入函数的前提是，此函数被编译有 debug 信息。很像 VC 等工具中的 step in。后面可以加 count 也可以不加，不加表示一条条地执行，加表示执行后面的 count 条指令，然后再停住。

next _[count]  
_同样单步跟踪，如果有函数调用，他不会进入该函数。很像 VC 等工具中的 step over。后面可以加 count 也可以不加，不加表示一条条地执行，加表示执行后面的 count 条指令，然后再停住。

set step-mode on  
打开 step-mode 模式，于是，在进行单步跟踪时，程序会因为没有 debug 信息而停住。这个参数有很利于查看机器码。

set step-mod off  
关闭 step-mode 模式。This is the default.  
show step-mode  
Show whether gdb will stop in or step over functions without source line debug  
information.  
finish  
运行程序，直到当前函数完成返回。并打印函数返回时的堆栈地址和返回值及参数值等信息。

until 或 u  
当你厌倦了在一个循环体内单步跟踪时，这个命令可以运行程序直到退出循环体。  
until _location_  
u _location_  
Continue running your program until either the specified location is reached,

or the current stack frame returns. location is any of the forms of argument

acceptable to break. This form of the command uses breakpoints, and hence is quicker than until without an argument. The specified location is actually reached only if it is in the current frame. **This implies that until can be used to skip over recursive function invocations.**

For instance in the code below, if the current location is line 96, issuing until 99 will execute the program up to line 99 in the same invocation of factorial, i.e. after the inner invocations have returned.

```c
94 int factorial (int value)
95 {
96 if (value > 1) {
 
97 value *= factorial (value - 1);
98 }
99 return (value);
100 }

```

stepi 或 si 或 stepi repeatCount

单步跟踪一条机器指令！一条程序代码有可能由数条机器指令完成，stepi 可以单步执行机器指令。It is often useful to do ‘display/i $pc’ when stepping by machine instructions. This makes gdb automatically display the next instruction to be executed, each time your program stops.

An argument is a repeat count, as in step.

nexti  
nexti repeatCount  
ni  
Execute one machine instruction, but if it is a function call, proceed until the

function returns.

An argument is a repeat count, as in next.

**九、信号（Signals）**

信号是一种软中断，是一种处理异步事件的方法。一般来说，操作系统都支持许多信号。尤其是 UNIX，比较重要应用程序一般都会处理信号。UNIX 定义了许多信号，比如 SIGINT 表示中断字符信号，也就是 Ctrl+C 的信号，SIGBUS 表示硬件故障的信号；SIGCHLD 表示子进程状态改变信号； SIGKILL 表示终止程序运行的信号，等等。信号量编程是 UNIX 下非常重要的一种技术。

GDB 有能力在你调试程序的时候处理任何一种信号，你可以告诉 GDB 需要处理哪一种信号。你可以要求 GDB 收到你所指定的信号时，马上停住正在运行的程序，以供你进行调试。你可以用 GDB 的 handle 命令来完成这一功能。

handle signal _[keywords...]  
_在 GDB 中定义一个信号处理。信号可以以 SIG 开头或不以 SIG 开头，可以用定义一个要处理信号的范围（如：SIGIO-SIGKILL，表示处理从 SIGIO 信号到 SIGKILL 的信号，其中包括 SIGIO，SIGIOT，SIGKILL 三个信号），也可以使用关键字 all 来标明要处理所有的信号。一旦被调试的程序接收到信号，运行程序马上会被 GDB 停住，以供调试。Optional arguments keywords, described below, say what change to make.

`nostop`

当被调试的程序收到信号时，GDB 不会停住程序的运行，但会打出消息告诉你收到这种信号。

`stop`

当被调试的程序收到信号时，GDB 会停住你的程序。This implies the print keyword as well.

print  
当被调试的程序收到信号时，GDB 会显示出一条信息。

noprint  
当被调试的程序收到信号时，GDB 不会告诉你收到信号的信息。This implies the nostop keyword as well.

pass  
noignore  
当被调试的程序收到信号时，GDB 不处理信号。这表示，GDB 会把这个信号交给被调试程序处理 or else it may terminate if the signal is fatal and not handled.

nopass  
ignore  
当被调试的程序收到信号时，GDB 不会让被调试程序来处理这个信号。

info signals  
info handle  
查看有哪些信号在被 GDB 检测中。

**十、线程（Thread Stops）**

如果你程序是多线程的话，你可以定义你的断点是否在所有的线程上，或是在某个特定的线程。GDB 很容易帮你完成这一工作。

break _linespec_ thread _threadno_  
break _linespec_ thread _threadno_ if ...  
linespec 指定了断点设置在的源程序的行号。threadno 指定了线程的 ID，注意，这个 ID 是 GDB 分配的，你可以通过 “info threads” 命令来查看正在运行程序中的线程信息。如果你不指定‘thread _threadno_ ’则表示你的断点设在所有线程上面。你还可以为某线程指定断点条件。如：

(gdb) break frik.c:13 thread 28 if bartab > lim

当你的程序被 GDB 停住时，所有的运行线程都会被停住。这方便你你查看运行程序的总体情况。而在你恢复程序运行时，所有的线程也会被恢复运行。那怕是主进程在被单步调试时。

8 查看栈信息  
The call stack is divided up into contiguous pieces called stack frames, or frames for short; each frame is the data associated with one call to one function. The frame contains the arguments given to the function, the function’s local variables, and the address at which the function is executing. When your program is started, the stack has only one frame, that of the function main. This is called the initial frame or the outermost frame. Each time a function is called, a new frame is made. Each time a function returns, the frame for that function invocation is eliminated. If a function is recursive, there can be many frames for the same function. The frame for the function in which execution is actually occurring is called the innermost

frame. This is the most recently created of all the stack frames that still exist.

Inside your program, stack frames are identified by their addresses. A stack frame

consists of many bytes, each of which has its own address; each kind of computer has a convention for choosing one byte whose address serves as the address of the frame. Usually this address is kept in a register called the frame pointer register while execution is going on in that frame. gdb assigns numbers to all existing stack frames, starting with zero for the innermost frame, one for the frame that called it, and so on upward. These numbers do not really exist in your program; they are assigned by gdb to give you a way of designating stack frames in gdb commands.

当程序被停住了，你需要做的第一件事就是查看程序是在哪里停住的。当你的程序调用了一个函数，函数的地址，函数参数，函数内的局部变量都会被压入 “栈”（Stack）中。你可以用 GDB 命令来查看当前的栈中的信息。

下面是一些查看函数调用栈信息的 GDB 命令：

backtrace  
bt  
打印当前的函数调用栈的所有信息。如：

```c
(gdb) bt
#0 func (n=250) at tst.c:6
#1 0x08048524 in main (argc=1, argv=0xbffff674) at tst.c:30
#2 0x400409ed in __libc_start_main () from /lib/libc.so.6
```

从上可以看出函数的调用栈信息：__libc_start_main --> main() --> func()

backtrace _n_  
bt _n_  
n 是一个正整数，表示只打印栈顶上 n 层的栈信息。  
backtrace _-n_  
bt _-n_

-n 表一个负整数，表示只打印栈底下 n 层的栈信息。

如果你要查看某一层的信息，你需要在切换当前的栈，一般来说，程序停止时，最顶层的栈就是当前栈，如果你要查看栈下面层的详细信息，首先要做的是切换当前栈。  
frame _n_  
n 是一个从 0 开始的整数，是栈中的层编号。比如：frame 0，表示栈顶，frame 1，表示栈的第二层。  
frame _addr_  
f addr Select the frame at address addr. This is useful mainly if the chaining of stack frames has been damaged by a bug, making it impossible for gdb to assign

numbers properly to all frames. In addition, this can be useful when your program has multiple stacks and switches between them.

up _n_  
表示向栈的上面移动 n 层，可以不打 n，表示向上移动一层。

down _n_  
表示向栈的下面移动 n 层，可以不打 n，表示向下移动一层。

上面的命令，都会打印出移动到的栈层的信息。如果你不想让其打出信息。你可以使用这三个命令：

select-frame 对应于 frame 命令。  
up-silently _n_ 对应于 up 命令。  
down-silently _n_ 对应于 down 命令。  
查看当前栈层的信息，你可以用以下 GDB 命令：  
frame 或 f  
会打印出这些信息：栈的层编号，当前的函数名，函数参数值，函数所在文件及行号，函数执行到的语句。  
info frame  
info f

This command prints a verbose description of the selected stack frame, including:

• the address of the frame

• the address of the next frame down (called by this frame)

• the address of the next frame up (caller of this frame)

• the language in which the source code corresponding to this frame is written

• the address of the frame’s arguments

• the address of the frame’s local variables

• the program counter saved in it (the address of execution in the caller  
frame)  
• which registers were saved in the frame

The verbose description is useful when something has gone wrong that has made

the stack format fail to fit the usual conventions.  
这个命令会打印出更为详细的当前栈层的信息，只不过，大多数都是运行时的内内地址。比如：函数地址，调用函数的地址，被调用函数的地址，目前的函数是由什么样的程序语言写成的、函数参数地址及值、局部变量的地址等等。如：

```c
(gdb) info f
Stack level 0, frame at 0xbffff5d4:
eip = 0x804845d in func (tst.c:6); saved eip 0x8048524
called by frame at 0xbffff60c
source language c.
Arglist at 0xbffff5d4, args: n=250
Locals at 0xbffff5d4, Previous frame's sp is 0x0
Saved registers:
ebp at 0xbffff5d4, eip at 0xbffff5d8
```

info frame _addr_

info f _addr_

Print a verbose description of the frame at address addr, without selecting that

frame. The selected frame remains unchanged by this command. This requires the same kind of address (more than one for some architectures) that you specify

in the frame command.  
info args  
Print the arguments of the selected frame, each on a separate line.  
info locals  
打印出当前函数中所有局部变量及其值。

info catch  
打印出当前的函数中的异常处理信息。

9 **显示源代码**  
一、**显示源代码**

GDB 可以打印出所调试程序的源代码，当然，在程序编译时一定要加上 –g 的参数，把源程序信息编译到执行文件中。不然就看不到源程序了。当程序停下来以后， GDB 会报告程序停在了那个文件的第几行上。你可以用 list 命令来打印程序的源代码。默认打印 10 行，还是来看一看查看源代码的 GDB 命令吧。

list _linenum_  
Print lines centered around line number linenum in the current source file.

list _function_  
显示函数名为 function 的函数的源程序。

list  
显示当前行后面的源程序。

list -  
显示当前行前面的源程序。  
一般是打印当前行的上 5 行和下 5 行，如果显示函数是是上 2 行下 8 行，默认是 10 行，当然，你也可以定制显示的范围，使用下面命令可以设置一次显示源程序的行数。  
set listsize _count_  
设置一次显示源代码的行数。(unless the list argument explicitly specifies some other number)

show listsize  
查看当前 listsize 的设置。  
list 命令还有下面的用法：  
list _first,last_  
Print lines from first to last. Both arguments are linespecs.

list _,last_  
显示从当前行到 last 行之间的源代码。

list +  
往后显示源代码。  
一般来说在 list 后面可以跟以下这们的参数：  
_number_  
Specifies line number of the current source file. When a list command has

two linespecs, this refers to the same source file as the first linespec.  
<+offset> 当前行号的正偏移量。  
<-offset> 当前行号的负偏移量。  
_filename:number_

Specifies line number in the source file filename.

_function_  
Specifies the line that begins the body of the function _function._

For example:

in C, this is the line with the open brace.

_filename:function_  
Specifies the line of the open-brace that begins the body of the function _function_

in the file _filename._ You only need the file name with a function name to avoid

ambiguity when there are identically named functions in different source files.

_*address_  
Specifies the line containing the program address _address_ . address may be any expression.

**二、编辑和搜索源代码**

Editing source files

Here are the forms of the edit command most commonly used:

edit  
Edit the current source file at the active line number in the program.  
edit _number_  
Edit the current source file with number as the active line number.  
edit _function_  
Edit the file containing function at the beginning of its definition.  
edit _filename:number_  
Specifies line number in the source file filename.  
edit _filename:function_  
Specifies the line that begins the body of the function _function_ in the file filename.

You only need the file name with a function name to avoid ambiguity

when there are identically named functions in different source files.  
edit _*address_  
Specifies the line containing the program address address. address may be any  
expression.

Choosing your editor  
You can customize gdb to use any editor you want. By default, it is ‘/bin/ex’, but you can change this by setting the environment variable EDITOR before using gdb. For example, to configure gdb to use the vi editor, you could use these commands with the sh shell:  
EDITOR=/usr/bin/vi  
export EDITOR

gdb ...

or in the csh shell,

setenv EDITOR /usr/bin/vi

gdb ...  
GDB 还提供了源代码搜索的命令：

There are two commands for searching through the current source file for a regular expression.

forward-search _regexp_

The command ‘forward-search _regexp_ ’ checks each line, starting with the

one following the last line listed, for a match for regexp. It lists the line that is found. You can use the synonym ‘search _regexp_ ’ or abbreviate the command name as fo.

reverse-search _regexp_

You can abbreviate this command as rev.

其中，regexp 是正则表达式。

**三、指定源文件的路径**

某些时候，用 - g 编译过后的执行程序中只是包括了源文件的名字，没有路径名。GDB 提供了可以让你指定源文件的路径的命令，以便 GDB 进行搜索。

Directory dirname ...  
dir dirname ...  
加一个源文件路径到当前路径的前面。如果你要指定多个路径，UNIX 下你可以使用 “:”，Windows 下你可以使用 “;”。

directory  
清除所有的自定义的源文件搜索路径信息。

show directories  
显示定义了的源文件搜索路径。

**四、源代码的内存**

你可以使用 info line 命令来查看源代码在内存中的地址。info line 后面可以跟 “行号”，“函数名”，“文件名: 行号”，“文件名: 函数名”，这个命令会打印出所指定的源码在运行时的内存地址，如：

```
(gdb) info line tst.c:func
Line 5 of "tst.c" starts at address 0x8048456 and ends at 0x804845d .

```

还有一个命令（disassemble）你可以查看源程序的当前执行时的机器码，这个命令会把目前内存中的指令 dump 出来。如下面的示例表示查看函数 func 的汇编代码。

```c
(gdb) disassemble func
Dump of assembler code for function func:
0x8048450 : push %ebp
0x8048451 : mov %esp,%ebp
0x8048453 : sub $0x18,%esp
0x8048456 : movl $0x0,0xfffffffc(%ebp)
0x804845d : movl $0x1,0xfffffff8(%ebp)
0x8048464 : mov 0xfffffff8(%ebp),%eax
0x8048467 : cmp 0x8(%ebp),%eax
0x804846a : jle 0x8048470
0x804846c : jmp 0x8048480
0x804846e : mov %esi,%esi
0x8048470 : mov 0xfffffff8(%ebp),%eax
0x8048473 : add %eax,0xfffffffc(%ebp)
0x8048476 : incl 0xfffffff8(%ebp)
0x8048479 : jmp 0x8048464
0x804847b : nop
0x804847c : lea 0x0(%esi,1),%esi
0x8048480 : mov 0xfffffffc(%ebp),%edx
0x8048483 : mov %edx,%eax
0x8048485 : jmp 0x8048487
0x8048487 : mov %ebp,%esp
0x8048489 : pop %ebp
0x804848a : ret
End of assembler dump.
```

**10** **查看运行时数据**  
在你调试程序时，当程序被停住时，你可以使用 print 命令（简写命令为 p），或是同义命令 inspect 来查看当前程序的运行数据。print 命令的格式是：  
print expr  
print /f expr  
print  
print /f

If you omit expr, gdb displays the last value again (from the value history). This allows you to conveniently inspect the same value in an alternative format.

/f 是输出的格式，比如，如果要把表达式按 16 进制的格式输出，那么就是 / x。

**一、表达式**

print 和许多 GDB 的命令一样，可以接受一个表达式，GDB 会根据当前的程序运行的数据来计算这个表达式，既然是表达式，那么就可以是当前程序运行中的 const 常量、变量、函数等内容。可惜的是 GDB 不能使用你在程序中所定义的宏。  
表达式的语法应该是当前所调试的语言的语法，由于 C/C++ 是一种大众型的语言，所以，这里的例子都是关于 C/C++ 的。  
在表达式中，有几种 GDB 所支持的操作符，它们可以用在任何一种语言中。  
@  
是一个和数组有关的操作符。  
::  
指定一个在文件或是一个函数中的变量。  
{type} addr

表示一个指向内存地址的类型为 type 的一个对象。

**二、程序变量**

在 GDB 中，你可以随时查看以下三种变量的值：

1、全局变量（所有文件可见的）  
2、静态全局变量（当前文件可见的）  
3、局部变量（当前 Scope 可见的）  
如果你的局部变量和全局变量发生冲突（也就是重名），一般情况下是局部变量会隐藏全局变量，也就是说，如果一个全局变量和一个函数中的局部变量同名时，如果当前停止点在函数中，用 print 显示出的变量的值会是函数中的局部变量的值。如果此时你想查看全局变量的值时，你可以使用 “::” 操作符：  
file::variable  
function::variable  
可以通过这种形式指定你所想查看的变量，是哪个文件中的或是哪个函数中的。例如，查看文件 f2.c 中的全局变量 x 的值：  
gdb) p‘f2.c'::x  
当然，“::”操作符会和 C++ 中的发生冲突，GDB 能自动识别 “::” 是否 C++ 的操作符，所以你不必担心在调试 C++ 程序时会出现异常。

另外，需要注意的是，如果你的程序编译时开启了优化选项，那么在用 GDB 调试被优化过的程序时，可能会发生某些变量不能访问，或是取值错误的情况。这个是很正常的，因为优化程序会删改你的程序，整理你程序的语句顺序，剔除一些无意义的变量等，所以在 GDB 调试这种程序时，运行时的指令和你所编写指令就有不一样，也就会出现你所想象不到的结果。对付这种情况时，需要在编译程序时关闭编译优化。一般来说，几乎所有的编译器都支持编译优化的开关，例如，GNU 的 C/C++ 编译器 GCC，你可以使用 “-gstabs” 选项来解决这个问题。关于编译器的参数，还请查看编译器的使用说明文档。

**三、数组**

有时候，你需要查看一段连续的内存空间的值。比如数组的一段，或是动态分配的数据的大小。你可以使用 GDB 的 “@” 操作符，“@”的左边是第一个内存的地址的值，“@”的右边则你你想查看内存的长度。例如，你的程序中有这样的语句：

int *array = (int *) malloc (len * sizeof (int));  
于是，在 GDB 调试过程中，你可以以如下命令显示出这个动态数组的取值：  
p _*array@len_  
@的左边是数组的首地址的值，也就是变量 array 所指向的内容，右边则是数据的长度，其保存在变量 len 中，其输出结果，大约是下面这个样子的：  
(gdb) p _*array@len_  
$1 = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40}  
如果是静态数组的话，可以直接用 print 数组名，就可以显示数组中所有数据的内容了。

**四、输出格式**

一般来说，GDB 会根据变量的类型输出变量的值。但你也可以自定义 GDB 的输出的格式。例如，你想输出一个整数的十六进制，或是二进制来查看这个整型变量的中的位的情况。要做到这样，你可以使用 GDB 的数据显示格式：

x 按十六进制格式显示变量。  
d 按十进制格式显示变量。  
u 按十六进制格式显示无符号整型。  
o 按八进制格式显示变量。  
t 按二进制格式显示变量。  
a 按十六进制格式显示变量。  
c 按字符格式显示变量。  
f 按浮点数格式显示变量。

```c
(gdb) p i
$21 = 101
 
(gdb) p/a i
$22 = 0x65
 
(gdb) p/c i
$23 = 101 'e'
 
(gdb) p/f i
$24 = 1.41531145e-43
 
(gdb) p/x i
$25 = 0x65
 
(gdb) p/t i
$26 = 1100101
```

For example,to print the program counter in hex  
p/x $pc

**五、查看内存**

你可以使用 examine 命令（简写是 x）来查看内存地址中的值。x 命令的语法如下所示：

You can use the command x (for “examine”) to examine memory in any of several formats, independently of your program’s data types.  
x/_nfu addr_  
x _addr_  
x Use the x command to examine memory.  
n、f、u 是可选的参数：

n 是一个正整数，表示显示内存的长度，也就是说从当前地址向后显示几个地址的内容。  
f 表示显示的格式，参见上面。如果地址所指的是字符串，那么格式可以是 s，如果地十是指令地址，那么格式可以是 i。  
u 表示从当前地址往后请求的字节数，如果不指定的话，GDB 默认是 4 个 bytes。u 参数可以用下面的字符来代替，b 表示单字节，h 表示双字节，w 表示四字节，g 表示八字节。当我们指定了字节长度后，GDB 会从指内存定的内存地址开始，读写指定字节，并把其当作一个值取出来。  
addr, starting display address

addr is the address where you want gdb to begin displaying memory.

For example, ‘x/3uh 0x54320’ is a request to display three halfwords (h) of memory,

formatted as unsigned decimal integers (‘u’), starting at address 0x54320.

‘x/4xw $sp’prints the four words (‘w’) of memory above the stack pointer in hexadecimal (‘x’).  
n/f/u 三个参数可以一起使用。例如：  
命令：x/3uh 0x54320 表示，从内存地址 0x54320 读取内容，h 表示以双字节为一个单位，3 表示三个单位，u 表示按十六进制显示。

**六、自动显示**

你可以设置一些自动显示的变量，当程序停住时，或是在你单步跟踪时，这些变量会自动显示。相关的 GDB 命令是 display。

display _expr_  
display_/fmt expr_  
display_/fmt addr_

expr 是一个表达式，fmt 表示显示的格式，addr 表示内存地址，当你用 display 设定好了一个或多个表达式后，只要你的程序被停下来，GDB 会自动显示你所设置的这些表达式的值。

格式 i 和 s 同样被 display 支持，一个非常有用的命令是：  
display/i $pc  
$pc 是 GDB 的环境变量，表示指令的地址，/i 则表示输出格式为机器指令码，也就是汇编。于是当程序停下后，就会出现源代码和机器指令码相对应的情形，这是一个很有意思的功能。

下面是一些和 display 相关的 GDB 命令：

undisplay _dnums..._  
delete display _dnums..._  
删除自动显示，dnums 意为所设置好了的自动显式的编号。如果要同时删除几个，编号可以用空格分隔，如果要删除一个范围内的编号，可以用减号表示（如：2-5）  
disable display _dnums..._  
enable display _dnums..._  
disable 和 enalbe 不删除自动显示的设置，而只是让其失效和恢复。  
info display  
查看 display 设置的自动显示的信息。GDB 会打出一张表格，向你报告当然调试中设置了多少个自动显示设置，其中包括，设置的编号，表达式，是否 enable。

**七、设置显示选项**

GDB 中关于显示的选项比较多，这里只列举大多数常用的选项。

set print address  
set print address on  
打开地址输出，当程序显示函数信息时，GDB 会显出函数的参数地址。系统默认为打开的，如：

```c
(gdb) f
#0 set_quotes (lq=0x34c78 "<<", rq=0x34c88 ">>")
at input.c:530
530 if (lquote != def_lquote)
```

set print address off  
关闭函数的参数地址显示，如：

```c
(gdb) set print addr off
(gdb) f
#0 set_quotes (lq="<<", rq=">>") at input.c:530
530 if (lquote != def_lquote)
```

`show print address `

查看当前地址显示选项是否打开。  

`set print array `

`set print array on`  

打开数组显示，打开后当数组显示时，每个元素占一行，如果不打开的话，每个元素则以逗号分隔。这个选项默认是关闭的。与之相关的两个命令如下。  

`set print array off `

`show print array`

set print elements _number-of-elements_  
这个选项主要是设置数组的，如果你的数组太大了，那么就可以指定一个来指定数据显示的最大长度，当到达这个长度时，GDB 就不再往下显示了。如果设置为 0，则表示不限制。 

`show print elements ` 

查看 `print elements` 的选项信息。

`set print null-stop` 

如果打开了这个选项，那么当显示字符串时，遇到结束符则停止显示。这个选项默认为 off。

`set print pretty on `

如果打开 printf pretty 这个选项，那么当 GDB 显示结构体时会比较漂亮。如：  
$1 = {  
next = 0x0,  
flags = {  
sweet = 1,  
sour = 1  
},  
meat = 0x54 "Pork"  
}  
set print pretty off  
关闭 printf pretty 这个选项，GDB 显示结构体时会如下显示：  
$1 = {next = 0x0, flags = {sweet = 1, sour = 1}, meat = 0x54 "Pork"}  
show print pretty  
查看 GDB 是如何显示结构体的。

set print sevenbit-strings on  
Print using only seven-bit characters; if this option is set, gdb displays any

eight-bit characters (in strings or character values) using the notation \nnn.

This setting is best if you are working in English (ascii) and you use the highorder

bit of characters as a marker or “meta” bit.

set print sevenbit-strings off

Print full eight-bit characters. This allows the use of more international character

sets, and is the default.

show print sevenbit-strings  
查看字符显示开关是否打开。  
set print union _on|off_  
设置显示结构体时，是否显式其内的联合体数据。例如有以下数据结构：  
typedef enum {Tree, Bug} Species;

typedef enum {Big_tree, Acorn, Seedling} Tree_forms;

typedef enum {Caterpillar, Cocoon, Butterfly} Bug_forms;

struct thing {  
Species it;  
union {  
Tree_forms tree;  
Bug_forms bug;  
} form;  
};  
struct thing foo = {Tree, {Acorn}};  
当打开这个开关时，执行 p foo 命令后，会如下显示：  
$1 = {it = Tree, form = {tree = Acorn, bug = Cocoon}}  
当关闭这个开关时，执行 p foo 命令后，会如下显示：  
$1 = {it = Tree, form = {...}}

show print union  
查看联合体数据的显示方式

set print object  
set print object _on|off_  
在 C++ 中，如果一个对象指针指向其派生类，如果打开这个选项，GDB 会自动按照虚方法调用的规则显示输出，如果关闭这个选项的话，GDB 就不管虚函数表了。这个选项默认是 off。  
show print object  
查看对象选项的设置。

set print static-members  
set print static-members _on|off_  
这个选项表示，当显示一个 C++ 对象中的内容是，是否显示其中的静态数据成员。默认是 on。  
show print static-members  
查看静态数据成员选项设置。

set print vtbl  
set print vtbl _on|off_  
当此选项打开时，GDB 将用比较规整的格式来显示虚函数表时。其默认是关闭的。  
show print vtbl  
查看虚函数显示格式的选项。

**八、历史记录**

当你用 GDB 的 print 查看程序运行时的数据时，你每一个 print 都会被 GDB 记录下来。GDB 会以 $1, $2, $3 ..... 这样的方式为你每一个 print 命令编上号。于是，你可以使用这个编号访问以前的表达式，如 $1。这个功能所带来的好处是，如果你先前输入了一个比较长的表达式，如果你还想查看这个表达式的值，你可以使用历史记录来访问，省去了重复输入。

show values

Print the last ten values in the value history, with their item numbers. This is

like ‘p $$9’ repeated ten times, except that show values does not change the  
history.  
show values _n_

Print ten history values centered on history item number n.

show values +

Print ten history values just after the values last printed. If no more values are

available, show values + produces no display.

**九、GDB 环境变量**

你可以在 GDB 的调试环境中定义自己的变量，用来保存一些调试程序中的运行数据。要定义一个 GDB 的变量很简单只需使用 GDB 的 set 命令。GDB 的环境变量和 UNIX 一样，也是以 $ 起头。如：  
set $foo = *object_ptr  
使用环境变量时，GDB 会在你第一次使用时创建这个变量，而在以后的使用中，则直接对其賦值。环境变量没有类型，你可以给环境变量定义任一的类型。包括结构体和数组。  
show convenience  
该命令查看当前所设置的所有的环境变量。

这是一个比较强大的功能，环境变量和程序变量的交互使用，将使得程序调试更为灵活便捷。例如：

set $i = 0  
print bar[$i++]->contents

于是，当你就不必，print bar[0]->contents, print bar[1]->contents 地输入命令了。输入这样的命令后，只用敲回车，重复执行上一条语句，环境变量会自动累加，从而完成逐个输出的功能。

**十、查看寄存器**

要查看寄存器的值，很简单，可以使用如下命令：  
info registers  
查看寄存器的情况。（除了浮点寄存器）  
info all-registers  
查看所有寄存器的情况。（包括浮点寄存器）  
info registers _regname ..._

查看所指定的寄存器的情况。

寄存器中放置了程序运行时的数据，比如程序当前运行的指令地址（ip），程序的当前堆栈地址（sp）等等。你同样可以使用 print 命令来访问寄存器的情况，只需要在寄存器名字前加一个 $ 符号就可以了。如：p $eip。

**十一、改变程序的执行**

一旦使用 GDB 挂上被调试程序，当程序运行起来后，你可以根据自己的调试思路来动态地在 GDB 中更改当前被调试程序的运行线路或是其变量的值，这个强大的功能能够让你更好的调试你的程序，比如，你可以在程序的一次运行中走遍程序的所有分支。  
**1** **修改变量值**

修改被调试程序运行时的变量值，在 GDB 中很容易实现，使用 GDB 的 print 命令即可完成。如：  
(gdb) print x=4  
x=4 这个表达式是 C/C++ 的语法，意为把变量 x 的值修改为 4，如果你当前调试的语言是 Pascal，那么你可以使用 Pascal 的语法：x:=4。

在某些时候，很有可能你的变量和 GDB 中的参数冲突，如：

(gdb) whatis width  
type = double  
(gdb) p width  
$4 = 13  
(gdb) set width=47  
Invalid syntax in expression.  
因为，set width 是 GDB 的命令，所以，出现了 “Invalid syntax in expression” 的设置错误，此时，你可以使用 set var 命令来告诉 GDB，width 不是你 GDB 的参数，而是程序的变量名，如：  
(gdb) set var width=47  
另外，还可能有些情况，GDB 并不报告这种错误，所以保险起见，在你改变程序变量取值时，最好都使用 set var 格式的 GDB 命令。

**2** **跳转执行**

一般来说，被调试程序会按照程序代码的运行顺序依次执行。GDB 提供了乱序执行的功能，也就是说，GDB 可以修改程序的执行顺序，可以让程序执行随意跳跃。这个功能可以由 GDB 的 jump 命令来完：  
jump _linespec_  
指定下一条语句的运行点。可以是文件的行号，可以是 file:line 格式，可以是 + num 这种偏移量格式。表示下一条运行语句从哪里开始。  
jump _*address_  
这里的是代码行的内存地址。  
注意，jump 命令不会改变当前的程序栈中的内容，所以，当你从一个函数跳到另一个函数时，当函数运行完返回时进行弹栈操作时必然会发生错误，可能结果还是非常奇怪的，甚至于产生程序 Core Dump。所以最好是同一个函数中进行跳转。

熟悉汇编的人都知道，程序运行时，eip 寄存器用于保存当前代码所在的内存地址。所以，jump 命令也就是改变了这个寄存器中的值。于是，你可以使用 “set $pc” 来更改跳转执行的地址。如：

set $pc = 0x485

**3** **产生信号量**

使用 singal 命令，可以产生一个信号量给被调试的程序。如：中断信号 Ctrl+C。这非常方便于程序的调试，可以在程序运行的任意位置设置断点，并在该断点用 GDB 产生一个信号量，这种精确地在某处产生信号非常有利程序的调试。

语法是：  
signal _signal_  
UNIX 的系统信号量通常从 1 到 15。所以取值也在这个范围。

single 命令和 shell 的 kill 命令不同，系统的 kill 命令发信号给被调试程序时，是由 GDB 截获的，而 single 命令所发出一信号则是直接发给被调试程序的。

**4** **强制函数返回**

如果你的调试断点在某个函数中，并还有语句没有执行完。你可以使用 return 命令强制函数忽略还没有执行的语句并返回。  
return  
return _expression_

使用 return 命令取消当前函数的执行，并立即返回，如果指定了，那么该表达式的值会被认作函数的返回值。

**5** **强制调用函数**

call _expr_  
表达式中可以一是函数，以此达到强制调用函数的目的。并显示函数的返回值，如果函数返回值是 void，那么就不显示。

print _expr_  
另一个相似的命令也可以完成这一功能——print，print 后面可以跟表达式，所以也可以用他来调用函数，print 和 call 的不同是，如果函数返回 void，call 则不显示，print 则显示函数返回值，并把该值存入历史数据中。

**十二、在不同语言中使用 GDB**

GDB 支持下列语言：C, C++, Fortran, PASCAL, Java, Chill, assembly, 和 Modula-2。一般说来，GDB 会根据你所调试的程序来确定当然的调试语言，比如：发现文件名后缀为 “.c” 的，GDB 会认为是 C 程序。文件名后缀为 “.C, .cc, .cp, .cpp, .cxx, .c++”的，GDB 会认为是 C++ 程序。而后缀是 “.f, .F” 的，GDB 会认为是 Fortran 程序，还有，后缀为如果是 “.s, .S” 的会认为是汇编语言。  
也就是说，GDB 会根据你所调试的程序的语言，来设置自己的语言环境，并让 GDB 的命令跟着语言环境的改变而改变。比如一些 GDB 命令需要用到表达式或变量时，这些表达式或变量的语法，完全是根据当前的语言环境而改变的。例如 C/C++ 中对指针的语法是 * p，而在 Modula-2 中则是 p^。并且，如果你当前的程序是由几种不同语言一同编译成的，那到在调试过程中，GDB 也能根据不同的语言自动地切换语言环境。这种跟着语言环境而改变的功能，真是体贴开发人员的一种设计。

下面是几个相关于 GDB 语言环境的命令：

show language  
查看当前的语言环境。如果 GDB 不能识为你所调试的编程语言，那么，C 语言被认为是默认的环境。

info frame  
查看当前函数的程序语言。

info source  
查看当前文件的程序语言。

如果 GDB 没有检测出当前的程序语言，那么你也可以手动设置当前的程序语言。使用 set language 命令即可做到。

当 set language 命令后什么也不跟的话，你可以查看 GDB 所支持的语言种类：

```c
(gdb) set language
The currently understood settings are:
 
local or auto Automatic setting based on source file
c Use the C language
c++ Use the C++ language
asm Use the Asm language
chill Use the Chill language
fortran Use the Fortran language
java Use the Java language
modula-2 Use the Modula-2 language
pascal Use the Pascal language
scheme Use the Scheme language
```

于是你可以在 set language 后跟上被列出来的程序语言名，来设置当前的语言环境。

后记

GDB 是一个强大的命令行调试工具。大家知道命令行的强大就是在于，其可以形成执行序列，形成脚本。UNIX 下的软件全是命令行的，这给程序开发提代供了极大的便利，命令行软件的优势在于，它们可以非常容易的集成在一起，使用几个简单的已有工具的命令，就可以做出一个非常强大的功能。

于是 UNIX 下的软件比 Windows 下的软件更能有机地结合，各自发挥各自的长处，组合成更为强劲的功能。而 Windows 下的图形软件基本上是各自为营，互相不能调用，很不利于各种软件的相互集成。在这里并不是要和 Windows 做个什么比较，所谓 “寸有所长，尺有所短”，图形化工具还是有不如命令行的地方。（看到这句话时，希望各位千万再也不要认为我就是 “鄙视图形界面”，和我抬杠了 ）

我是根据版本为 5.1.1 的 GDB 所写的这篇文章，所以可能有些功能已被修改，或是又有更为强劲的功能。而且，我写得非常仓促，写得比较简略，并且，其中我已经看到有许多错别字了（我用五笔，所以错字让你看不懂），所以，我在这里对我文中的差错表示万分的歉意。

文中所罗列的 GDB 的功能时，我只是罗列了一些带用的 GDB 的命令和使用方法，其实，我这里只讲述的功能大约只占 GDB 所有功能的 60% 吧，详细的文档，还是请查看 GDB 的帮助和使用手册吧，或许，过段时间，如果我有空，我再写一篇 GDB 的高级使用。

我个人非常喜欢 GDB 的自动调试的功能，这个功能真的很强大，试想，我在 UNIX 下写个脚本，让脚本自动编译我的程序，被自动调试，并把结果报告出来，调试成功，自动 checkin 源码库。一个命令，编译带着调试带着 checkin，多爽啊。只是 GDB 对自动化调试目前支持还不是很成熟，只能实现半自动化，真心期望着 GDB 的自动化调试功能的成熟。

如果各位对 GDB 或是别的技术问题有兴趣的话，欢迎和我讨论交流。本人目前主要在 UNIX 下做产品软件的开发，所以，对 UNIX 下的软件开发比较熟悉，当然，不单单是技术，对软件工程实施，软件设计，系统分析，项目管理我也略有心得。欢迎大家找我交流，（QQ 是：753640，MSN 是：haoel@hotmail.com）

RelatedEntries：  
文件操作 - 10 28, 2003  
OSW:12.CVS 设置与应用 - 10 28, 2003  
MySQL AB Acquires Alzato - 10 24, 2003  
cvs - 10 24, 2003  
使用 CVS 进行版本管理 - 10 23, 2003


> 参考

* 来源：[http://blog.csdn.net/dadalan/archive/2009/01/12/3758025.aspx](http://blog.csdn.net/dadalan/archive/2009/01/12/3758025.aspx)
* GDB调试 [gdb](https://sourceware.org/gdb/)
* mex [Mex](https://ww2.mathworks.cn/help/releases/R2018b/matlab/ref/mex.html?searchHighlight=mex&s_tid=doc_srchtitle)