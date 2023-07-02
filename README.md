# nju-logic
本仓库是个人对于[南京大学 计算机科学与技术系 数字逻辑与计算机组成 课程实验](https://nju-projectn.github.io/dlco-lecture-note/index.html)的部分完成记录。

```
nju-logic
├── lab1
│   ├── mux21（sim）
│   └── mux41（nvboard）
├── lab2
│   ├── decode38（sim）
│   └── top（nvboard）
├── lab3
│   └── alu（nvboard）
├── lab6
│   ├── random（nvboard）
│   └── shift（nvboard）
├── lab7
│   ├── FSM_bin（sim）
│   └── ps2（nvboard）
├── Makefile
└── README.md
```

每个工程的测试可以分为两种类型：波形仿真（sim）和板上验证（nvboard），二者的命令均放在根目录下的Makefile中，分别举例如下：

```bash
sim：		make sim LAB=lab1 MODULE=mux21
nvboard：	make sim LAB=lab1 MODULE=mux41
```

