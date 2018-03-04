---
layout: post
title: ONOS架构中的YANG、P4 Runtime（GNTC 2017演讲整理，附PPT下载）
date: 2017-12-15 19:00:00 +0800
comments: true
categories: SDN ONOS P4
excerpt: ONOS架构中的YANG、P4 Runtime
---

> **作者简介：{{ site.Resume }}**
> 
> **研究方向：{{ site.Major }}**
> 
> **SDNLAB 文章发表：[https://www.sdnlab.com/20348.html](https://www.sdnlab.com/20348.html)**

　　很荣幸收到天地互连主办方和ONF组织的邀请，让我能够在2017年GNTC全球网络技术大会上，做了题为“ONOS架构中的YANG、P4 Runtime”的演讲。非常感谢各位工作人员对我的帮助与支持。

<br />

![MaoGNTC_1280](/resources/picture/2017/12/onosYangP4/MaoGNTC_1280.JPG)

<br />

　　演讲中，我首先为大家解析了ONOS的架构设计和设计考量。然后，分析了ONOS新引入的基于YANG模型的动态配置能力，这使得ONOS能够管理和控制传统的路由和交换设备。接着，讲解了ONOS对协议无关思想的支持，目前ONOS针对P4 Runtime进行建模抽象和适配。最后，介绍了ONOS开源全球社区和中文社区的联系方式与基本情况。

　　以下是演讲胶片以及根据现场视频修正过的演讲文案，经过主办方同意，我在这里分享给大家。ONOS方面的中文资料还比较少，希望这次整理和分享能帮助大家更清晰地了解ONOS内部及其最新进展，摆脱对大系统的迷茫感，更多地参与到ONOS社区中来。

　　由于演讲时间的要求，讲解上有所侧重，如果有理解不清的地方，欢迎朋友们在社区里交流，也可以在文末留言评论。排版上大体遵循讲解文字位于对应胶片下方的规则。

　　配合官方演讲视频学习，效果更佳：[https://v.qq.com/x/page/g05184tpwqb.html](https://v.qq.com/x/page/g05184tpwqb.html)

<br />

![1](/resources/picture/2017/12/onosYangP4/1.png)

<br />

　　各位朋友们大家好, 我是毛健炜，来自北京邮电大学，未来网络理论与应用实验室，刘韵洁院士团队，现在是一名研二的研究生。今天非常有幸作为ONOS大使的一员，代表ONF组织，在这里跟大家讨论ONOS的最新进展，希望我们都能够有所收获。

<br />

![2](/resources/picture/2017/12/onosYangP4/2.png)

<br />

　　今天我们先简单介绍一下ONOS的基本情况和它的设计架构，之后，我们再讨论一下ONOS对YANG和动态配置的支持，以及对P4 Runtime的支持。最后再介绍一下ONOS开源社区的情况。

<br />

![3](/resources/picture/2017/12/onosYangP4/3.png)

<br />

　　ONOS，全称是开放网络操作系统，通常以控制器的身份为人所知。
它是由ON.LAB组织发起的一个开源项目，在与ONF组织合并之后，现在由ONF组织进行管理。ONOS从13年开始进行平台的原型设计，到14年十二月发布了第一个正式版本。ONOS采用了敏捷开发、持续集成的软件工程思想，不断迭代，大体上每个季度会发布一个新版本，在今年的九月十五号，已经迭代到了1.11版本，社区以一种L字母开头的鸟类为它命名，也称为Loon版本。

　　ONOS在设计之初，就瞄准了服务提供商网络，也就是运营商网络，这个从基础设施到业务形态再到性能要求都极具复杂性和挑战性的级别。它把自己定位成一个运营商网络的控制平台，可以应用于运营商网络的各个层面，从核心的广域骨干网，到城域网，蜂窝无线接入网，再到有线接入和汇聚网，等等。

<br />

![4](/resources/picture/2017/12/onosYangP4/4.png)

<br />

![5](/resources/picture/2017/12/onosYangP4/5.png)

<br />

>　　针对运营商网络的需求，ONOS规定了这么四条设计原则：
>*　　首要的是，高可用性，高可扩展性和高性能。这三点对运营商网络来说是尤为重要的。
>*　　第二，要对网络资源进行高度抽象并简练地表示出来；
>*　　第三，要做到协议无关以及对特定设备的驱动功能的无关；
>*　　最后，是整个控制器系统的模块化，这一点保证了整个控制器软件架构的稳定性以及在支持新业务新需求方面的灵活性。

<br />

![6](/resources/picture/2017/12/onosYangP4/6.png)

<br />

　　在分析了运营商各类网络的复杂性和需求之后，ONOS从一开始就给自己标定了这样一个关键的性能要求，先定一个小目标。一方面，要有高吞吐率。要能够支持每秒钟在网络中建立上百万条的流路径，要能够支持每秒钟高达六百万次的网络操作。另一方面，要有高容量，能够装下多达1TB的网络运行数据。这对软件控制器来说是很有挑战的。

<br />

![7](/resources/picture/2017/12/onosYangP4/7.png)

<br />

　　针对运营商这样的网络需求、性能要求，并结合前面的设计原则，ONOS做出了这样的架构设计：

　　整体来看，从上到下平行地分为五层，其中最下面两层红色的部分通常把它统称为南向协议插件层。在这一层上实现诸如OpenFlow、NetConf这些直接跟设备进行通信的协议插件，它们负责跟设备打交道。

　　往上，依次是南向接口、核心层、北向接口，以及我们针对业务需求开发的网络控制应用，比如ARP代理、Segment Routing分段路由、SDN-IP这个SDN与传统网络对接的应用等等。

　　核心层将各种网元设备与它们的转发表、统计信息等统一进行抽象，通过北向接口向应用提供这些信息，然后应用利用这些信息去进行业务决策，并通过北向接口把决策告诉给我们的ONOS。最后，核心层把决策解析成命令，通过南向接口适配到相应的协议插件上，最终将命令下发给特定的设备。

　　其中，我们看到，核心层写着Distributed，分布式的，没错，ONOS天生就是一个分布式集群化的软件控制器，既可以单点部署，也可以多点集群部署。

<br />

![8](/resources/picture/2017/12/onosYangP4/8.png)

<br />

　　集群部署时，虽然数据是分片冗余存储的，但是从业务逻辑和控制功能的角度上看，每一个节点都是完全相同，是互为冗余备份的。不同节点既可以分管多个设备，也可以负载均衡地去处理北向来的业务请求。如果有一个节点宕机，其他节点会自然接管工作。
　　下面，我们把每一层展开，看一下。

<br />

![9](/resources/picture/2017/12/onosYangP4/9.png)

<br />

　　首先大家请看中间红色方框框住的部分，这就是我们的Core核心层。在这里要给大家介绍一个概念，Subsystem，子系统。之前我们提到ONOS的模块化，ONOS把内部的各个功能都进行了模块分块，大家看到的红色和灰色的每一个小方块都是一个子系统，左边灰色的部分是跟软件运行相关的基础性功能，比如说Application应用管理子系统、Cluster集群管理子系统。右边红色的部分是跟网络功能相关的内容，像有Device设备子系统、Statistics统计信息子系统。

　　特别要提一下的是第二行这个Driver设备驱动子系统。不同厂商、不同型号的设备能够支持的功能是不一样的，同一种功能在不同设备上的具体操作也有差异，这些device-specific特定于设备的东西，统统被隔离、囊括到Driver子系统里面去了，这样这些差异性就不会在整个系统里扩散。

　　这个红色框里的每一个小方块，都遵从统一的子系统设计架构，大家请看。

<br />

![10](/resources/picture/2017/12/onosYangP4/10.png)

<br />








　　本文撰稿时最新源码版本为1.10.0-SNAPSHOT，2017.03.13。<sup>[1]</sup>

　　笔者正在未来网络、软件设计的学习之路上步步前行，一点浅见，还望朋友们多多指点，不吝赐教 :)


　　以上是ONOS的架构设计图<sup>[2]</sup>。Core层包含了设备管理、拓扑管理、数据流管理和网络意图管理等功能，它们共同构成了ONOS的核心。每种功能都被独立设计成一个子系统，遵循右图中的架构设计，并行扩展。

　　图中，左侧Core层对应着右侧的Manager Component，橘黄色的方格是给各个ONOS App提供的北向接口，绿色的是给各个南向协议插件Provider提供的南向接口，蓝色的是在集群环境中，多个节点上的同一子系统之间通信的接口。

　　下面让我们走进Core的世界 :)

