# 聚类分析

> Matlab [聚类算法-学习笔记](聚类算法-学习笔记)汇总自2018年的个人博客

定义：把数据对象划分成子集的过程，每个子集是一个簇，使得簇中的对象彼此相似，但与其他簇中对象彼此相异。
形成聚类的原则就是：使类内部的相似性最大，类间的相似性最小。

Matlab代码列表：

* k-均值（k-means）及Matlab静态实现
* k-均值（k-means）及Matlab动态实现
* k-中心点（k-medoids）及Matlab实现
* DBSCAN算法-Matlab实现
* Chameleon算法-Matlab实现
* CURE算法-Matlab实现
* ROCK算法-Matlab实现

#### 划分的方法（基于距离的）

1. k-均值（k-means）

2. k-中心点（k-medoids）

#### 基于层次的方法

3. BIRCH算法

4. ROCK算法

5. CURE算法

6. Chameleon算法

#### 基于密度的方法

7. DBscan算法

8. Optics算法

#### 基于网格的方法

待定...


# 算法分析

### k-均值（k-means）

注：1.仅适合于数值属性的数据。
2.对正态分布（高斯分布）数据聚类效果最佳。。

##### 算法思想

k-means算法，也称k-均值算法，它把N个对象划分成k个簇，用簇中对象的均值表示每个簇的中心点（质心），通过迭代使每个簇内的对象不再发生变化为止，此时的平方误差准则函数达到最优，即簇内对象相似度高，簇间相似度低。其具体过程描述如下：

* 首先，随机选择k个对象，代表要分成的k个簇的初始均值或中心。
* 计算其余对象与各个均值的欧式距离，找到距离最短的对象，将其分配到距离中心最近的簇中。
* 计算每个簇中所有对象的平均值(均值)，作为每个簇的新的中心。
* 再次计算所有对象与新的k个中心的欧式距离，根据**"距离中心最近原则”** ,重新划分所有对象到各个簇中。
* 重复3）4）步骤，直至所有簇中心不变为止。（即本轮生成的簇与上一轮生形成的簇相同）。聚类结束。

 * [博客链接](https://blog.csdn.net/qiu1440528444/article/details/80611942/) （k-均值（k-means））         

 
### k-中心点（k-medoids）

##### 算法思想

迭代选出簇中位置最中心的对象，试图将N个对象给出k个划分。

具体：
* 最初随机选择k个对象作为中心点，并代表初始簇，然后根据欧氏距离划分其余所有对象到各个中心点所代表的簇，得到初始簇划分。
* 该算法反复利用数据D中所有非代表对象来替换当前代表对象，试图找出更好的中心点，以改进聚类质量。 中心点也叫代表对象，其他对象叫非代表对象。
* 在每次迭代中，所有可能的对象都被分析，每一对替换中的一个对象是中心点，而另一个是非代表对象。如果一个当前的中心点被一个非代表对象所替换，代价函数将计算平方误差值所产生的差别；替换的总代价是所有非中心对象去替换所产生的代价之和。
* 如果总代价为负值，则实际的平方误差将会减少，则代表对象Oi可被非代表对象Oh替换。

 * [博客链接](https://blog.csdn.net/qiu1440528444/article/details/80693820/) （k-medoids） 
 
### DBSCAN算法

##### 算法思想

* 由密度可达关系导出的最大密度相连的样本集合，为最终簇。
* 对于给定的数据集D，首先给定参数ε和Minpts。
* 任意访问一个未读取过的对象点，根据ε和Minpts判断是否是核心对象，如果不是核心对象就是边界点或噪声点。
* 若是核心对象，则找到这个核心对象能够密度可达的所有样本集合，即为一个聚类簇。
* 再访问其他未被读取过的核心对象去寻找密度可达的样本集合，此时得到另一个簇，一直运行直到所有核心对象都被访问过为止。

 * [博客链接](https://blog.csdn.net/qiu1440528444/article/details/80763420/) （DBSCAN算法） 


### Chameleon算法

##### 算法思想

* 首先由数据集构造一个 k-最近邻图 Gk；
* 再通过一种图的划分算法，将Gk图划分成大量较小的子图，每个子图代表一个初始的子簇；
* 最后使用凝聚层次聚类算法，基于子簇的相似度反复合并子簇。
* 为引出Chameleon变色龙算法的一些定义，先说一下以往的聚类算法的不足之处：

* 忽略簇与簇之间的互联性

* 互联性：簇间距离较近的数据对之间的数量，即临接区域的大小。

* 忽略簇与簇之间的近似性

* 近似性：簇间数据对的相似度，即不同簇的对象间最近距离。

 * [博客链接](https://blog.csdn.net/qiu1440528444/article/details/80725142/) （Chameleon算法） 


### CURE算法

##### 算法思想

* CURE算法是凝聚层次聚类，最开始，每个对象是一个独立的类簇，并从最相似的对象进行合并。
* 为了处理大数据集，采用随机抽样和分割手段。分割是把样本分割成几个部分，然后针对每个部分中的对象分别进行聚类，形成子类，再针对子类进行聚类，形成新的类。
* 传统的算法采用一个对象来代表一个类簇，而CURE算法由分散的若干对象，在按收缩因子移动向其所在类的中心之后来代表该类。由于CURE采用多个对象代表一个类，并通过收缩因子来调节类的形状，因此能够处理非球形的对象分布。
* 分两个阶段消除异常值得影响。CURE算法由于异常值同其他对象的距离更大，所以其所在类中对象数目的增大就会非常缓慢，甚至不增长。第一阶段，将聚类过程中增长非常缓慢的类作为异常值删除。第二阶段，在聚类结束的时候将数目明显少的类作为异常值除去。
* 由于CURE算法采用多个对象代表一个类，因此采用更合理的非样本对象分配策略。在完成对样本聚类后，各个类中只包含有样本对象，还需要将非样本对象按一定策略分配到相应的类中。

 * [博客链接](https://blog.csdn.net/qiu1440528444/article/details/80761686/) （CURE算法） 


### ROCK算法

##### 算法思想
* 基于划分的k-means等算法是聚类大数据集的算法，它处理的数据对象仅限于数值型数据。而实际中大多数数据库和大的数据集不仅包括数值类型的数据，而且包括非数值型数据。如，布尔型（二值型），名义型，被称为分类属性数据。
* 分类属性数据的属性是有限和无序的，且不能比较大小，数据间缺乏一种合理的相似度量，因此用于数值型的聚类算法不适合于处理分类属性数据。
* 对于包含布尔和分类属性的数据，传统算法使用的距离函数度量不能产生高质量的簇。
* 此外，大多数算法在进行聚类时只估计点与点之间的相似度，也即，在每一步中那些最相似的点合并到一个簇中，这种“局部”方法很容易导致错误。

 * [博客链接](https://blog.csdn.net/qiu1440528444/article/details/80752750/) （ROCK算法） 


### BIRCH算法

##### 算法思想

* 通过聚类特征树(CF-Tree)对所有对象进行层次划分；

* 将建立的CF-Tree进行筛选，去除一些异常CF节点;

* 用其他聚类算法对所有CF元祖进行聚类，得到一棵好的CF-Tree;
 
* 利用生成的CF-Tree的所有CF节点的质心，作为初始质心，对所有样本点按距离远近进行聚类。

注：算法的关键是CF-Tree的建立，其他步骤是为了优化最后的聚类结果。