　　好的架构设计可能不会让问题更容易解决，但它让问题不会发生。

　　Core在设计上首先遵循了“针对接口编程，不针对实现编程”的面向对象设计原则[3]。将子系统提供的服务功能抽象成接口，呈现给顶层的应用和底层的协议插件。这样做有两个优势：

　　其一，实现了不同功能模块的解耦。顶层和底层在使用子系统提供的功能时，只需要了解系统能为其做什么，不需关心系统怎么去做。当子系统内部的实现需要升级或替换整个子系统模块时，顶层和底层看到的接口是始终不变的，因而不需要做任何的修改。

　　其二，顶层应用和底层协议插件是不同类别的模块，应用是为了实现特定的应用场景或网络功能，协议插件是为了支持控制器与网络设备进行信息传递。因此面向二者可以将接口划分为两类，面向应用的Service和面向协议插件的Provider。另外，应用这个范畴本身也可以分为两类，一类服务于网络功能，比如运行某种路由算法，进行某种虚拟化的信息管理和配置映射；另一类担当着网管的角色，比如下线某台设备，切断某条链路。由此，管理功能又从Service中抽离出来，成为AdminService。二者就像是user和root的关系，通常AdminService会直接继承Service。不同种类的接口自成不同的功能集，这些接口的功能可能是由同一个系统模块去实现。顶层和底层，需要子系统提供的功能不同，自然只需要使用不同的接口。这样既避免了对系统其他部分产生干扰的可能，减小故障定位的难度，也避免了开发者同时面对众多功能函数时心生迷惑。

　　下面以设备子系统为例具体讲解，Device Subsystem的Manager Component声明如下：

<br />

![Device-Manager-Component-Declaration](/resources/picture/2017/03/onosSubsystemCore/2-Device-Manager-Component-Declaration.png)

<br />

> 核心DeviceManager：
> 
> * 实现了以下四个接口：
> 
> 　　　　1. Service　→　DeviceService
> 
> 　　　　2. AdminService　→　DeviceAdminService
> 
> 　　　　3. ProviderRegistry　→　DeviceProviderRegistry
> 
> 　　　　4. 额外　→　PortConfigOperatorRegistry
> 
> * 通过内部类InternalDeviceProviderService实现了接口：
> 
> 　　　　ProviderService　→　DeviceProviderService
> 
> * 继承了一个抽象类AbstractListenerProviderRegistry

　　Service提供了获取系统所管理的内容及其详细信息的能力，并且引入了事件机制，允许添加异步监听器Listener。通过DeviceService能获取具体设备和端口的类对象，它还包含了获取设备的各类信息的接口，如设备数量、设备端口统计信息和设备控制权信息等。

　　AdminService提供了相比于Service而言更高级别的管理能力。通过DeviceAdminService我们不仅仅能够获取设备的信息，还能够命令设备下线、改变设备端口的启用状态等。

　　ProviderRegistry使各种Provider能够将自身注册进子系统，以便向系统提供数据，接受系统的指令去完成特定的工作。DeviceProviderRegistry提供了简单的注册/注销功能。

　　ProviderService使各种Provider能够主动、异步地将最新数据提交给子系统。通过DeviceProviderService，Provider能够上报设备上下线事件、上报设备控制权变更结果、提交端口统计信息等。DeviceManager通过内部类InternalDeviceProviderService实现了该接口。

　　另外，Provider接口是由数据提供者去实现，是提供给Manager Component使用的，让数据提供者能够接受系统的指令去完成特定的工作。这个数据提供者通常指南向协议插件。通过DeviceProvider能够告知南向协议插件本集群节点是否对某一设备具有控制权，能够检测设备是否依然在线，能够询问某一种南向协议插件是否与设备建立了协议连接等。

　　由于DeviceManager在Listener和Provider的管理上没有特殊的要求，就直接继承了包含通用的管理功能的AbstractListenerProviderRegistry类。

　　最后，由于设备子系统自身的工作需要，额外实现了PortConfigOperatorRegistry接口，供读写设备端口配置的模块使用。该接口目前仅被操作光设备的App使用。

　　各接口和内部类的详细定义如下图：

<br />

![Device-Subsystem-detailed-Declaration-of-Interfaces-and-Classes](/resources/picture/2017/03/onosSubsystemCore/3-Device-Subsystem-detailed-Declaration-of-Interfaces-and-Classes.png)

<br />

　　Core层的基本功能架构可由如下类图做简单回顾：

<br />

![UML-of-Core-Device-Subsystem](/resources/picture/2017/03/onosSubsystemCore/4-UML-of-Core-Device-Subsystem.png)

<br />

　　一点浅见，还望朋友们多多指点，不吝赐教 :)

　　下一回，《神秘的Store接口和集群事件机制》，各位看官，欲知后续如何，请听下回分解…

<br />

# 参考文献

[1] [ONOS官方Git库](https://gerrit.onosproject.org)：git clone https://gerrit.onosproject.org/onos

[2] [ONOS Wiki：System Components](https://wiki.onosproject.org/display/ONOS/System+Components)

[3] 《Head First设计模式（中文版）》，P11，面向对象设计原则

<br />
